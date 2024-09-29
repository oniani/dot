-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.cmd.colorscheme "default"

local highlights = {
    ["Diagnosticinfo"] = { fg = "#a6dbff" },
    ["Directory"] = { fg = "#a6dbff" },
    ["Folded"] = { bg = "none", fg = "#9b9ea4" },
    ["Function"] = { fg = "#a6dbff" },
    ["MoreMsg"] = { fg = "#a6dbff" },
    ["Normal"] = { bg = "#000000" },
    ["NormalFloat"] = { bg = "none" },
    ["Pmenu"] = { bg = "none", fg = "#ffffff" },
    ["Question"] = { fg = "#a6dbff" },
    ["QuickFixLine"] = { fg = "#a6dbff" },
    ["SignColumn"] = { bg = "none" },
    ["Special"] = { fg = "#ab82ff" },
    ["Tabline"] = { bg = "none" },
    ["TablineFill"] = { bg = "none" },
    ["TablineSel"] = { bg = "#a6dbff", fg = "#000000" },
    ["WinSeparator"] = { bg = "none", fg = "#14161b" },

    ["FzfLuaBorder"] = { bg = "none", fg = "#a6dbff" },
    ["NvimTreeExecFile"] = { fg = "#b3f6c0" },
    ["NvimTreeFolderName"] = { fg = "none" },
    ["NvimTreeOpenedFolderName"] = { fg = "none" },
}

for group, style in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, style)
end
