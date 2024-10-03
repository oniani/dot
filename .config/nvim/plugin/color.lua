-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

local highlights = {
    ["Diagnosticinfo"] = { fg = "NvimLightBlue" },
    ["Directory"] = { fg = "NvimLightBlue" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["Function"] = { fg = "NvimLightBlue" },
    ["MoreMsg"] = { fg = "NvimLightBlue" },
    ["Normal"] = { bg = "Black" },
    ["NormalFloat"] = { bg = "Black" },
    ["Pmenu"] = { bg = "Black", fg = "White" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Question"] = { fg = "NvimLightBlue" },
    ["QuickFixLine"] = { fg = "NvimLightBlue" },
    ["Special"] = { fg = "NvimLightYellow" },
    ["Tabline"] = { bg = "Black", fg = "NvimLightGray2" },
    ["TablineSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["WinSeparator"] = { fg = "NvimDarkGray3" },

    ["CmpItemKindDefault"] = { fg = "NvimLightBlue" },
    ["FzfLuaBorder"] = { bg = "Black", fg = "NvimDarkGray3" },
    ["NvimTreeExecFile"] = { fg = "NvimLightGreen" },
}

for group, style in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, style)
end
