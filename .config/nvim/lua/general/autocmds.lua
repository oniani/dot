-- Equalize splits when resized
vim.cmd([[
    augroup AutoResize
        autocmd!
        autocmd VimResized * wincmd =
    augroup end
]])

-- Highlight on yank
vim.cmd([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]])

-- Recompile LaTeX document on save
vim.cmd([[
    augroup LaTeX
        autocmd!
        autocmd BufWritePost *.tex :silent !run %
    augroup END
]])
