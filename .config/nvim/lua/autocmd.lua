-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

-- Defines groups
local misc = vim.api.nvim_create_augroup("Miscellaneous", { clear = true })

-- Equalizes splits when resized
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    group = misc,
    pattern = "*",
})

-- Highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = misc,
    pattern = "*",
})

-- Highlights trailing whitespace
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff5d62" })
        vim.cmd "match ExtraWhitespace /\\s\\+$/"
    end,
    group = misc,
    pattern = "*",
})
