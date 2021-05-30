-- Access vim options
local opt = vim.opt

-- Search
opt.ignorecase = true
opt.smartcase  = true

-- Backup
opt.backup      = false
opt.swapfile    = false
opt.writebackup = false

-- Indent
opt.expandtab   = true
opt.shiftwidth  = 4
opt.softtabstop = 4
opt.tabstop     = 4

-- Visual
opt.colorcolumn    = "80"
opt.foldmethod     = "marker"
opt.lazyredraw     = true
opt.number         = true
opt.relativenumber = true
opt.signcolumn     = "number"
opt.termguicolors  = true

-- Completion
opt.completeopt = "menuone,noinsert,noselect"
opt.shortmess:append("c")

-- Miscellaneous
opt.clipboard  = "unnamedplus"
opt.fillchars  = "fold: "
opt.hidden     = true
opt.mouse      = "a"
opt.updatetime = 300
opt.wildmode   = "longest:full,full"
