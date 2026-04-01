-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

-- Enable the experimental Lua module loader
vim.loader.enable()

-- Disable some rtp plugins for perf improvement
local disabled_builtins = { "gzip", "netrw", "netrwPlugin", "tar", "tarPlugin", "zip", "zipPlugin" }
for _, name in ipairs(disabled_builtins) do
    vim.g["loaded_" .. name] = 1
end
vim.g.did_install_default_menus = 1

-- Set the leader key
vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Map space to no-op" })

-- Install packages
vim.pack.add({
    -- Fuzzy search
    { src = "https://github.com/ibhagwan/fzf-lua" },

    -- Asynchronous build and test dispatcher
    { src = "https://github.com/tpope/vim-dispatch" },

    -- File management
    { src = "https://github.com/lewis6991/fileline.nvim" },
    { src = "https://github.com/luukvbaal/nnn.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },

    -- Syntax highlighting, code navigation, and indentation
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvimdev/indentmini.nvim" },

    -- Git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },

    -- Nerd Font icons (glyphs)
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { confirm = false })

-- Command for updating all packages
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
    vim.cmd.write()
end, { desc = "Update all plugins" })
