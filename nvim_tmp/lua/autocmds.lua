-- Clean up LaTeX build files
vim.cmd [[
augroup TexClean
    autocmd!
    autocmd VimLeave *.tex :!texclean
augroup END
]]

-- Highlighted yank
vim.cmd [[
augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup='Search'}
augroup END
]]
