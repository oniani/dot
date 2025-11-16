-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP configuration on attach",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local lsp_keymap_set = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        lsp_keymap_set("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        lsp_keymap_set("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        lsp_keymap_set("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        lsp_keymap_set("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        vim.diagnostic.config { jump = { float = true } }
        lsp_keymap_set("dl", vim.diagnostic.setqflist, "[D]iagnostic [L]ist")
        lsp_keymap_set("dn", function()
            vim.diagnostic.jump { count = 1 }
        end, "[D]iagnostic [N]ext")
        lsp_keymap_set("dp", function()
            vim.diagnostic.jump { count = -1 }
        end, "[D]iagnostic [P]revious")
        lsp_keymap_set("ds", vim.diagnostic.open_float, "[D]iagnostic [S]how")

        lsp_keymap_set("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        lsp_keymap_set("rn", vim.lsp.buf.rename, "[R]e[N]ame")

        lsp_keymap_set("K", vim.lsp.buf.hover, "Hover Documentation")

        local border = { border = "single" }
        vim.diagnostic.config { float = border, virtual_text = false }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, border)

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            lsp_keymap_set("<C-h>", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "Toggle Inlay [H]ints")
        end

        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

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
    ty = {},
}

require("mason").setup { ui = { border = "single" } }
require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }

local blink = require "blink.cmp"
blink.setup {
    completion = {
        documentation = { auto_show = true },
        menu = {
            border = "single",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    },
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

local capabilities = {
    textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
}
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

for server_name, _ in pairs(servers) do
    -- NOTE: 'ty' LSP server does not support init_options or settings
    if server_name == "ty" then
        vim.lsp.config[server_name] = { capabilities = capabilities }
    elseif server_name == "clangd" then
        vim.lsp.config[server_name] = {
            capabilities = capabilities,
            settings = servers[server_name].settings or {},
            init_options = {
                documentFormatting = true,
                settings = (servers[server_name].init_options or {}).settings or {},
                fallbackFlags = { "-std=c++23" },
            },
        }
    else
        vim.lsp.config[server_name] = {
            capabilities = capabilities,
            settings = servers[server_name].settings or {},
            init_options = {
                documentFormatting = true,
                settings = (servers[server_name].init_options or {}).settings or {},
            },
        }
    end
    vim.lsp.enable(server_name)
end
