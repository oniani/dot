-- Use `lualine.nvim` as a statusline
require("lualine").setup {
    -- Set the theme
    options = {
        component_separators = "",
        icons_enabled = true,
        section_separators = "",
        theme = "dracula"
    },
    -- Additional options
    sections = {
        lualine_b = { "branch", "diff" },
        lualine_c = {
            { "diagnostics", sources = { "coc" } },
            { "filename", full_path = true }
        }
    },
    -- Specify extensions
    extensions = { "fugitive", "fzf" }
}
