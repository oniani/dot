vim.api.nvim_create_autocmd("FileType", {
    desc = "Use Tab key for toggling diff in fugitive.vim",
    group = vim.api.nvim_create_augroup("fugitive-vim-tab-diff", { clear = true }),
    pattern = "fugitive",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "=", { noremap = false, silent = true })
    end,
})
