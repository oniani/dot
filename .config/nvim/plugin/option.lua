-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

-- Backup
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Indent
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Visual
vim.opt.colorcolumn = "101"
vim.opt.cursorline = true
vim.opt.fillchars = { eob = " ", fold = " " }
vim.opt.foldmethod = "marker"
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true
vim.opt.scrolloff = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.synmaxcol = 256
vim.opt.termguicolors = true
vim.opt.textwidth = 100

-- Miscellaneous
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"
vim.opt.shortmess:append "c"
vim.opt.updatetime = 256
vim.opt.wildmode = { "longest", "full", "full" }
