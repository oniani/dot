-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

local styles = {
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

    -- Comments
    ["@comment.note"] = { fg = "NvimLightBlue", bold = true },
    ["@comment.todo"] = { fg = "NvimLightBlue", bold = true },
    ["@string.documentation.python"] = { fg = "NvimLightGray4", italic = true },
    ["Comment"] = { fg = "NvimLightGray4", italic = true },
    ["Note"] = { fg = "NvimLightBlue", bold = true },
    ["Todo"] = { fg = "NvimLightBlue", bold = true },

    -- Other components
    ["DiagnosticHint"] = { fg = "NvimLightGreen" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["Normal"] = { fg = "NvimLightGrey2", bg = "None" },
    ["NormalFloat"] = { fg = "NvimLightGray4", bg = "None" },
    ["Pmenu"] = { bg = "Black", fg = "NvimLightGray2" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Statement"] = { fg = "NvimLightYellow" },
    ["Tabline"] = { bg = "Black", fg = "NvimLightGray2" },
    ["TablineSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["WinBar"] = { bg = "None" },
    ["WinSeparator"] = { fg = "NvimDarkGray3" },

    -- Plugins
    ["FzfLuaBorder"] = { link = "Winseparator" },
    ["IndentLine"] = { fg = "NvimDarkGray2" },
    ["IndentLineCurrent"] = { fg = "NvimDarkGray2" },
    ["NvimTreeExecFile"] = { link = "NvimLightGreen" },
    ["NvimTreeFolderIcon"] = { link = "NvimLightBlue" },
}

for group, style in pairs(styles) do
    vim.api.nvim_set_hl(0, group, style)
end
