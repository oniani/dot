-- Access Nvim API
local api = vim.api

-- Mapping options
local opts = {noremap = true}

-- Use `fzf` for navigation using filenames, buffer-local lines, and patterns
api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Telescope fd<CR>", opts)
api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Telescope live_grep<CR>", opts)
