-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

-- Indent, no tabs, and spaces
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Folding
vim.o.fillchars = "eob: ,fold: "
vim.o.foldmethod = "marker"

-- Completion
vim.o.completeopt = "menu,menuone,popup,fuzzy"
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.wildmode = "longest:full,full"

-- Visual
vim.o.colorcolumn = "101"
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.number = true
vim.o.scrolloff = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitkeep = "screen"
vim.o.synmaxcol = 256
vim.o.termguicolors = true
vim.o.textwidth = 100

-- Miscellaneous
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.updatetime = 256
