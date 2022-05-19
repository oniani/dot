-- Autoinstall packer.nvim {{{

-- Specify path and repository
local path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone packer.nvim
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.cmd(string.format("!git clone --depth 1 %s %s", repo, path))
end

-- Required since packer.nvim is in opt pack
vim.cmd("packadd packer.nvim")

-- }}}

-- Plugins and related settings {{{

return require("packer").startup({
    function(use)
        -- NOTE: packer.nvim can manage itself
        use({ "wbthomason/packer.nvim", opt = true })

        -- Productivity
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        })
        use({
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = {
                vim.keymap.set("n", "<Leader>g", "<Cmd>Neogit<CR>", { noremap = true }),
            },
        })
        use({
            "junegunn/fzf.vim",
            { "junegunn/fzf", run = ":call fzf#install()" },
            config = {
                vim.keymap.set("n", "<Leader>f", "<Cmd>Files<CR>", { noremap = true }),
                vim.keymap.set("n", "<Leader>l", "<Cmd>Lines<CR>", { noremap = true }),
                vim.keymap.set("n", "<Leader>r", "<Cmd>Rg<CR>", { noremap = true }),
            },
        })
        use({
            "nvim-treesitter/nvim-treesitter",
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
            "rebelot/kanagawa.nvim",
            config = function()
                vim.cmd("colorscheme kanagawa")
                vim.cmd("hi! Normal guibg=none")
            end,
        })
    end,
})

-- }}}
