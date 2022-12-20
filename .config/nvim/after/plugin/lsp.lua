-- nvim-cmp {{{

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
        == nil
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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- }}}

-- `on_attach` {{{

local on_attach = function(client, bufnr)
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

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "LSP: Format current buffer" })

    if client.server_capabilities.documentFormattingProvider then
        local autofmt = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePost", {
            command = ":Format",
            group = autofmt,
            pattern = "*",
        })
    end
end

-- }}}

-- nvim-lspconfig {{{

require("fidget").setup {}
require("mason").setup {}

local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup {
    ensure_installed = {
        "bashls",
        "clangd",
        "efm",
        "gopls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
    },
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require "lspconfig"
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    if server == "clangd" then
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            fallbackFlags = { "--std=c++20" },
        }
    elseif server == "efm" then
        local fmt = function(cmd)
            return { formatCommand = cmd, formatStdin = true }
        end
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "lua", "markdown", "python" },
            init_options = { documentFormatting = true },
            settings = {
                rootMarkers = { ".git/" },
                languages = {
                    lua = {
                        fmt "stylua --column-width 100 --indent-type spaces --call-parentheses None -",
                    },
                    markdown = {
                        fmt "prettier --print-width 100 --stdin-filepath ${INPUT}",
                    },
                    python = {
                        fmt "black --fast --line-length 100 -",
                    },
                },
            },
        }
    elseif server == "sumneko_lua" then
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        }
    else
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end
end

-- }}}
