-- Access Nvim API
local api = vim.api

-- Toggle neogit
api.nvim_set_keymap("n", ";;", ":Neogit kind=split<CR>", { noremap = true })
