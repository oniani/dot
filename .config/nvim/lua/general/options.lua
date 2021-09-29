-- Access vim options
local opt = vim.opt

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Backup
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- Indent
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Visual
opt.fillchars = "fold: "
opt.foldmethod = "marker"
opt.lazyredraw = true
opt.number = true
opt.signcolumn = "number"
opt.termguicolors = true

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Miscellaneous
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.mouse = "a"
opt.updatetime = 250
opt.wildmode = "longest:full,full"
