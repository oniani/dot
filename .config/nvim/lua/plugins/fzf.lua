return {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf", build = ":call fzf#install()" },
    config = function()
        vim.keymap.set("n", "<Leader>f", "<Cmd>Files<CR>", { noremap = true })
        vim.keymap.set("n", "<Leader>l", "<Cmd>Lines<CR>", { noremap = true })
        vim.keymap.set("n", "<Leader>r", "<Cmd>Rg<CR>", { noremap = true })
    end,
}
