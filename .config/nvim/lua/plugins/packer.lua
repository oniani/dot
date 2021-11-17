-- Plugins and related settings
return require("packer").startup({
    function(use)
        -- NOTE: packer.nvim can manage itself
        use({ "wbthomason/packer.nvim", opt = true })

        -- Productivity
        use("tpope/vim-commentary")
        use({
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = {
                vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>Neogit<CR>", { noremap = true }),
            },
        })
        use({
            "junegunn/fzf.vim",
            { "junegunn/fzf", run = ":call fzf#install()" },
            config = {
                vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Files<CR>", { noremap = true }),
                vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>Lines<CR>", { noremap = true }),
                vim.api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Rg<CR>", { noremap = true }),
            },
        })
        use({
            "nvim-treesitter/nvim-treesitter",
            branch = "0.5-compat",
            config = function()
                require("nvim-treesitter.configs").setup({
                    highlight = {
                        enable = true,
                    },
                })
            end,
            run = ":TSUpdate",
        })

        -- LSP
        use("neovim/nvim-lspconfig")
        use("onsails/lspkind-nvim")
        use("williamboman/nvim-lsp-installer")
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
            },
        })

        -- Visuals
        use({
            "RRethy/nvim-base16",
            config = function()
                vim.api.nvim_command("colorscheme base16-gruvbox-dark-hard")
            end,
        })
    end,
})
