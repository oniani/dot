-- Author: David Oniani <onianidavid@gmail.com>
-- License: MIT
-- Description: Neovim configuration file

require("oil").setup {
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
    win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
    },
}

vim.api.nvim_create_user_command("OilToggle", function()
    vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
end, { nargs = 0, desc = "Toggle Oil" })

vim.keymap.set("n", "<Leader>o", "<Cmd>:OilToggle<CR>", { desc = "Toggle Oil" })
