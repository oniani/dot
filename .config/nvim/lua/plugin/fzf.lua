-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local fzf = require "fzf-lua"

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Find [F]iles" })
vim.keymap.set("n", "<Leader>g", fzf.live_grep, { desc = "[G]rep" })
vim.keymap.set("n", "<Leader>l", fzf.lines, { desc = "Open [L]ines" })
