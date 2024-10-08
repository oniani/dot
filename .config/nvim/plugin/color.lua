-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

local highlights = {
    -- Language and text
    ["Function"] = { fg = "NvimLightBlue" },
    ["Identifier"] = { fg = "NvimLightBlue" },
    ["Special"] = { fg = "NvimLightGray2" },
    ["Statement"] = { fg = "NvimLightGray2" },
    ["Todo"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Type"] = { fg = "NvimLightGray2" },

    -- Other components
    ["Diagnosticinfo"] = { fg = "NvimLightBlue" },
    ["Directory"] = { fg = "NvimLightBlue" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["MoreMsg"] = { fg = "NvimLightBlue" },
    ["Normal"] = { bg = "Black" },
    ["NormalFloat"] = { bg = "Black" },
    ["Pmenu"] = { bg = "Black", fg = "NvimLightGray2" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Question"] = { fg = "NvimLightBlue" },
    ["QuickFixLine"] = { fg = "NvimLightBlue" },
    ["Tabline"] = { bg = "Black", fg = "NvimLightGray2" },
    ["TablineSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["WinSeparator"] = { fg = "NvimDarkGray3" },

    -- Plugins
    ["CmpItemAbbrDefault"] = {},
    ["CmpItemAbbrMatchDefault"] = {},
    ["CmpItemKindDefault"] = { fg = "NvimLightBlue" },
    ["FzfLuaBorder"] = { link = "Winseparator" },
    ["NvimTreeExecFile"] = { link = "NvimLightGreen" },
}

for group, style in pairs(highlights) do
    style["bold"] = false
    vim.api.nvim_set_hl(0, group, style)
end
