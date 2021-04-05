-- Access Vim api
api = vim.api

-- Use fzf for file finding
api.nvim_set_keymap("n", "<Leader>f", ":Files<CR>", { noremap = true })

-- Search for a pattern in a file
api.nvim_set_keymap("n", "<Leader>l", ":BLines<CR>", { noremap = true })

-- utilse fzf and rg for the string search
api.nvim_set_keymap("n", "<Leader>r", ":Rg<CR>", { noremap = true })
