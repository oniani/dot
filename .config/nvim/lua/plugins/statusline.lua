-- Use `lualine.nvim` as a statusline
local lualine = require("lualine")

lualine.theme = "gruvbox"
lualine.extensions = { "fzf" }

lualine.status()
