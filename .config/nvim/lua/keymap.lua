-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

-- Mapping the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Word wrapping navigation
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- BoL and EoL
vim.keymap.set("n", "H", "^", { silent = true })
vim.keymap.set("n", "L", "$", { silent = true })

-- Change inner word and delete inner word
vim.keymap.set("n", "S", "ciw", { silent = true })
vim.keymap.set("n", "X", "diw", { silent = true })

-- Toggle between buffers
vim.keymap.set("n", "<Leader><Leader>", "<C-^>")

-- Run built-in spell checker
vim.keymap.set("n", "<Leader>s", "<Cmd>setlocal spell! spelllang=en_us<CR>")

-- Toggling line wrapping
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Clear search highlighting
vim.keymap.set("n", "<CR>", "<Cmd>nohlsearch<CR>")

-- Command mode navigation
vim.keymap.set("c", "<C-A>", "<Home>")
vim.keymap.set("c", "<C-E>", "<End>")
vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-l>", "<Right>")

-- Run current file
vim.keymap.set("n", "<C-CR>", "<Cmd>!run %<CR>")
