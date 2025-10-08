-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.cmd "packadd nvim.undotree"

vim.keymap.set("n", "<C-Backspace>", function()
    require("undotree"):open { title = "Undotree" }
end, { desc = "Toggle undotree" })
