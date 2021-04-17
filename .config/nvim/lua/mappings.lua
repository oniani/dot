-- Access Nvim API
local api = vim.api

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
api.nvim_set_keymap("n", "<Leader><Leader>", "<C-^>", { noremap = true })

-- Compile or run a program
api.nvim_set_keymap("n", "<Leader>c", ":!run %<CR>", { noremap = true })

-- Spell check
api.nvim_set_keymap("n", "<Leader>s", ":setlocal spell! spelllang=en_us<CR>",
                    { noremap = true })

-- Toggle line wrapping
api.nvim_set_keymap("n", "<Leader>w", ":set wrap!<CR>", { noremap = true })

-- Toggle file explorer
api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })

-- Window navigation commands (saves a keystroke)
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Resize splits
api.nvim_set_keymap("n", "<Left>",  ":vert resize +5<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Right>", ":vert resize -5<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Up>",    ":res +5<CR>",         { noremap = true })
api.nvim_set_keymap("n", "<Down>",  ":res -5<CR>",         { noremap = true })
