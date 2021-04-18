-- Access Nvim API
local g = vim.g

-- Indent blankline mappings
g.indent_blankline_buftype_exclude = { "terminal", "nofile"}
g.indent_blankline_char = "┆"
g.indent_blankline_char_highlight = "LineNr"
g.indent_blankline_filetype_exclude = { "help", "packer" }
