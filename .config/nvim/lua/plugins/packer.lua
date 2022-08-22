-- Autoinstall packer.nvim {{{

-- Specify path and repository
local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone packer.nvim
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.cmd(string.format("!git clone --depth 1 %s %s", repo, path))
end

-- }}}

-- Plugins and related settings {{{

return require("packer").startup({
    function(use)
        -- NOTE: packer.nvim can manage itself
        use { "wbthomason/packer.nvim" }

        -- Productivity
        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = { vim.keymap.set("n", "<Leader>g", "<Cmd>Neogit<CR>", { noremap = true }) }
        }
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }
        use {
            "junegunn/fzf.vim",
            { "junegunn/fzf", run = ":call fzf#install()" },
            config = {
                vim.keymap.set("n", "<Leader>c", "<Cmd>Command<CR>", { noremap = true }),
                vim.keymap.set("n", "<Leader>f", "<Cmd>Files<CR>", { noremap = true }),
                vim.keymap.set("n", "<Leader>l", "<Cmd>Lines<CR>", { noremap = true }),
                vim.keymap.set("n", "<Leader>r", "<Cmd>Rg<CR>", { noremap = true })
            }
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
            end,
            run = ":TSUpdate"
        }

        -- LSP
        use "neovim/nvim-lspconfig"
        use "onsails/lspkind-nvim"
        use "williamboman/mason.nvim"
        use "williamboman/mason-lspconfig.nvim"
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip"
            }
        }

        -- Visuals
        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = function()
                require("lualine").setup { options = { theme = "kanagawa" } }
            end
        }
        use {
            "rebelot/kanagawa.nvim",
            config = function()
                require("kanagawa").setup({ transparent = true })
                vim.cmd("colorscheme kanagawa")
            end
        }
    end
})

-- }}}
