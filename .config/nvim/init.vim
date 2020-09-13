"
" Author: David Oniani
"
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

" Plugins and vim-plug {{{

" Install vim-plug automatically
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -Lfo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source '$MYVIMRC'
endif

call plug#begin('$HOME/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
call plug#end()

" }}}

" Plugin Settings {{{

" fzf {{{

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" }}}

" coc.nvim {{{

let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-tsserver'
  \ ]

" Use tab for trigger completion with characters ahead and navigate
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"       other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" Diagnostics navigation
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gE <Plug>(coc-diagnostic-prev)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Format the current buffer on save
augroup Format
  autocmd!
  autocmd BufWritePost <buffer> :call CocAction('format')
augroup END

" }}}

" colorscheme {{{

set termguicolors
colorscheme base16-gruvbox-dark-hard

" }}}

" lightline.vim {{{

let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night_Eighties',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" }}}

" }}}

" General Settings {{{

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Allow full clipboard
set clipboard+=unnamedplus

" Default updatetime leads to noticeable delays and poor user experience
set updatetime=300

" Some servers have issues with backup files
set nobackup nowritebackup

" Stop generating annoying swap files
set noswapfile

" Do not redraw while executing untyped commands (better performance)
set lazyredraw

" Possibility to have more than one unsaved buffers
set hidden

" Enable line numbers and set it relative to the line
set number relativenumber

" This means that on first <Tab> it will complete to the longest common string
" and will invoke wildmenu (a horizontal and unobstructive little menu).
" On the next <Tab>, it will complete the first alternative and the will start
" to cycle through the rest. You can go back and forth with <Tab> and <S-Tab>
" respectively.
set wildmode=longest:full,full

" Always have signcolumn enabled
set signcolumn=yes

" Set a marker at column 80
set colorcolumn=80

" Splits happen on the bottom and right
set splitbelow splitright

" Enable mouse support
set mouse=a

" On pressing <Tab>, insert spaces instead
set expandtab

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" Show existing tab with 4 spaces width
set softtabstop=4

" <Tab> counts for 4 spaces
set tabstop=4

" Get rid of fold dashes
set fillchars=fold:\ 

" Fold based on marker
set foldmethod=marker

" The case of normal letters is ignored
set ignorecase

" Case-sensitive if a capital letter is present, case-insensitive otherwise
set smartcase

" }}}

" Automatic Commands {{{

" Clean up LaTeX build files
augroup TexClean
  autocmd!
  autocmd VimLeave *.tex :!texclean
augroup END

" Highlighted yank
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Search'}
augroup END

" }}}

" Key Mappings {{{

" Map the leader key to space
let mapleader = "\<Space>"

" Toggle between buffers
nnoremap <Leader><Leader> <C-^>

" Compile or run a program
nnoremap <Leader>c :!compile_or_run %<CR>

" Use fzf for file finding
nnoremap <Leader>f :Files<CR>

" Search for a pattern in a file
nnoremap <Leader>l :BLines<CR>

" Open the PDF file that has the same name as the currently opened file
nnoremap <Leader>o :!open %:r.pdf<CR><CR>

" Use fzf and rg for the string search
nnoremap <Leader>r :Rg<CR>

" Spell check
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>

" Toggle line wrapping
nnoremap <Leader>w :set wrap!<CR>

" Toggle Goyo
nnoremap <Leader>z :Goyo<CR>

" Window navigation commands (saves a keystroke)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <Left> :vertical resize +5<CR>
nnoremap <Right> :vertical resize -5<CR>
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>

" }}}
