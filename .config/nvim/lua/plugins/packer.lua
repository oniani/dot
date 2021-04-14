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
    -- `packer.nvim` can manage itself
    use { "wbthomason/packer.nvim", opt = true }

    -- Productivity
    use { "junegunn/fzf", run = ":call fzf#install()" }
    use "junegunn/fzf.vim"
    use "kyazdani42/nvim-tree.lua"
    use "tpope/vim-commentary"
    use "tpope/vim-fugitive"

    -- LSP
    use { "neoclide/coc.nvim", branch = "release" }

    -- Visuals
    use { "dracula/vim", as = "dracula" }
    use "hoob3rt/lualine.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- Parsers, highlighting, and incremental selection
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
end)
