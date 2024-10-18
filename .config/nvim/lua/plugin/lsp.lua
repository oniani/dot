-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local servers = {
    bashls = {},
    clangd = {},
    cmake = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim" } },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_size = "4",
                        indent_style = "space",
                        max_line_length = "100",
                    },
                },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false },
            },
        },
    },
    pyright = {
        settings = {
            pyright = { disableOrganizeImports = true },
            python = { analysis = { ignore = { "*" } } },
        },
    },
    ruff_lsp = {
        init_options = {
            settings = {
                format = { args = { "--line-length", "100" } },
                lint = { args = { "--line-length", "100" } },
            },
        },
    },
    rust_analyzer = {},
    texlab = {},
    ts_ls = {},
}

require("fidget").setup {}
require("lspconfig.ui.windows").default_options.border = "single"
require("mason").setup { ui = { border = "single" } }

local lspconfig = require "lspconfig"
local mason_lspconfig = require "mason-lspconfig"

local cmp_capabilities = require "cmp_nvim_lsp"
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_capabilities.default_capabilities(default_capabilities)

mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = servers[server_name].settings or {},
            init_options = {
                documentFormatting = true,
                settings = (servers[server_name].init_options or {}).settings or {},
            },
        }
    end,
}

require("lspkind").init {}

local cmp = require "cmp"

cmp.setup {
    experimental = { ghost_text = true },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<TAB>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<S-TAB>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    window = {
        completion = { border = "single", scrollbar = "║" },
        documentation = { border = "single", scrollbar = "║" },
    },
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
