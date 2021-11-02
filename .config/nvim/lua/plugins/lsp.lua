-- Options to be set when attaching a language server
local on_attach = function(client, bufnr)
    local function keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }

    keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "T", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "cn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap("n", "dl", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    keymap("n", "dn", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    keymap("n", "dp", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "dr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec(
            [[
            augroup AutoFormat
                autocmd!
                autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]],
            false
        )
    end
end

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
local function make_config(server_name, on_attach, engine)
    local capabilities = engine.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local config = { capabilities = capabilities, on_attach = on_attach }
    if server_name == "efm" then
        config.filetypes = efm_config.filetypes
        config.init_options = efm_config.init_options
        config.settings = efm_config.settings
    elseif server_name == "sumneko_lua" then
        local sumneko_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server"
        local sumneko_binary = sumneko_path .. "/bin/Linux/lua-language-server"
        if vim.fn.has("macunix") then
            sumneko_binary = sumneko_path .. "/bin/macOS/lua-language-server"
        end
        config.cmd = { sumneko_binary, "-E", sumneko_path .. "/main.lua" }
        config.settings = sumneko_lua_settings
    end
    return config
end

-- Set up nvim-cmp
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

-- Use buffer source for `/` (if you enabled `native_menu`, this wont work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this wont work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Use LSP configurations to set up the servers
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
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
    lspconfig[server_name].setup(make_config(server_name, on_attach, cmp_nvim_lsp))
end
