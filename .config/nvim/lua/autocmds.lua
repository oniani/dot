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

-- Transparent background
vim.cmd [[ augroup TransparentBackground ]]
vim.cmd [[     autocmd! ]]
vim.cmd [[     autocmd ColorScheme * hi! Normal ctermbg=none guibg=none ]]
vim.cmd [[ augroup END ]]

-- Italic comments
vim.cmd [[ augroup ItalicCommments ]]
vim.cmd [[     autocmd! ]]
vim.cmd [[     autocmd ColorScheme * hi! Comment cterm=italic gui=italic ]]
vim.cmd [[ augroup END ]]
