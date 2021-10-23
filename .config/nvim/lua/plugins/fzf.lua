-- Mapping options
local opts = { noremap = true }

-- Use `fzf` for navigation using filenames, buffer-local lines, and patterns
vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Files<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>BLines<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Rg<CR>", opts)
