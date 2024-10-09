-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Toggle between buffers" })
vim.keymap.set("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

vim.keymap.set("n", "<C-=>", "=Gzz", { desc = "Indent files and center" })
vim.keymap.set("n", "<C-l>", "<Cmd>nohlsearch<CR>", { desc = "Stops highlighting search queries" })

vim.keymap.set("n", "N", "Nzz", { desc = "Move to the previous search result and center" })
vim.keymap.set("n", "g:", ":lua=", { desc = "Run current file" })
vim.keymap.set("n", "n", "nzz", { desc = "Move to the next search result and center" })
vim.keymap.set("n", "yY", "<Cmd>%y<CR>", { desc = "Copy contents of the entire file" })
vim.keymap.set({ "n", "v" }, "Q", "gw", { desc = "Format lines" })

vim.keymap.set("n", "<Down>", "<Cmd>resize -4<CR>", { desc = "Shrink vertically" })
vim.keymap.set("n", "<Left>", "<Cmd>vertical resize +4<CR>", { desc = "Shrink horizontally" })
vim.keymap.set("n", "<Right>", "<Cmd>vertical resize -4<CR>", { desc = "Expand horizontally" })
vim.keymap.set("n", "<Up>", "<Cmd>resize +4<CR>", { desc = "Expand vertically" })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

vim.keymap.set("c", "<C-A>", "<Home>", { desc = "Move cursor to the beginning of line" })
vim.keymap.set("c", "<C-E>", "<End>", { desc = "Move cursor to the end of line" })
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move cursor right" })

vim.keymap.set("n", "<A-j>", "<Cmd>cnext<Cr>", { desc = "Move to the next QuickFix item" })
vim.keymap.set("n", "<A-k>", "<Cmd>cprev<Cr>", { desc = "Move to the previous QuickFix item" })

vim.keymap.set("n", "<C-CR>", "<Cmd>!run %<CR>", { desc = "Run current file" })

vim.keymap.set("n", "gX", function()
    vim.ui.open(("https://google.com/search?q=%s"):format(vim.fn.expand "<cword>"))
end, { desc = "Web Search (Normal Mode)" })

vim.keymap.set("x", "gX", function()
    vim.ui.open(
        ("https://google.com/search?q=%s"):format(
            vim.trim(
                table.concat(
                    vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() }),
                    " "
                )
            )
        )
    )
    vim.api.nvim_input "<esc>"
end, { desc = "Web Search (Visual Mode)" })
