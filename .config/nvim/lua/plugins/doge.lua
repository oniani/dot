-- Access Nvim API and global editor variables
local api = vim.api
local g   = vim.g

-- Set the doc standard
g.doge_doc_standard_python = "google"

-- Toggle file explorer
api.nvim_set_keymap("n", "<Leader>d", ":DogeGenerate<CR>", { noremap = true })
