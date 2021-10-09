-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = { noremap = true }

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
api.nvim_set_keymap("n", "<Leader><Leader>", "<C-^>", opts)

-- Run the built-in spell checker
api.nvim_set_keymap("n", "<Leader>s", "<Cmd>setlocal spell! spl=en_us<CR>", opts)

-- Toggle line wrapping
api.nvim_set_keymap("n", "<Leader>w", "<Cmd>set wrap!<CR>", opts)

-- Make Y similar to C, D, etc.
api.nvim_set_keymap("n", "Y", "y$", opts)

-- Buffer navigation
api.nvim_set_keymap("n", "<C-n>", "<Cmd>bn<CR>", opts)
api.nvim_set_keymap("n", "<C-p>", "<Cmd>bp<CR>", opts)

-- Window navigation
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
api.nvim_set_keymap("n", "<Down>", "<Cmd>res -5<CR>", opts)
api.nvim_set_keymap("n", "<Left>", "<Cmd>vert resize +5<CR>", opts)
api.nvim_set_keymap("n", "<Right>", "<Cmd>vert resize -5<CR>", opts)
api.nvim_set_keymap("n", "<Up>", "<Cmd>res +5<CR>", opts)

-- Command mode navigation
api.nvim_set_keymap("c", "<C-A>", "<Home>", opts)
api.nvim_set_keymap("c", "<C-E>", "<End>", opts)
api.nvim_set_keymap("c", "<C-h>", "<Left>", opts)
api.nvim_set_keymap("c", "<C-j>", "<Down>", opts)
api.nvim_set_keymap("c", "<C-k>", "<Up>", opts)
api.nvim_set_keymap("c", "<C-l>", "<Right>", opts)
