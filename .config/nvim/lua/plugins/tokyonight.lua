-- Access global editor variables
local g = vim.g

-- Theme style
g.tokyonight_style = "night"

-- Darker background on sidebar-like windows
g.tokyonight_sidebars = {"packer", "terminal"}

-- Italics functions and variables
g.tokyonight_italic_functions = true
g.tokyonight_italic_variables = true

-- Make hints orange and errors bright red
g.tokyonight_colors = {hint = "orange", error = "#ff0000"}

-- Set the colorscheme
vim.api.nvim_command("colorscheme tokyonight")
