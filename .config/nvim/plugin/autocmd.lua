-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Equalize splits when resized",
    group = vim.api.nvim_create_augroup("window-resize", { clear = true }),
    command = "wincmd =",
    pattern = "*",
})
