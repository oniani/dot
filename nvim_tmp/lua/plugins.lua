-- Initialize the plugin system
return require('packer').startup(function()
    use {
        -- Activate `packer.nvim`
        { 'wbthomason/packer.nvim', opt = true }

        -- Productivity
        { 'junegunn/fzf', run = ':fzf#install' }
        'junegunn/fzf.vim',
        'junegunn/goyo.vim',
        'tpope/vim-commentary',
        'tpope/vim-fugitive',

        -- LSP support
        { 'neoclide/coc.nvim', branch = 'release' },

        -- Visuals
        'lifepillar/vim-gruvbox8',
        'nvim-treesitter/nvim-treesitter',
        'hoob3rt/lualine.nvim',
        'kyazdani42/nvim-web-devicons',
    }
end)
