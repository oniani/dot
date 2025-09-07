-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

require("nnn").setup {
    explorer = {
        width = 32,
    },
}

vim.keymap.set({ "n", "t" }, "<C-n>", function()
    vim.cmd "NnnExplorer"
    -- We defer with 100ms delay to ensure nnn vsplit has time to open
    vim.defer_fn(function()
        vim.cmd "wincmd p"
    end, 100)
end, { desc = "Toggle nnn in a vertical split" })

vim.keymap.set(
    { "n", "t" },
    "<C-b>",
    "<Cmd>NnnPicker<CR>",
    { desc = "Toggle nnn in a floating window" }
)
