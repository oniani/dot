-- Options to be set when attaching a language server {{{

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "T", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "dl", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "dn", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "dp", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "ta", vim.lsp.buf.code_action, opts)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded", close_events = { "BufHidden", "CursorMoved", "InsertCharPre" } }
    )

    if client.server_capabilities.documentFormattingProvider then
        local auto_format = vim.api.nvim_create_augroup("AutoFormat", { clear = true })

        vim.api.nvim_create_autocmd("BufWritePost", {
            command = "lua vim.lsp.buf.format { }",
            group = auto_format,
            pattern = "*",
        })

        vim.api.nvim_create_autocmd("BufWritePost", {
            command = "lua vim.lsp.buf.code_action { apply = true }",
            group = auto_format,
            pattern = "*.go",
        })
    end
end

-- }}}

-- Language server configurations and settings {{{

-- Configure efm language server
local efm_config = {
    filetypes = { "markdown", "python" },
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
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

-- }}}

-- Set up nvim-cmp {{{

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

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
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local lspinstaller = require("nvim-lsp-installer")

lspinstaller.setup {
    ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "efm",
        "gopls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
    },
    automatic_installation = true,
}

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, server in ipairs(lspinstaller.get_installed_servers()) do
    local server_name = server.name

    if server_name == "clangd" then
        lspconfig[server.name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            fallbackFlags = { "--std=c++20" },
        }
    elseif server_name == "efm" then
        lspconfig[server.name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = efm_config.filetypes,
            init_options = efm_config.init_options,
            settings = efm_config.settings,
        }
    elseif server_name == "sumneko_lua" then
        lspconfig[server.name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = sumneko_lua_settings,
        }
    else
        lspconfig[server.name].setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
    end
end

-- }}}
