-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local function clone_paq()
    local path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
        return true
    end
end

local function bootstrap_paq(packages)
    local first_install = clone_paq()
    vim.cmd.packadd "paq-nvim"
    local paq = require "paq"
    if first_install then
        vim.notify "Installing plugins... If prompted, hit Enter to continue."
    end

    -- Read and install packages
    paq(packages)
    paq.install()
end

bootstrap_paq {
    -- Let Paq manage itself
    "savq/paq-nvim",

    -- Fuzzy search
    "ibhagwan/fzf-lua",

    -- File management
    "nvim-tree/nvim-tree.lua",
    "stevearc/oil.nvim",

    -- Code formatting
    "stevearc/conform.nvim",

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

-- Set Python3 provider
vim.g.python3_host_prog = vim.fn.expand "$XDG_DATA_HOME" .. "/pyenv/shims/python"

-- Disable some rtp plugins for improved perf
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Enable the experimental Lua module loader
vim.loader.enable()

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Map space to no-op" })

-- Load plugins
for _, plugin in pairs(vim.split(vim.fn.glob(vim.fn.stdpath "config" .. "/lua/plugin/*"), "\n")) do
    require("plugin/" .. vim.fn.fnamemodify(plugin, ":t:r"))
end
