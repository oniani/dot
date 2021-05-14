-- Access Nvim API
local api = vim.api

-- Clean up LaTeX build files on exit
api.nvim_exec([[
    augroup TexClean
        autocmd!
        autocmd VimLeave *.tex :!texclean
    augroup end
]], false)

-- Highlight on yank
api.nvim_exec([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]], false)
