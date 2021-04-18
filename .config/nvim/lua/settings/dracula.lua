-- Access Nvim API
local api = vim.api

-- Set the colorscheme
api.nvim_command("colorscheme dracula")

-- Custom comment colors
api.nvim_exec([[
    augroup CustomCommentColors
        autocmd!
	autocmd ColorScheme * highlight! Comment ctermfg=61, guifg=#5a699d"
    augroup end
]], false)

-- Custom line number colors
api.nvim_exec([[
    augroup CustomLineColors
        autocmd!
	autocmd ColorScheme * highlight! LineNr ctermfg=237 guifg=#3c3c3c
    augroup end
]], false)

-- Custom background color
api.nvim_exec([[
    augroup CustomBackgroundColors
        autocmd!
	autocmd ColorScheme * highlight! Normal ctermfg=233 guibg=#12131a
    augroup end
]], false)
