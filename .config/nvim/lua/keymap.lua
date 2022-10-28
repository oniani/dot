-- Mapping options
local opts = { noremap = true }

-- Map the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Toggle between buffers
vim.keymap.set("n", "<Leader><Leader>", "<C-^>", opts)

-- Run the built-in spell checker
vim.keymap.set("n", "<Leader>s", "<Cmd>setlocal spell! spelllang=en_us<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", opts)

-- Buffer navigation
vim.keymap.set("n", "<C-n>", "<Cmd>bn<CR>", opts)
vim.keymap.set("n", "<C-p>", "<Cmd>bp<CR>", opts)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
vim.keymap.set("n", "<Down>", "<Cmd>res -5<CR>", opts)
vim.keymap.set("n", "<Left>", "<Cmd>vert resize +5<CR>", opts)
vim.keymap.set("n", "<Right>", "<Cmd>vert resize -5<CR>", opts)
vim.keymap.set("n", "<Up>", "<Cmd>res +5<CR>", opts)

-- Command mode navigation
vim.keymap.set("c", "<C-A>", "<Home>", opts)
vim.keymap.set("c", "<C-E>", "<End>", opts)
vim.keymap.set("c", "<C-h>", "<Left>", opts)
vim.keymap.set("c", "<C-j>", "<Down>", opts)
vim.keymap.set("c", "<C-k>", "<Up>", opts)
vim.keymap.set("c", "<C-l>", "<Right>", opts)
