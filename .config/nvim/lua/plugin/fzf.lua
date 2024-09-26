-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local fzf = require "fzf-lua"

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Find Files" })

vim.api.nvim_create_user_command("C", fzf.git_commits, { desc = "[C]ommits" })
vim.api.nvim_create_user_command("Grep", fzf.live_grep, { desc = "[G]rep" })
vim.api.nvim_create_user_command("L", fzf.lines, { desc = "[L]ines" })
