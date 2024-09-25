-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#ff9e3b" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none", fg = "#e82424" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none", fg = "#6a9589" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none", fg = "#658594" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none", fg = "#ff9e3b" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#141414" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none", fg = "#141414" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none", fg = "#727169" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#727169" })
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "PMenu", { bg = "none", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Tabline", { bg = "none" })
vim.api.nvim_set_hl(0, "TablineFill", { bg = "none" })
vim.api.nvim_set_hl(0, "TablineSel", { bg = "#8ba8f0", fg = "#000000" })
vim.api.nvim_set_hl(0, "WildMenu", { bg = "none", fg = "#141414" })
