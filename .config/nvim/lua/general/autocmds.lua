-- Equalize splits when resized
vim.api.nvim_create_augroup("AutoResize", { clear = false })
vim.api.nvim_create_autocmd("VimResized *", {
    command = "wincmd =",
    group = "AutoResize",
})

-- Recompile LaTeX document on save
vim.api.nvim_create_augroup("AutoSave", { clear = false })
vim.api.nvim_create_autocmd("BufWritePost *.tex,*.dot", {
    command = "silent !run %",
    group = "AutoSave",
})

-- Highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = false })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = vim.highlight.on_yank,
    group = "YankHighlight",
})
