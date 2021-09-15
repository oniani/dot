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

-- Formatting
opt.formatoptions:append("c", "q")
opt.textwidth = 100

-- Visual
opt.foldmethod = "marker"
opt.lazyredraw = true
opt.number = true
opt.signcolumn = "number"
opt.termguicolors = true

-- Completion
opt.completeopt = "menuone,noselect"
opt.shortmess:append("c")

-- Miscellaneous
opt.clipboard = "unnamedplus"
opt.colorcolumn = "100"
opt.fillchars = "fold: "
opt.hidden = true
opt.mouse = "a"
opt.updatetime = 100
opt.wildmode = "longest:full,full"
