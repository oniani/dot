-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

require "gitsigns".setup {
    current_line_blame = true,
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
    },
}

vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", fg = "#76946a" })
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", fg = "#dca561" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { bg = "none", fg = "#dca561" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", fg= "#c34043" })
