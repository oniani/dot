-- Access Vim API and functions
local api = vim.api
local fn = vim.fn

-- Specify the path and repository for `packer.nvim`
local path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone `packer.nvim` repositoru and and source any plugin files found
if fn.empty(fn.glob(path)) > 0 then
    api.nvim_command(string.format("!git clone %s %s", repo, path))
    api.nvim_command("packadd packer.nvim")
end

-- Required since `packer.nvim` is in `opt` pack
api.nvim_command("packadd packer.nvim")

-- Initialize the plugin system
return require("packer").startup(function()
    use {
        -- Activate `packer.nvim`
        { "wbthomason/packer.nvim", opt = true },

        -- Productivity
        { "junegunn/fzf", run = ":call fzf#install()" },
        "junegunn/fzf.vim",
        "kyazdani42/nvim-tree.lua",
        "tpope/vim-commentary",
        "tpope/vim-fugitive",

        -- LSP support
        { "neoclide/coc.nvim", branch = "release" },

        -- Visuals
        "dracula/vim",
        "hoob3rt/lualine.nvim",
        "kyazdani42/nvim-web-devicons",

        -- Parsing and related information
        "nvim-treesitter/nvim-treesitter",
    }
end)
