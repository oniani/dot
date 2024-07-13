return {
    "lewis6991/gitsigns.nvim",
    opts = {
        current_line_blame = true,
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            changedelete = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
        },
    },
    config = function()
        vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", fg = "#76946a" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", fg = "#dca561" })
        vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { bg = "none", fg = "#dca561" })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", fg= "#c34043" })
    end,
}
