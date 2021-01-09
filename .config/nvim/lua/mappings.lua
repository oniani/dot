-- Use utiliies
local util = require("util")

-- Map the leader key to space
vim.g.mapleader = " "

-- Toggle between buffers
util.nmap("<Leader><Leader>", "<C-^>")

-- Compile or run a program
util.nmap("<Leader>c", ":!run %<CR>")

-- Spell check
util.nmap("<Leader>s", ":setlocal spell! spelllang=en_us<CR>")

-- Toggle line wrapping
util.nmap("<Leader>w", ":set wrap!<CR>")

-- Window navigation commands (saves a keystroke)
util.nmap("<C-h>", "<C-w>h")
util.nmap("<C-j>", "<C-w>j")
util.nmap("<C-k>", "<C-w>k")
util.nmap("<C-l>", "<C-w>l")

-- Resize splits
util.nmap("<Left>", ":vertical resize +5<CR>")
util.nmap("<Right>", ":vertical resize -5<CR>")
util.nmap("<Up>", ":resize +5<CR>")
util.nmap("<Down>", ":resize -5<CR>")
