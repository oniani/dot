-- Toggle Neogit
vim.api.nvim_set_keymap(
    "n",
    "=",
    "<Cmd>Neogit kind=vsplit<CR>",
    { noremap = true }
)
