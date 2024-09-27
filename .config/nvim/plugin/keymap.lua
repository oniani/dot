-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Toggle between buffers" })
vim.keymap.set("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-t>", "<C-w><S-t>", { desc = "Maximize the current window" })

vim.keymap.set("n", "<A-j>", "<Cmd>cnext<Cr>", { desc = "Move to the next QuickFix item" })
vim.keymap.set("n", "<A-k>", "<Cmd>cprev<Cr>", { desc = "Move to the previous QuickFix item" })

vim.keymap.set("n", "<Down>", "<C-W>-", { desc = "Shrink window vertically" })
vim.keymap.set("n", "<Left>", "<c-w>4>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<Right>", "<c-w>4<", { desc = "Expand window horizontally" })
vim.keymap.set("n", "<Up>", "<C-W>+", { desc = "Expand window vertically" })

vim.keymap.set("n", "<C-CR>", "<Cmd>!run %<CR>", { desc = "Run current file" })

vim.keymap.set("n", "<CR>", function()
    if vim.opt.hlsearch:get() then
        vim.cmd.nohl()
        return ""
    else
        return vim.keycode "<CR>"
    end
end, { expr = true, desc = "Clear highlight" })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

vim.keymap.set("c", "<C-A>", "<Home>", { desc = "Move cursor to the beginning of line" })
vim.keymap.set("c", "<C-E>", "<End>", { desc = "Move cursor to the end of line" })
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move cursor right" })
