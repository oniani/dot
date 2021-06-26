-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = {noremap = true}

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
api.nvim_set_keymap("n", "<Leader><Leader>", "<C-^>", opts)

-- Spell check
api.nvim_set_keymap("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", opts)

-- Toggle line wrapping
api.nvim_set_keymap("n", "<Leader>w", "<Cmd>set wrap!<CR>", opts)

-- Window navigation commands (saves a keystroke)
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
api.nvim_set_keymap("n", "<Down>", "<Cmd>res -5<CR>", opts)
api.nvim_set_keymap("n", "<Left>", "<Cmd>vert resize +5<CR>", opts)
api.nvim_set_keymap("n", "<Right>", "<Cmd>vert resize -5<CR>", opts)
api.nvim_set_keymap("n", "<Up>", "<Cmd>res +5<CR>", opts)
