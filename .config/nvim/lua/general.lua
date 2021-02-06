-- Use utilities
local util = require("util")

-- Set completeopt to have a better completion experience
util.set("completeopt", "menuone,noinsert,noselect")

-- Avoid showing extra messages when using completion
util.set("shortmess", "c", "+")

--  Allow for full clipboard
util.set("clipboard", "unnamedplus", "+")

-- Default updatetime leads to noticeable delays and poor user experience
util.set("updatetime", 300)

-- Some servers have issues with backup files
util.set("nowritebackup")

-- Stop generating annoying swap files
util.set("noswapfile")

-- Do not redraw while executing untyped commands (better performance)
util.set("lazyredraw")

-- Possibility to have more than one unsaved buffers
util.set("hidden")

-- Enable line numbers
util.set("number")

-- Enable relative line numbers
util.set("relativenumber")

-- Completion mode
util.set("wildmode", "longest:full,full")

-- Always have `signcolumn` enabled the `number` column
util.set("signcolumn", "number")

-- Set a marker at column 80
util.set("colorcolumn", 80)

-- Horizontal splits below
util.set("splitbelow")

-- Vertical splits right
util.set("splitright")

-- Enable mouse support
util.set("mouse", "a")

-- On pressing <Tab>, insert spaces instead
util.set("expandtab")

-- When indenting with ">", use 4 spaces width
util.set("shiftwidth", 4)

-- Show existing tab with 4 spaces width
util.set("softtabstop", 4)

-- <Tab> counts for 4 spaces
util.set("tabstop", 4)

-- Get rid of fold dashes
util.set("fillchars", "fold:\\ ")

-- Fold based on marker
util.set("foldmethod", "marker")

-- The case of normal letters is ignored
util.set("ignorecase")

-- Case-sensitive if a capital letter is present, case-insensitive otherwise
util.set("smartcase")

-- Enable the true color support
util.set("termguicolors")
