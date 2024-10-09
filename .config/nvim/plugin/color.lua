-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

local highlights = {
    -- NvimDarkCyan -> NvimDarkBlue && NvimLightCyan -> NvimLightBlue
    ["Changed"] = { fg = "NvimLightBlue" },
    ["DiagnosticInfo"] = { fg = "NvimLightBlue" },
    ["DiffText"] = { bg = "NvimDarkBlue" },
    ["Directory"] = { fg = "NvimLightBlue" },
    ["Function"] = { fg = "NvimLightBlue" },
    ["MoreMsg"] = { fg = "NvimLightBlue" },
    ["Question"] = { fg = "NvimLightBlue" },
    ["QuickFixLine"] = { fg = "NvimLightBlue" },
    ["Special"] = { fg = "NvimLightBlue" },

    ["DiffAdd"] = { fg = "NvimLightBlue" },
    ["DiffChange"] = { fg = "NvimLightBlue" },

    ["Todo"] = { fg = "NvimLightBlue" },

    -- Other components
    ["DiagnosticHint"] = { fg = "NvimLightGreen" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["Normal"] = { bg = "Black" },
    ["NormalFloat"] = { bg = "Black" },
    ["Pmenu"] = { bg = "Black", fg = "NvimLightGray2" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
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
