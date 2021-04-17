-- Access Nvim API
local api = vim.api

-- Use `fzf` for navigation using filenames, buffer-local lines, and patterns
api.nvim_set_keymap("n", "<Leader>f", ":Files<CR>",  { noremap = true })
api.nvim_set_keymap("n", "<Leader>l", ":BLines<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Leader>r", ":Rg<CR>",     { noremap = true })
