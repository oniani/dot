-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = { noremap = true }

-- Use `fzf` for navigation using filenames, buffer-local lines, and patterns
api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Files<CR>",  opts)
api.nvim_set_keymap("n", "<Leader>l", "<Cmd>BLines<CR>", opts)
api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Rg<CR>",     opts)
