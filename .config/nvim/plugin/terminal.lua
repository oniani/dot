vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Custom local settings for terminal buffers",
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        vim.bo.filetype = "terminal"
        vim.cmd.startinsert()
        vim.opt_local.number = false
    end,
})

vim.keymap.set("n", "T", function()
    vim.wo.winfixheight = true
    vim.cmd.new()
    vim.api.nvim_win_set_height(0, 11)
    vim.cmd.term()
end)

vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>", { desc = "Simpler escape" })
