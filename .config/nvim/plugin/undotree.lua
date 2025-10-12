-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.cmd "packadd nvim.undotree"

vim.keymap.set("n", "<C-Backspace>", function()
    require("undotree").open {
        title = "undotree",
        command = "topleft 32vnew",
    }
end, { desc = "Toggle undotree" })
