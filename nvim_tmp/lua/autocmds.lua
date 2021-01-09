-- Clean up LaTeX build files
vim.cmd [[ augroup TexClean ]]
vim.cmd [[     autocmd! ]]
vim.cmd [[     autocmd VimLeave *.tex :!texclean ]]
vim.cmd [[ augroup END ]]

-- Highlighted yank
vim.cmd [[ augroup LuaHighlight ]]
vim.cmd [[     autocmd! ]]
vim.cmd [[     autocmd TextYankPost * silent! lua vim.highlight.on_yank { } ]]
vim.cmd [[ augroup END ]]
