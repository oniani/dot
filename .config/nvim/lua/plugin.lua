-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local is_bootstrap = false
local path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
local repo = "https://github.com/savq/paq-nvim.git"
if not vim.loop.fs_stat(path) then
    is_bootstrap = true
    vim.fn.system { "git", "clone", "--depth=1", repo, path }
    vim.cmd "packadd paq-nvim"
end

local packages = {
    -- Let Paq manage itself
    "savq/paq-nvim",

    -- Commenting
    "numToStr/Comment.nvim",

    -- Fuzzy search
    "ibhagwan/fzf-lua",

    -- File explorer
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",

    -- Syntax highlighting and code navigation
    "nvim-treesitter/nvim-treesitter",

    -- Visuals
    "rebelot/kanagawa.nvim",

    -- LSP
    "microsoft/python-type-stubs",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
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
}

local paq = require "paq"
paq(packages)

if is_bootstrap then
    paq.install()
    print "================================"
    print "  Plugins are being installed"
    print "    Wait till Paq completes,"
    print "      then restart nvim"
    print "================================"
    return
end

require("Comment").setup {}

local fzf = require "fzf-lua"
vim.keymap.set("n", "<Leader>f", fzf.files)
vim.keymap.set("n", "<Leader>l", fzf.lines)
vim.keymap.set("n", "<Leader>r", fzf.live_grep)
vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup {}
vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")

require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_decremental = "<BS>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
        },
    },
}

-- Color scheme
require("kanagawa").setup {}
vim.cmd.colorscheme "kanagawa"

vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#ff9e3b" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none", fg = "#e82424" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none", fg = "#6a9589" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none", fg = "#658594" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none", fg = "#ff9e3b" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#141414" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none", fg = "#141414" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none", fg = "#957FB8" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#727169" })
vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "PMenu", { bg = "none", fg = "white" })
vim.api.nvim_set_hl(0, "PMenuSBar", { bg = "#ff9e3b", fg = "white" })
vim.api.nvim_set_hl(0, "PMenuSel", { bg = "#8ba8f0", fg = "black" })
vim.api.nvim_set_hl(0, "PMenuThumb", { bg = "#957fb8", fg = "#141414" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "WildMenu", { bg = "none", fg = "#141414" })

-- LSP and Autocompletion {{{

local on_attach = function(_, bufnr)
    local lsp_keymap_set = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
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

    vim.diagnostic.config {
        float = { border = "single" },
        virtual_text = false,
    }
end

local f = function(cmd)
    return { formatCommand = cmd, formatStdin = true }
end

local server_settings = {
    bashls = {},
    clangd = {},
    cmake = {},
    efm = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { f "stylua --column-width 100 --indent-type spaces --call-parentheses None -" },
            markdown = { f "prettier --print-width 100 --stdin-filepath ${INPUT}" },
            python = { f "black --fast --line-length 100 -" },
        },
    },
    lua_ls = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    pyright = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
                stubPath = vim.fn.stdpath "data" .. "/site/pack/paqs/start/python-type-stubs",
            },
        },
    },
    rust_analyzer = {},
    texlab = {},
}

require("fidget").setup {}
require("mason").setup {}

local lspconfig = require "lspconfig"
local mason_lspconfig = require "mason-lspconfig"

local cmp_capabilities = require "cmp_nvim_lsp"
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_capabilities.default_capabilities(default_capabilities)

mason_lspconfig.setup { ensure_installed = vim.tbl_keys(server_settings) }
mason_lspconfig.setup_handlers {
    function(server)
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = server_settings[server],
            init_options = { documentFormatting = true },
        }
    end,
}

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

local border = {
    { "╭", "FoldColumn" },
    { "─", "FoldColumn" },
    { "╮", "FoldColumn" },
    { "│", "FoldColumn" },
    { "╯", "FoldColumn" },
    { "─", "FoldColumn" },
    { "╰", "FoldColumn" },
    { "│", "FoldColumn" },
}

cmp.setup {
    experimental = { ghost_text = true },
    formatting = {
        format = lspkind.cmp_format {
            menu = {
                nvim_lsp = "LSP",
                luasnip = "LuaSnip",
                buffer = "Buffer",
                path = "Path",
                latex_symbols = "LaTeX",
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
        completion = {
            border = border,
            scrollbar = "║",
        },
        documentation = {
            border = border,
            scrollbar = "║",
        },
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

-- }}}
