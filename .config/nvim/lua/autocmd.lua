-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Equalizes splits when resized",
    group = vim.api.nvim_create_augroup("winresize", { clear = true }),
    command = "wincmd =",
    pattern = "*",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlights on yank",
    group = vim.api.nvim_create_augroup("yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
