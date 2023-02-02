local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "ms-jpq/coq_nvim",
    },
}

local on_attach = function(_, bufnr)
    local lsp_keymap_set = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true })
    end

    lsp_keymap_set("K", vim.lsp.buf.hover, "Hover Documentation")
    lsp_keymap_set("T", vim.lsp.buf.signature_help, "Signature Documentation")
    lsp_keymap_set("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    lsp_keymap_set("dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
    lsp_keymap_set("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
    lsp_keymap_set("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
    lsp_keymap_set("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    lsp_keymap_set("rn", vim.lsp.buf.rename, "[R]e[n]ame")

    vim.api.nvim_buf_create_user_command(bufnr, "F", function()
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "LSP: [F]ormat Current Buffer" })

    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#16161d", bg = "#16161d" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#16161d" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#16161d" })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = "black", bg = "#8ba8f0" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#8ba8f0" })

    vim.diagnostic.config {
        float = { border = "rounded" },
        virtual_text = false,
    }

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { numhl = hl, text = icon, texthl = hl })
    end
end

local f = function(cmd)
    return { formatCommand = cmd, formatStdin = true }
end

local server_settings = {
    bashls = {},
    clangd = {},
    efm = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { f "stylua --column-width 100 --indent-type spaces --call-parentheses None -" },
            markdown = { f "prettier --print-width 100 --stdin-filepath ${INPUT}" },
            python = { f "black --fast --line-length 100 -" },
        },
    },
    pyright = {},
    rust_analyzer = {},
    sumneko_lua = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

vim.g.coq_settings = {
    auto_start = "shut-up",
    clients = { snippets = { warn = {} } },
}

M.config = function()
    require("fidget").setup {}
    require("mason").setup {}

    local lspconfig = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"
    local coq = require "coq"

    mason_lspconfig.setup { ensure_installed = vim.tbl_keys(server_settings) }
    mason_lspconfig.setup_handlers {
        function(server)
            lspconfig[server].setup(coq.lsp_ensure_capabilities {
                on_attach = on_attach,
                settings = server_settings[server],
                init_options = { documentFormatting = true },
            })
        end,
    }
end

return M
