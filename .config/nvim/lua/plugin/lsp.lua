-- Author: David Oniani <onianidavid@gmail.com>
-- License: MIT
-- Description: Neovim configuration file

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

        lsp_keymap_set("dl", vim.diagnostic.setqflist, "[D]iagnostic [L]ist")
        lsp_keymap_set("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
        lsp_keymap_set("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
        lsp_keymap_set("ds", vim.diagnostic.open_float, "[D]iagnostic [S]how")

        lsp_keymap_set("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        lsp_keymap_set("rn", vim.lsp.buf.rename, "[R]e[N]ame")

        lsp_keymap_set("K", vim.lsp.buf.hover, "Hover Documentation")

        local border_opt = { border = "single" }
        vim.diagnostic.config { float = border_opt, virtual_text = false }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opt)
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, border_opt)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            lsp_keymap_set("<C-h>", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "Toggle Inlay [H]ints")
        end

        if client and client.server_capabilities.documentHighlightProvider then
            local hi_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
                group = hi_augroup,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
                group = hi_augroup,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
                end,
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            })
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
    basedpyright = {
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
