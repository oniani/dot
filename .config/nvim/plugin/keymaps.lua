-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { desc = "Map space to no-op", silent = true })

vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Toggle between buffers" })
vim.keymap.set("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set("c", "<C-A>", "<Home>", { desc = "Move cursor to the beginning of line" })
vim.keymap.set("c", "<C-E>", "<End>", { desc = "Move cursor to the end of line" })
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move cursor right" })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

vim.keymap.set("n", "<C-CR>", "<Cmd>!run %<CR>", { desc = "Run current file" })
vim.keymap.set("n", "<CR>", function()
    if vim.opt.hlsearch:get() then
        vim.cmd.nohl()
        return ""
    else
        return "<CR>"
    end
end, { expr = true })
