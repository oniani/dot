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
    ruff = {
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

require("mason").setup { ui = { border = "single" } }
require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }

local blink = require "blink.cmp"
blink.setup {
    completion = { documentation = { auto_show = true } },
    keymap = {
        ["<C-y>"] = { "select_and_accept" },
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
})

for server_name, _ in pairs(servers) do
    vim.lsp.config[server_name] = {
        capabilities = capabilities,
        settings = servers[server_name].settings or {},
        init_options = {
            documentFormatting = true,
            settings = (servers[server_name].init_options or {}).settings or {},
        },
    }
    vim.lsp.enable(server_name)
end
