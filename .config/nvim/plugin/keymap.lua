-- Author: David Oniani <onianidavid@gmail.com>
-- License: MIT
-- Description: Neovim configuration file

-- Leader mappings
vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Toggle between buffers" })
vim.keymap.set("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Convenient mappings
vim.keymap.set("n", "<C-=>", "=Gzz", { desc = "Indent files and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "Move to the previous search result and center" })
vim.keymap.set("n", "n", "nzz", { desc = "Move to the next search result and center" })
vim.keymap.set("n", "yY", "<Cmd>%y<CR>", { desc = "Copy contents of the entire file" })
vim.keymap.set({ "n", "v" }, "Q", "gw", { desc = "Format lines" })

-- Window resizing
vim.keymap.set("n", "<Down>", "<Cmd>resize -4<CR>", { desc = "Shrink vertically" })
vim.keymap.set("n", "<Left>", "<Cmd>vertical resize +4<CR>", { desc = "Shrink horizontally" })
vim.keymap.set("n", "<Right>", "<Cmd>vertical resize -4<CR>", { desc = "Expand horizontally" })
vim.keymap.set("n", "<Up>", "<Cmd>resize +4<CR>", { desc = "Expand vertically" })

-- Vertical navigation
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

-- Command mode navigation
vim.keymap.set("c", "<C-a>", "<Home>", { desc = "Move cursor to the beginning of line" })
vim.keymap.set("c", "<C-e>", "<End>", { desc = "Move cursor to the end of line" })
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- Quickfix navigation
vim.keymap.set("n", "<A-j>", "<Cmd>cnext<Cr>", { desc = "Move to the next QuickFix item" })
vim.keymap.set("n", "<A-k>", "<Cmd>cprev<Cr>", { desc = "Move to the previous QuickFix item" })

-- Update all plugins
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
    vim.cmd.write()
end, { desc = "Update all plugins" })

-- Generic command runner
vim.keymap.set("n", "<C-CR>", "<Cmd>!run %<CR>", { desc = "Run current file" })

-- Web search
vim.keymap.set("n", "gX", function()
    vim.ui.open(("https://google.com/search?q=%s"):format(vim.fn.expand "<cword>"))
end, { desc = "Web Search (Normal Mode)" })

vim.keymap.set("x", "gX", function()
    local region = vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() })
    vim.ui.open(("https://google.com/search?q=%s"):format(vim.trim(table.concat(region, " "))))
    vim.api.nvim_input "<esc>"
end, { desc = "Web Search (Visual Mode)" })
