-- Mapping the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Word wrapping navigation
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggling between buffers
vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { noremap = true })

-- Running the built-in spell checker
vim.keymap.set("n", "<Leader>s", "<Cmd>setlocal spell! spelllang=en_us<CR>", { noremap = true })

-- Toggling line wrapping
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { noremap = true })

-- Buffer navigation
vim.keymap.set("n", "<C-n>", "<Cmd>bn<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", "<Cmd>bp<CR>", { noremap = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- Command mode navigation
vim.keymap.set("c", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-E>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-l>", "<Right>", { noremap = true })
