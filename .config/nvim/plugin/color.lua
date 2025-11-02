-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.cmd.colorscheme "default"

local styles = {
    -- Language
    ["Constant"] = { fg = "NvimLightGray2" },
    ["Delimiter"] = { fg = "NvimLightGray2" },
    ["Function"] = { fg = "NvimLightBlue" },
    ["Identifier"] = { fg = "NvimLightGray2" },
    ["Special"] = { fg = "NvimLightGray2" },
    ["Statement"] = { fg = "NvimLightYellow" },
    ["String"] = { fg = "NvimLightGreen" },
    ["Type"] = { fg = "NvimLightGray2" },

    -- Diff
    ["DiffAdd"] = { fg = "Black", bg = "NvimLightGreen" },
    ["DiffChange"] = { fg = "Black", bg = "NvimLightYellow" },
    ["DiffDelete"] = { fg = "Black", bg = "NvimLightRed" },

    -- Comments
    ["@comment.note"] = { fg = "NvimLightBlue", bold = true },
    ["@comment.todo"] = { fg = "NvimLightBlue", bold = true },
    ["@string.documentation.python"] = { fg = "NvimLightGray4", italic = true },
    ["Comment"] = { fg = "NvimLightGray4", italic = true },
    ["Note"] = { fg = "NvimLightBlue", bold = true },
    ["Todo"] = { fg = "NvimLightBlue", bold = true },

    -- Miscellaneous
    ["Changed"] = { fg = "NvimLightBlue" },
    ["DiagnosticHint"] = { fg = "NvimLightGreen" },
    ["DiagnosticInfo"] = { fg = "NvimLightBlue" },
    ["DiffText"] = { bg = "NvimDarkBlue" },
    ["Directory"] = { fg = "NvimLightBlue" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["MoreMsg"] = { fg = "NvimLightBlue" },
    ["Normal"] = { fg = "NvimLightGray2", bg = "None" },
    ["NormalFloat"] = { fg = "NvimLightGray4", bg = "None" },
    ["Pmenu"] = { bg = "Black", fg = "NvimLightGray2" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Question"] = { fg = "NvimLightBlue" },
    ["QuickFixLine"] = { fg = "NvimLightBlue" },
    ["Tabline"] = { bg = "Black", fg = "NvimLightGray2" },
    ["TablineSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["WinBar"] = { bg = "None" },
    ["WinSeparator"] = { fg = "NvimDarkGray3" },

    -- Plugins
    ["BlinkCmpDoc"] = { fg = "NvimLightGray2", bg = "None" },
    ["BlinkCmpDocCursorLine"] = { fg = "Black", bg = "NvimLightGray4" },
    ["FzfLuaBorder"] = { link = "Winseparator" },
    ["IndentLine"] = { fg = "NvimDarkGray2" },
    ["IndentLineCurrent"] = { fg = "NvimDarkGray2" },
    ["OilDirHidden"] = { fg = "NvimLightBlue" },
    ["OilFileHidden"] = { fg = "None" },
}

for group, style in pairs(styles) do
    vim.api.nvim_set_hl(0, group, style)
end
