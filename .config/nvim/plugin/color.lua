-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

vim.api.nvim_set_hl(0, "Folded", { bg = "none", fg = "NvimLightGrey4" })
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "PMenu", { bg = "none", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Tabline", { bg = "none" })
vim.api.nvim_set_hl(0, "TablineFill", { bg = "none" })
vim.api.nvim_set_hl(0, "TablineSel", { bg = "NvimLightBlue", fg = "#000000" })
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "NvimDarkGray2" })

vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = "none", fg = "NvimDarkGray4" })
