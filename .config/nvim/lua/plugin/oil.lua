-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

require("oil").setup {
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
