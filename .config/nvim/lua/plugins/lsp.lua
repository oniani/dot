-- Options to be set when attaching a language server {{{

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "T", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "cn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "dl", "<Cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "dn", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "dp", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "dr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ta", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded", close_events = { "BufHidden", "CursorMoved", "InsertCharPre" } }
    )

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup AutoFormat
                autocmd!
                autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]])
    end
end

-- }}}

-- Language server configurations and settings {{{

-- Configure efm language server
local efm_config = {
    filetypes = { "lua", "markdown", "python" },
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = {
                {
                    formatCommand = "stylua --column-width 100 --indent-type Spaces -",
                    formatStdin = true,
                },
            },
            markdown = {
                {
                    formatCommand = "prettier --print-width 100 --stdin-filepath ${INPUT}",
                    formatStdin = true,
                },
            },
            python = { { formatCommand = "black --line-length 100 -", formatStdin = true } },
        },
    },
}

-- Configure sumneko_lua language server
local sumneko_lua_settings = {
    Lua = {
        runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
        },
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        },
    },
}

-- Makes a custom config with the snippet support
local function make_config(server_name, on_attach_config, engine)
    local capabilities = engine.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local config = { capabilities = capabilities, on_attach = on_attach_config }
    if server_name == "efm" then
        config.filetypes = efm_config.filetypes
        config.init_options = efm_config.init_options
        config.settings = efm_config.settings
    elseif server_name == "sumneko_lua" then
        config.settings = sumneko_lua_settings
    end
    return config
end

-- }}}

-- Set up nvim-cmp {{{

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    experimental = { ghost_text = true },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
                path = "[Path]",
                latex_symbols = "[LaTeX]",
            },
        }),
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this wont work anymore)
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this wont work anymore)
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- }}}

-- Use LSP configurations to set up the servers {{{

local lsp_installer = require("nvim-lsp-installer")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local server_names = {
    "bashls",
    "clangd",
    "cmake",
    "efm",
    "gopls",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
}

for _, server_name in ipairs(server_names) do
    local ok, server = lsp_installer.get_server(server_name)
    if ok then
        if not server:is_installed() then
            server:install()
        end
    end
    server:setup(make_config(server_name, on_attach, cmp_nvim_lsp))
end

-- }}}
