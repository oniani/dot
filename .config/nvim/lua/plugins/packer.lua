-- Autoinstall packer.nvim {{{

-- Specify path and repository
local path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone packer.nvim
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.api.nvim_command(string.format("!git clone --depth 1 %s %s", repo, path))
end

-- Required since packer.nvim is in opt pack
vim.api.nvim_command("packadd packer.nvim")

-- }}}

-- Plugins and related settings {{{

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
                require("base16-colorscheme").setup({
                    base00 = "#000000",
                    base01 = "#3c3836",
                    base02 = "#504945",
                    base03 = "#665c54",
                    base04 = "#bdae93",
                    base05 = "#d5c4a1",
                    base06 = "#ebdbb2",
                    base07 = "#fbf1c7",
                    base08 = "#fb4934",
                    base09 = "#fe8019",
                    base0A = "#fabd2f",
                    base0B = "#b8bb26",
                    base0C = "#8ec07c",
                    base0D = "#83a598",
                    base0E = "#d3869b",
                    base0F = "#d65d0e",
                })
            end,
        })
    end,
})

-- }}}
