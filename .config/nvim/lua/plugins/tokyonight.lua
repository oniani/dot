-- Theme style
vim.g.tokyonight_style = "night"

-- Darker background on sidebar-like windows
vim.g.tokyonight_sidebars = { "packer", "terminal" }

-- Italics functions and variables
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true

-- Make hints orange and errors bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Set the colorscheme
vim.api.nvim_command("colorscheme tokyonight")
