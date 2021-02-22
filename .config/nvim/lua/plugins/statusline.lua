-- Use `lualine.nvim` as a statusline
local lualine = require("lualine")

lualine.options.theme = "dracula"
lualine.extensions = { "fzf" }

lualine.status()
