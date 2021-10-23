-- Mapping options
local opts = { noremap = true }

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
vim.api.nvim_set_keymap("n", "<Leader><Leader>", "<C-^>", opts)

-- Run the built-in spell checker
vim.api.nvim_set_keymap("n", "<Leader>s", "<Cmd>setlocal spell! spl=en_us<CR>", opts)

-- Toggle line wrapping
vim.api.nvim_set_keymap("n", "<Leader>w", "<Cmd>set wrap!<CR>", opts)

-- Make Y similar to C, D, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", opts)

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<C-n>", "<Cmd>bn<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-p>", "<Cmd>bp<CR>", opts)

-- Window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
vim.api.nvim_set_keymap("n", "<Down>", "<Cmd>res -5<CR>", opts)
vim.api.nvim_set_keymap("n", "<Left>", "<Cmd>vert resize +5<CR>", opts)
vim.api.nvim_set_keymap("n", "<Right>", "<Cmd>vert resize -5<CR>", opts)
vim.api.nvim_set_keymap("n", "<Up>", "<Cmd>res +5<CR>", opts)

-- Command mode navigation
vim.api.nvim_set_keymap("c", "<C-A>", "<Home>", opts)
vim.api.nvim_set_keymap("c", "<C-E>", "<End>", opts)
vim.api.nvim_set_keymap("c", "<C-h>", "<Left>", opts)
vim.api.nvim_set_keymap("c", "<C-j>", "<Down>", opts)
vim.api.nvim_set_keymap("c", "<C-k>", "<Up>", opts)
vim.api.nvim_set_keymap("c", "<C-l>", "<Right>", opts)
