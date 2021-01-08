-- fzf {{{

-- Apply Gruvbox colorscheme
-- let g:fzf_colors =  {
--     \ 'fg':      ['fg', 'Normal'],
--     \ 'bg':      ['bg', 'Normal'],
--     \ 'hl':      ['fg', 'Comment'],
--     \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
--     \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
--     \ 'hl+':     ['fg', 'Statement'],
--     \ 'info':    ['fg', 'PreProc'],
--     \ 'border':  ['fg', 'Ignore'],
--     \ 'prompt':  ['fg', 'Conditional'],
--     \ 'pointer': ['fg', 'Exception'],
--     \ 'marker':  ['fg', 'Keyword'],
--     \ 'spinner': ['fg', 'Label'],
--     \ 'header':  ['fg', 'Comment']
--     \ }

-- }}}

-- coc.nvim {{{

vim.g.coc_global_extensions = {
    'coc-clangd',
    'coc-json',
    'coc-marketplace',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-tsserver'
}

-- -- Use tab for trigger completion with characters ahead and navigate.
-- -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- --       other plugin before putting this into your config.
-- inoremap <silent><expr> <TAB>
--     \ pumvisible() ? "\<C-n>" :
--     \ <SID>check_back_space() ? "\<TAB>" :
--     \ coc#refresh()
-- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

-- function! s:check_back_space() abort
--     let col = col('.') - 1
--     return !col || getline('.')[col - 1]  =~# '\s'
-- endfunction

-- -- Show documentation
-- function! s:show_documentation()
--     if (index(['vim','help'], &filetype) >= 0)
--         execute 'h '.expand('<cword>')
--     else
--         call CocActionAsync('doHover')
--     endif
-- endfunction

-- -- Use K to show documentation in a preview window
-- nnoremap <silent> K :call <SID>show_documentation()<CR>

-- -- Code navigation
-- nmap <silent> gd <Plug>(coc-definition)
-- nmap <silent> gi <Plug>(coc-implementation)
-- nmap <silent> gr <Plug>(coc-references)
-- nmap <silent> gy <Plug>(coc-type-definition)

-- -- Diagnostics navigation
-- nmap <silent> ge <Plug>(coc-diagnostic-next)
-- nmap <silent> gE <Plug>(coc-diagnostic-prev)

-- -- Diagnostics window
-- nnoremap <silent><nowait> md :<C-u>CocList diagnostics<CR>

-- -- Marketplace window
-- nnoremap <silent><nowait> mm :<C-u>CocList marketplace<CR>

-- -- Symbol renaming
-- nmap <silent> ms <Plug>(coc-rename)

-- -- Format the current buffer
-- command! -nargs=0 Format :call CocAction('format')

-- -- }}}

-- colorscheme {{{

vim.cmd [[ 'colorscheme gruvbox8_hard' ]]
vim.cmd [[ 'highlight! Normal guibg=none' ]]

-- }}}

-- lualine.nvim {{{

lualine.theme = 'gruvbox'
lualine.separator = '|'
lualine.sections = {
  lualine_a = {'mode'},
  lualine_b = {'branch'},
  lualine_c = {'filename'},
  lualine_x = {'encoding', 'fileformat', 'filetype'},
  lualine_y = {'progress'},
  lualine_z = {'location' },
}
lualine.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {'filename'},
  lualine_x = {'location'},
  lualine_y = {},
  lualine_z = {}
}
lualine.extensions = {'fzf'}
lualine.status()

-- }}}

-- nvim-treesitter {{{

require('nvim-treesitter.configs').setup {
    highlight = {
        -- false will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        disable = {},
    },

    -- one of 'all', 'maintained', 'language', or a list of languages
    ensure_installed = 'all';
}

-- }}}
