-- Author: David Oniani <onianidavid@gmail.com>
-- License: MIT
-- Description: Neovim configuration file

-- NOTE: Cursor shape may not match that of `$TERM`
-- See: https://github.com/neovim/neovim/issues/3681
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Custom local settings for terminal buffers",
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        vim.bo.filetype = "terminal"
        vim.cmd.startinsert()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
    end,
})

vim.keymap.set("n", "T", function()
    vim.wo.winfixheight = true
    vim.cmd.new()
    vim.api.nvim_win_set_height(0, 12)
    vim.cmd.term()
end)

vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>", { desc = "Simpler escape" })
