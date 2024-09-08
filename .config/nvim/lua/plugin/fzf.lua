-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local fzf = require "fzf-lua"

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<Leader>g", fzf.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<Leader>l", fzf.lines, { desc = "Search Lines" })

vim.keymap.set("n", "<Leader>b", fzf.git_commits, { desc = "[L]ines" })
vim.keymap.set("n", "<Leader>c", fzf.git_commits, { desc = "[C]ommits" })
