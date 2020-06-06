"
" Filename: init.vim
" Author:   David Oniani
" Modified: June 06, 2020
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

" Start the plugin declaration block
call plug#begin('$HOME/.config/nvim/plugged')

" Productivity
Plug 'junegunn/fzf', { 'do': './install --bin' }  " fzf fuzzy file finder
Plug 'junegunn/fzf.vim'                           " Commands for fzf
Plug 'junegunn/goyo.vim'                          " Distraction-free writing
Plug 'tpope/vim-commentary'                       " Comment stuff out

" Language support
Plug 'dense-analysis/ale'                         " Lint and fix asynchronously
Plug 'sheerun/vim-polyglot'                       " Language support

" Consistency
Plug 'chriskempson/base16-vim'                    " Base16 colorschemes

" Initialize the plugin system
call plug#end()

" }}}

" Plugin Settings {{{

" Asynchronous Lint Engine (ALE) {{{

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_fix_on_save = 1

let b:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'css': ['prettier'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'markdown': ['prettier'],
  \ 'python': ['black'],
  \ 'r': ['styler'],
  \ 'rust': ['rustfmt']
  \}

let g:ale_linters = {
  \ 'haskell': ['hlint'],
  \ 'javascript': ['eslint'],
  \ 'markdown': ['mdl'],
  \ 'python': ['mypy', 'pylint'],
  \ 'r': ['lintr'],
  \ 'sh': ['shellcheck']
  \}

let g:ale_linters_explicit = 1

let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_prettier_options = '--print-width=79'
let g:ale_python_black_options = '--line-length=79'
let g:ale_rust_cargo_use_clippy = 1

" }}}

" Base16 {{{

if (has("termguicolors"))
  set termguicolors
  colorscheme base16-gruvbox-dark-hard
endif

" }}}

" }}}

" Convenience {{{

" Italic comments
highlight! Comment cterm=italic gui=italic

" Transparent background
highlight! Normal ctermbg=none guibg=none

" Brighter comments (for Base 16)
call Base16hi('Comment', g:base16_gui09, '', g:base16_cterm09, '', '', '')

" Allow full clipboard
set clipboard+=unnamedplus

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Stop generating annoying swap files
set noswapfile

" Do not redraw while executing untyped commands (better performance)
set lazyredraw

" Possibility to have more than one unsaved buffers
set hidden

" This command does two things:
"   1. Set the numbering
"   2. Display numbering relative to the line
set number relativenumber

" This means that on first <Tab> it will complete to the longest common string
" and will invoke wildmenu (a horizontal and unobstructive little menu).
" On the next <Tab>, it will complete the first alternative and the will start
" to cycle through the rest. You can go back and forth with <Tab> and <S-Tab>
" respectively.
set wildmode=longest:full,full

" Set a marker at column 80
set colorcolumn=80

" Set the signcolumn
set signcolumn=yes

" Highlight the current line
set cursorline

" Splits happen on the bottom and right
set splitbelow splitright

" Enable mouse support
set mouse=a

" }}}

" Tabs and Indentation {{{

set expandtab      " On pressing tab, insert 2 spaces
set shiftwidth=2   " When indenting with '>', use 2 spaces width
set softtabstop=2  " Show existing tab with 2 spaces width
set tabstop=2      " Number of spaces that a <Tab> in the file counts for

" }}}

" Folding {{{

set fillchars=fold:\   " Get rid of fold dashes
set foldmethod=marker  " Fold based on marker

" }}}

" Search and Replace {{{

set ignorecase      " The case of normal letters is ignored
set smartcase       " Enable smartcase

" }}}

" Automatic Commands {{{

" Tab is 4 spaces in C++
autocmd FileType cpp setlocal shiftwidth=4 softtabstop=4 tabstop=4

" Tab is 4 spaces in Haskell
autocmd FileType haskell setlocal shiftwidth=4 softtabstop=4 tabstop=4

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=o formatoptions-=r

" Clean up LaTeX build files after closing a file with .tex extension
autocmd VimLeave *.tex :!texclean

" }}}

" Key Mappings {{{

" Map the leader key to space
let mapleader = "\<Space>"

" Toggle between buffers
nnoremap <Leader><Leader> <C-^>

" Select a buffer
nnoremap <Leader>b :Buffers<CR>

" Compile or run a program
nnoremap <Leader>c :!compile_or_run %<CR>

" Use fzf for file finding
nnoremap <Leader>f :Files<CR>

" Search for a pattern in a file
nnoremap <Leader>l :Lines<CR>

" Open the PDF file that has the same name as the currently opened file
nnoremap <Leader>o :!open %:r.pdf<CR><CR>

" Use fzf for picking a colorscheme
nnoremap <Leader>p :Colors<CR>

" Use fzf and rg for the string search
nnoremap <Leader>r :Rg<CR>

" Spell check
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>

" Open to-do list in the vertical split
nnoremap <Leader>t :vs<Space>$HOME/work-in-progress/TODO<CR>

" Toggle line-wrapping
nnoremap <Leader>w :set wrap!<CR>

" Toggle Goyo
nnoremap <Leader>z :Goyo \| set linebreak \| set wrap!<CR>

" Unset last registered search pattern by hitting return
nnoremap <CR> :nohlsearch<CR>

" Window navigation commands (saves a keystroke)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
