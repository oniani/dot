-- Use utiliies
local util = require("util")

-- Use fzf for file finding
util.nmap("<Leader>f", ":Files<CR>")

-- Search for a pattern in a file
util.nmap("<Leader>l", ":BLines<CR>")

-- utilse fzf and rg for the string search
util.nmap("<Leader>r", ":Rg<CR>")
