local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
    },
    event = "BufReadPre",
}

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true })
    end

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("T", vim.lsp.buf.signature_help, "Signature Documentation")

    nmap("dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
    nmap("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
    nmap("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

    nmap("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("rn", vim.lsp.buf.rename, "[R]e[n]ame")

    vim.api.nvim_buf_create_user_command(bufnr, "F", function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "LSP: Format current buffer" })

    -- Autocompletion Colors
    local accent_color = "#8ba8f0"
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = accent_color, bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = "black", bg = accent_color })
    vim.api.nvim_set_hl(0, "PmenuThumb", { fg = "none", bg = accent_color })

    -- Borders (override globally)
    local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- Customizing how diagnostics are displayed
    vim.diagnostic.config {
        virtual_text = false,
    }

    -- Change diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Go-to definition in a split window
    local function goto_definition(split_cmd)
        local util = vim.lsp.util
        local log = require "vim.lsp.log"
        local api = vim.api

        local handler = function(_, result, ctx)
            if result == nil or vim.tbl_isempty(result) then
                local _ = log.info() and log.info(ctx.method, "No location found")
                return nil
            end

            if split_cmd then
                vim.cmd(split_cmd)
            end

            if vim.tbl_islist(result) then
                util.jump_to_location(result[1])

                if #result > 1 then
                    util.set_qflist(util.locations_to_items(result))
                    api.nvim_command "copen"
                    api.nvim_command "wincmd p"
                end
            else
                util.jump_to_location(result)
            end
        end

        return handler
    end

    vim.lsp.handlers["textDocument/definition"] = goto_definition "vsplit"
end

local fmt = function(lang)
    local cmd = ""
    if lang == "lua" then
        cmd = "stylua --column-width 100 --indent-type spaces --call-parentheses None -"
    elseif lang == "markdown" then
        cmd = "prettier --print-width 100 --stdin-filepath ${INPUT}"
    elseif lang == "python" then
        cmd = "black --fast --line-length 100 -"
    end
    return { formatCommand = cmd, formatStdin = true }
end

local settings = {
    bashls = {},
    clangd = {},
    efm = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { fmt "lua" },
            markdown = { fmt "markdown" },
            python = { fmt "python" },
        },
    },
    gopls = {},
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

M.config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("fidget").setup {}
    require("mason").setup {}
    local lspconfig = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"

    mason_lspconfig.setup { ensure_installed = vim.tbl_keys(settings) }
    mason_lspconfig.setup_handlers {
        function(server_name)
            lspconfig[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = settings[server_name],
                init_options = { documentFormatting = true },
            }
        end,
    }

    local cmp = require "cmp"
    local lspkind = require "lspkind"
    local luasnip = require "luasnip"

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local cond = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
        return col ~= 0 and cond == nil
    end

    cmp.setup {
        experimental = { ghost_text = true },
        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    latex_symbols = "[LaTeX]",
                },
            },
        },
        mapping = cmp.mapping.preset.insert {
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
                elseif has_words_before() then
                    cmp.complete()
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
        },
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
    }

    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

return M
