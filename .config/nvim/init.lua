-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.loop.fs_stat(path)
if not is_installed then
    vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
end
vim.cmd.packadd "paq-nvim"
local paq = require "paq"

paq {
    -- Let Paq manage itself
    "savq/paq-nvim",

    -- Fuzzy search
    "ibhagwan/fzf-lua",

    -- File management
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",

    -- Code formatting
    "stevearc/conform.nvim",

    -- Syntax highlighting, code navigation, and indentation
    "nvim-treesitter/nvim-treesitter",
    "nvimdev/indentmini.nvim",

    -- Git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",

    -- LSP
    "j-hui/fidget.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",

    -- LSP: Autocompletion
    { "saghen/blink.cmp", branch = "v1.2.0", pin = true },
    "rafamadriz/friendly-snippets",
}

if not is_installed then
    paq.install()
    return
end

-- Enable the experimental Lua module loader
vim.loader.enable()

-- Set Python3 provider
vim.g.python3_host_prog = vim.fn.expand "$XDG_DATA_HOME" .. "/pyenv/shims/python"

-- Disable some rtp plugins for improved perf
vim.g.did_install_default_menus = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Map space to no-op" })

-- Load plugins
for _, plugin in pairs(vim.split(vim.fn.glob(vim.fn.stdpath "config" .. "/lua/plugin/*"), "\n")) do
    require("plugin/" .. vim.fn.fnamemodify(plugin, ":t:r"))
end
