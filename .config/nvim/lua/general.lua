-- Access global, buffer-local, and window-local options
local o = vim.o
local bo = vim.bo
local wo = vim.wo

-- Global options
o.backup = false
o.clipboard = o.clipboard .. "unnamedplus"
o.completeopt = "menuone,noinsert,noselect"
o.fillchars = "fold: "
o.hidden = true
o.ignorecase = true
o.lazyredraw = true
o.mouse = "a"
o.shortmess = o.shortmess .. "c"
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.termguicolors = true
o.updatetime = 300
o.wildmode = "longest:full,full"
o.writebackup = false

-- Window-local options
wo.colorcolumn = "80"
wo.foldmethod = "marker"
wo.number = true
wo.relativenumber = true
wo.signcolumn = "number"

-- Buffer-local options
bo.expandtab = true
bo.shiftwidth = 4
bo.softtabstop = 4
bo.tabstop = 4
