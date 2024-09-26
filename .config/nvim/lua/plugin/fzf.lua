-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local fzf = require "fzf-lua"

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.keymap.set("n", "<C-c>", fzf.git_commits, { desc = "[C]ommits" })
vim.keymap.set("n", "<C-g>", fzf.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<C-s>", fzf.lines, { desc = "[S]earch Lines" })
