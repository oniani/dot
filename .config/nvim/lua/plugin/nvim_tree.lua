-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

require("nvim-tree").setup { view = { cursorline = false } }
vim.keymap.set("n", "<C-n>", function()
    require("nvim-tree.api").tree.toggle { focus = false }
end)
