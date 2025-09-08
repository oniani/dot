-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.api.nvim_create_autocmd("FileType", {
    desc = "Use Tab key for toggling diff in fugitive.vim",
    group = vim.api.nvim_create_augroup("fugitive-vim-tab-diff", { clear = true }),
    pattern = "fugitive",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "=", { noremap = false, silent = true })
    end,
})

vim.keymap.set("n", "g!", "<Cmd>Git!", { desc = "Run in background and stream to preview window" })
vim.keymap.set("n", "g<CR>", "<Cmd>tab Git<CR>", { desc = "Show Git status in a new tab" })
vim.keymap.set("n", "g<Space>", "<Cmd>Git<Space>", { desc = "Toggle between buffers" })
