-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = { noremap = true }

-- Mappings
api.nvim_set_keymap("n", "<Leader>c", "<Cmd>T run %<CR>", opts)
api.nvim_set_keymap("n", "<Leader>t", "<Cmd>vertical Ttoggle<CR>", opts)
