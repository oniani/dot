-- Specify the path and repository for `packer.nvim`
local path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone `packer.nvim` repository and and source any plugin files found
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.api.nvim_command(string.format("!git clone --depth 1 %s %s", repo, path))
end

-- Required since `packer.nvim` is in `opt` pack
vim.api.nvim_command("packadd packer.nvim")

-- Initialize the plugin system
return require("packer").startup({
    function(use)
        -- `packer.nvim` can manage itself
        use({ "wbthomason/packer.nvim", opt = true })

        -- Productivity
        use("tpope/vim-commentary")
        use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
        use({ "junegunn/fzf.vim", { "junegunn/fzf", run = ":call fzf#install()" } })
        use({ "nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = ":TSUpdate" })

        -- LSP
        use("neovim/nvim-lspconfig")
        use("onsails/lspkind-nvim")
        use("williamboman/nvim-lsp-installer")
        use({
            "hrsh7th/nvim-cmp",
            requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path" },
        })
    end,
})
