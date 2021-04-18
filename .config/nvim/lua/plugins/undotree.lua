-- Access Nvim API
local api = vim.api

-- Toggle file explorer
api.nvim_set_keymap("n", "<C-i>", ":UndotreeToggle<CR>", { noremap = true })
