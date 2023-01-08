local path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    is_bootstrap = true
    vim.fn.system { "git", "clone", "--depth", "1", repo, path }
    vim.cmd.packadd "packer.nvim"
end

require("packer").startup(function(use)
    -- Plugin manager
    use "wbthomason/packer.nvim"

    -- Comment stuff out
    use "numToStr/Comment.nvim"

    -- Highlight, edit, and navigate code
    use "stevearc/aerial.nvim"
    use { "junegunn/fzf.vim", requires = { "junegunn/fzf", run = ":call fzf#install()" } }
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }

    -- Visuals
    use "rebelot/kanagawa.nvim"
    use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }
    use "lukas-reineke/indent-blankline.nvim"

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
        },
    }

    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
    }

    -- When bootstrapping the configuration, syncing is needed to properly install the plugins
    if is_bootstrap then
        require("packer").sync()
    end
end)

if is_bootstrap then
    print "===================================="
    print "    Plugins are being installed."
    print "    Wait until Packer completes,"
    print "        then restart nvim."
    print "===================================="
    return
end
