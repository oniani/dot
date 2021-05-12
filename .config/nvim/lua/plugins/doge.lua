-- Access Nvim API
local api = vim.api

-- Toggle file explorer
api.nvim_set_keymap("n", "<Leader>d", ":DogeGenerate<CR>", { noremap = true })
