-- Use `lualine.nvim` as a statusline
require("lualine").setup({
    -- Set the theme
    options = {
        component_separators = "",
        icons_enabled = true,
        section_separators = "",
        theme = "tokyonight",
    },
    -- Additional options
    sections = {
        lualine_b = { "branch", "diff" },
        lualine_c = { { "diagnostics", sources = { "nvim_lsp" } }, { "filename", path = 1 } },
    },
    -- Specify extensions
    extensions = { "fzf", "quickfix" },
})
