-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.pack.add {
    -- Fuzzy search
    { src = "https://github.com/ibhagwan/fzf-lua" },

    -- File management
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/stevearc/oil.nvim" },

    -- Code formatting
    { src = "https://github.com/stevearc/conform.nvim" },

    -- Syntax highlighting, code navigation, and indentation
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvimdev/indentmini.nvim" },

    -- Git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },

    -- LSP
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },

    -- LSP: Autocompletion
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1.6.0",
        opts = { fuzzy = { implementation = "prefer_rust_with_warning" } },
    },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
}

-- Enable the experimental Lua module loader
vim.loader.enable()

-- Set Python3 provider
vim.g.python3_host_prog = vim.fn.expand "$XDG_DATA_HOME"
    .. "/mise/installs/python/3.13.5/bin/python3"

-- Disable some rtp plugins for perf improvement
vim.g.did_install_default_menus = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Map space to no-op" })

-- Load plugins
for _, plugin in pairs(vim.split(vim.fn.glob(vim.fn.stdpath "config" .. "/lua/plugin/*"), "\n")) do
    require("plugin/" .. vim.fn.fnamemodify(plugin, ":t:r"))
end
