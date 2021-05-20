-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = { noremap = true }

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
api.nvim_set_keymap("n", "<Leader><Leader>", "<C-^>", opts)

-- Compile or run a program
api.nvim_set_keymap("n", "<Leader>c", ":!run %<CR>", opts)

-- Spell check
api.nvim_set_keymap("n", "<Leader>s", ":setlocal spell! spl=en_us<CR>", opts)

-- Toggle line wrapping
api.nvim_set_keymap("n", "<Leader>w", ":set wrap!<CR>", opts)

-- Window navigation commands (saves a keystroke)
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
api.nvim_set_keymap("n", "<Down>",  ":res -5<CR>",         opts)
api.nvim_set_keymap("n", "<Left>",  ":vert resize +5<CR>", opts)
api.nvim_set_keymap("n", "<Right>", ":vert resize -5<CR>", opts)
api.nvim_set_keymap("n", "<Up>",    ":res +5<CR>",         opts)

-- Enter the normal mode faster with jj
api.nvim_set_keymap("i", "jj", "<Esc>", opts)
