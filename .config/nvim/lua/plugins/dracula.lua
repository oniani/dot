-- Access Nvim API
local api = vim.api

-- Custom function
api.nvim_exec([[
    function! MyHighlights() abort
        highlight Comment ctermfg=61 guifg=#5a699d
        highlight LineNr ctermfg=237 guifg=#3c3c3c
    endfunction
]], false)

-- Custom design
api.nvim_exec([[
    augroup CustomDesign
        autocmd!
        autocmd ColorScheme * call MyHighlights()
    augroup END
]], false)

-- Set the colorscheme
api.nvim_command("colorscheme dracula")
