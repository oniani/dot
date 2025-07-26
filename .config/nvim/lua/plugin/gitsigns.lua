-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local gitsigns = require "gitsigns"
gitsigns.setup {
    current_line_blame = true,
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
    },
}

vim.keymap.set({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set({ "n", "v" }, "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
