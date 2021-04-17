-- Access Nvim API
local g = vim.g

-- Map blankline
g.indent_blankline_char = "┆"
g.indent_blankline_filetype_exclude = { "help" }
g.indent_blankline_buftype_exclude = { "terminal", "nofile", "packer" }
g.indent_blankline_char_highlight = "LineNr"
