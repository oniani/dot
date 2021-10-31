vim.cmd([[
" Clear `Normal` cterm values, so terminal emulators won't treat negative
" space as extra whitespace (makes mouse-copy nicer).
hi Normal cterm=NONE ctermfg=NONE ctermbg=NONE guifg=white guibg=black
hi Cursor gui=NONE cterm=NONE guibg=#F92672 guifg=white ctermbg=47 ctermfg=black
hi Whitespace ctermfg=LightGray
hi SpecialKey ctermfg=241 guifg=#626262
hi! link SpecialChar Whitespace
hi! link NonText Comment
hi Comment guifg=#7E8E91 ctermfg=244
hi! link Constant Normal

hi QuickFixLine guifg=black guibg=cyan ctermfg=black ctermbg=cyan
" Special should be (at least slightly) distinct from SpecialKey.
hi Special ctermfg=LightCyan guifg=LightCyan
" hi Special guifg=#F92672 gui=bold ctermfg=197 cterm=NONE

" cyan
hi Identifier ctermfg=cyan guifg=cyan
hi! link Statement Identifier
hi! link Exception Identifier
hi! link Title Identifier
" affects:
"   - NONE string in 'hi Normal ctermfg=NONE …'
"   - helpHeader
hi! link PreProc Special

hi! link Type Identifier
hi String guifg=LightGreen guibg=NONE gui=NONE ctermfg=LightGreen ctermbg=NONE cterm=NONE
hi MoreMsg guifg=cyan guibg=NONE gui=NONE ctermfg=cyan ctermbg=NONE cterm=NONE
hi! link Question MoreMsg

hi Todo guibg=white guifg=black ctermbg=white ctermfg=black
hi! link WildMenu Search

" completion/popup menu
hi Pmenu guifg=#FFFFFF guibg=#585858 gui=NONE ctermfg=255 ctermbg=240 cterm=NONE
hi! link PmenuSel Search
hi PmenuSbar guibg=darkgray ctermbg=darkgray
hi PmenuThumb ctermbg=lightgreen ctermfg=lightgreen

" tabline
" hi default link TabLineFill TabLine
hi! link TabLineFill TabLine

" diff (unified)
hi diffAdded       guifg=#00ff5f gui=NONE      ctermfg=lightgreen  cterm=NONE
hi diffRemoved     guifg=#ff5f5f gui=NONE      ctermfg=203 cterm=NONE
hi link diffSubname Normal

" diff (side-by-side)
hi DiffAdd         guifg=#000000 guibg=#00ff5f ctermfg=0   ctermbg=lightgreen  gui=NONE cterm=NONE
hi DiffChange      guifg=#FFFFFF guibg=#4C4745 ctermfg=255 ctermbg=239 gui=NONE cterm=NONE
hi DiffDelete      guifg=#ff5f5f guibg=NONE    ctermfg=203 ctermbg=NONE gui=NONE cterm=NONE
hi DiffText        guifg=black   guibg=cyan    ctermfg=16  ctermbg=cyan gui=NONE cterm=NONE

"If 242 is too dark, keep incrementing...
hi FoldColumn      guifg=#465457 guibg=#000000 ctermfg=242 ctermbg=16
hi Folded          guifg=#465457 guibg=NONE    ctermfg=242 ctermbg=NONE

hi Error           guifg=#FFFFFF   guibg=Red   ctermfg=15 ctermbg=9
hi ErrorMsg        ctermfg=203 ctermbg=NONE guifg=#ff5f5f guibg=#161821
" alternative: 227, 185, 191 (too green)
hi WarningMsg      guifg=#d7ff5f ctermfg=185

" alternative: 227, 185, 191 (too green)
" hi Search guifg=#000000 guibg=#d7ff5f ctermfg=0 ctermbg=227 gui=NONE cterm=NONE
hi! Search ctermbg=LightCyan ctermfg=black guibg=LightCyan guifg=black
hi! link IncSearch QuickFixLine
hi! link Substitute QuickFixLine

hi Visual gui=NONE cterm=NONE guifg=black guibg=white ctermfg=black ctermbg=white
hi StatusLine cterm=bold,reverse gui=bold,reverse
hi! link ColorColumn StatusLine
hi StatusLineNC guifg=bg guibg=darkgrey ctermfg=232 ctermbg=242 cterm=NONE gui=NONE
hi VertSplit guifg=#808080 guibg=#080808 gui=bold ctermfg=244 ctermbg=232 cterm=bold

hi! link Directory Identifier
hi CursorLine guibg=#303030 ctermbg=235 cterm=NONE
hi! link LineNr CursorLine
hi! link SignColumn Normal
hi! link CursorLineNr Normal

hi SpellBad ctermbg=red ctermfg=255 cterm=undercurl gui=undercurl guisp=Red
hi SpellCap ctermbg=lightgrey ctermfg=red cterm=undercurl gui=undercurl guisp=white
hi! link SpellRare SpellCap

hi Underlined ctermfg=NONE cterm=underline gui=underline guifg=NONE

" other
hi helpHyperTextJump cterm=underline ctermfg=cyan gui=underline guifg=cyan
hi MatchParen cterm=bold,underline ctermfg=lightgreen ctermbg=NONE guifg=black guibg=white

]])
