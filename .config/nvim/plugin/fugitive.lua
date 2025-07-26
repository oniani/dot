vim.api.nvim_set_keymap(
    "n",
    "<leader>gr",
    [[:execute 'normal! ' .. vim.fn.line('.') .. 'Gread' .. "\n"]],
    { noremap = true, silent = true }
)
