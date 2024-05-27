-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

vim.api.nvim_set_hl(0, "Directory", { fg = "None" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
vim.api.nvim_set_hl(0, "PMenu", { bg = "None" })
vim.api.nvim_set_hl(0, "PMenuSel", { bg = "NvimLightBlue", fg = "Black" })
vim.api.nvim_set_hl(0, "PMenuThumb", { bg = "NvimLightGrey4" })
vim.api.nvim_set_hl(0, "Statement", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "Black", bg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Statusline", { bg = "NvimLightGrey2", fg = "Black" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "None" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NvimDarkGrey3" })

vim.api.nvim_set_hl(0, "Function", { fg = "#e9fdac" })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = "#e9fdac" })
vim.api.nvim_set_hl(0, "Special", { fg = "#e9fdac" })
