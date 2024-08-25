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
