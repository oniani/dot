local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone --depth 1 " .. repo .. " " .. path)
    vim.cmd.packadd("packer.nvim")
end

require("packer").startup({
    function(use)
        -- Plugin manager
        use("wbthomason/packer.nvim")

        -- Productivity
        use("numToStr/Comment.nvim")
        use("nvim-treesitter/nvim-treesitter")
        use("stevearc/aerial.nvim")
        use({ "junegunn/fzf.vim", requires = { "junegunn/fzf", run = ":call fzf#install()" } })

        -- LSP
        use("williamboman/mason-lspconfig.nvim")
        use("williamboman/mason.nvim")
        use("neovim/nvim-lspconfig")
        use("onsails/lspkind-nvim")
        use({ "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-nvim-lsp" } })
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/cmp-cmdline")
        use("hrsh7th/cmp-path")
        use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } })

        -- Visuals
        use("rebelot/kanagawa.nvim")

        -- When bootstrapping the configuration, syncing is needed to properly install the plugins
        if is_bootstrap then
            require("packer").sync()
        end
    end,
})

if is_bootstrap then
    print("====================================")
    print("    Plugins are being installed.")
    print("    Wait until Packer completes,")
    print("        then restart nvim.")
    print("====================================")
    return
end
