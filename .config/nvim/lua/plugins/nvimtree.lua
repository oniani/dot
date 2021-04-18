-- Access Nvim API
local api = vim.api

-- Toggle file explorer
api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
