-- Installs packer.nvim and plugins {{{
local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone --depth 1 " .. repo .. " " .. path)
    vim.cmd("packadd packer.nvim")
end

-- Installs plugins
require("packer").startup({
    function(use)
        -- Plugin manager
        use "wbthomason/packer.nvim"

        -- Productivity
        use "numToStr/Comment.nvim"
        use "nvim-treesitter/nvim-treesitter"
        use { "junegunn/fzf.vim", requires = { "junegunn/fzf", run = ":call fzf#install()" } }

        -- Installs and manages external programs for LSP, formatting, etc.
        use "williamboman/mason.nvim"
        use "williamboman/mason-lspconfig.nvim"

        -- LSP
        use "neovim/nvim-lspconfig"
        use "onsails/lspkind-nvim"
        use { "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-nvim-lsp" } }
        use { "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } }
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-path"

        -- Visuals
        use "rebelot/kanagawa.nvim"
        use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }

        -- When bootstrapping the configuration, we need to sync to install the plugins
        if is_bootstrap then
            require("packer").sync()
        end
    end
})

if is_bootstrap then
    print "===================================="
    print "    Plugins are being installed."
    print "    Wait until Packer completes,"
    print "       then restart nvim."
    print "===================================="
    return
end

-- }}}

-- Comment.nvim {{{

require("Comment").setup()

-- }}}

-- nvim-treesitter {{{

require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    indent = { enable = true }
}

-- }}}

-- fzf.vim {{{

local opts = { noremap = true }

vim.keymap.set("n", "<Leader>c", "<Cmd>Commands<CR>", opts)
vim.keymap.set("n", "<Leader>f", "<Cmd>Files<CR>", opts)
vim.keymap.set("n", "<Leader>l", "<Cmd>Lines<CR>", opts)
vim.keymap.set("n", "<Leader>r", "<Cmd>Rg<CR>", opts)

-- }}}

-- lualine.nvim {{{

require("lualine").setup { options = { theme = "kanagawa" } }

-- }}}

-- kanagawa.nvim {{{

require("kanagawa").setup({ transparent = true })
vim.cmd("colorscheme kanagawa")

-- }}}

-- nvim-cmp {{{

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
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

    nmap("<Leader>dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
    nmap("<Leader>dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
    nmap("<Leader>df", vim.diagnostic.open_float, "[D]iagnostic [F]loat")
    nmap("<Leader>dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")

    nmap("<Leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("<Leader>gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

    nmap("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "Formats Current Buffer with LSP" })

    if client.server_capabilities.documentFormattingProvider then
        local auto_format = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePost", {
            command = ":Format",
            group = auto_format,
            pattern = "*",
        })
    end
end

-- }}}

-- Use LSP configurations to set up the servers {{{

local servers = { "bashls", "clangd", "efm", "gopls", "pyright", "rust_analyzer", "sumneko_lua" }

require("mason").setup()
require("mason-lspconfig").setup { ensure_installed = servers }

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
for _, server in ipairs(servers) do
    if server == "clangd" then
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            fallbackFlags = { "--std=c++20" },
        }
    elseif server == "efm" then
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "markdown", "python" },
            init_options = { documentFormatting = true },
            settings = {
                rootMarkers = { ".git/" },
                languages = {
                    markdown = { {
                        formatCommand = "prettier --print-width 100 --stdin-filepath ${INPUT}",
                        formatStdin = true,
                    } },
                    python = { {
                        formatCommand = "black --fast --line-length 100 -", formatStdin = true
                    } }
                }
            },
        }
    elseif server == "sumneko_lua" then
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = { indent_style = "space", indent_size = "4", }
                    },
                    runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
                    diagnostics = { globals = { "vim" } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            }
        }
    else
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
    end
end

-- }}}
