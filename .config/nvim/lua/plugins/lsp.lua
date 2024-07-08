return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "j-hui/fidget.nvim",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",

        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
    },
    config = function()
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
            tsserver = {},
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
    end
}
