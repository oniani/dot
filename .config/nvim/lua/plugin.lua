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

    -- Fuzzy search
    "ibhagwan/fzf-lua",

    -- File management
    "nvim-tree/nvim-tree.lua",
    "stevearc/oil.nvim",

    -- Syntax highlighting and code navigation
    "nvim-treesitter/nvim-treesitter",

    -- Git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",

    -- LSP
    "j-hui/fidget.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",

    -- LSP: Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",

    -- Visuals
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    "rebelot/kanagawa.nvim",
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

-- Fuzzy search {{{

local fzf = require "fzf-lua"
vim.keymap.set("n", "<Leader>d", fzf.diagnostics_document, { desc = "LSP: Document [D]iagnostics" })
vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Find [F]iles" })
vim.keymap.set("n", "<Leader>l", fzf.lines, { desc = "Open [L]ines" })
vim.keymap.set("n", "<Leader>r", fzf.live_grep, { desc = "Search Terms via [R]g" })
vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

-- }}}

-- File management {{{

require "nvim-tree".setup {}
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "NvimLightGreen" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "NvimLightBlue" })
vim.keymap.set("n", "<C-n>", function() require "nvim-tree.api".tree.toggle({ focus = false }) end)

require("oil").setup { view_options = { show_hidden = true } }
vim.api.nvim_set_hl(0, "OilDir", { fg = "NvimLightBlue" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- }}}

-- Syntax highlighting and code navigation {{{

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "lua",
        "luadoc",
        "markdown",
        "python",
        "rust",
        "typescript",
        "vim",
        "vimdoc",
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
}
require("nvim-treesitter.install").prefer_git = true

-- }}}

-- Git {{{

local gitsigns = require "gitsigns"
gitsigns.setup {
    current_line_blame = true,
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
    },
}

-- }}}

-- Language server setup {{{

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

-- LSP: Autocompletion {{{

require("lspkind").init {}

local cmp = require "cmp"

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
        completion = { border = border, scrollbar = "║" },
        documentation = { border = border, scrollbar = "║" },
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

-- }}}

-- }}}

-- Visuals {{{

require("lualine").setup { }

require("kanagawa").setup { transparent = true }
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
vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", fg = "#76946a" })
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", fg = "#dca561" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { bg = "none", fg = "#dca561" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", fg= "#c34043" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#727169" })
vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "PMenu", { bg = "none", fg = "white" })
vim.api.nvim_set_hl(0, "PMenuSBar", { bg = "#ff9e3b", fg = "white" })
vim.api.nvim_set_hl(0, "PMenuSel", { bg = "none", fg = "#8ba8f0" })
vim.api.nvim_set_hl(0, "PMenuThumb", { bg = "#957fb8", fg = "#141414" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "WildMenu", { bg = "none", fg = "#141414" })

-- }}}
