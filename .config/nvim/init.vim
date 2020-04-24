"
" Filename: init.vim
" Author:   David Oniani
" Modified: April 23, 2019
"
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

" Use Vim/Neovim settings, rather than Vi settings (much better!)
" This must be on the first line, because it changes other
" options as a side effect
set nocompatible

" Plugins and vim-plug {{{

" Install vim-plug automatically
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start the plugin declaration block
call plug#begin('~/.config/nvim/plugged')

" Productivity
Plug 'junegunn/fzf', { 'do': './install --bin' }  " fzf fuzzy file finder
Plug 'junegunn/fzf.vim'                           " Commands for fzf
Plug 'junegunn/goyo.vim'                          " Distraction-free writing
Plug 'tpope/vim-commentary'                       " Comment stuff out
Plug 'tpope/vim-surround'                         " Quoting/parenthesizing

" Language support
Plug 'ajh17/VimCompletesMe'                       " Minimal code completion
Plug 'dense-analysis/ale'                         " Lint and fix asynchronously
Plug 'sheerun/vim-polyglot'                       " Language support

" Initialize the plugin system
call plug#end()

" }}}

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

let g:ale_prettier_options = '--print-width=79'
let g:ale_python_black_options = '--line-length=79'
let g:ale_rust_cargo_use_clippy = 1

" }}}

" Convenience {{{

" Make folded text darker
highlight! Folded ctermbg=black

" This command does three things:
"   1. Cause the editor to use 'ftdetect' files to detect and set 'filetype'
"      and trigger FileType events
"   2. Cause the editor to autoload 'ftplugin' files on FileType events
"   3. Cause the editor to autoload 'indent' files on FileType events
filetype plugin indent on

" Turn on the syntax highlighting
syntax on

" Set how many lines of history Vim has to remember
set history=10000

" Allow full clipboard
set clipboard=unnamedplus

" Some servers have issues with backup files
set nowritebackup

" Stop generating annoying swap files
set noswapfile

" Do not redraw while executing macros (better performance)
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

" Splits happen on the bottom and right
set splitbelow splitright

" Enable mouse support
set mouse=a

" Set the GUI font
set guifont=Hack\ Nerd\ Font\ Mono:h16

" UTF-8 encoding
set encoding=utf-8

" Get rid of the statusline
set laststatus=0

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

" Paste a dummy text
nnoremap <Leader>d :read !lorem_ipsum<CR>

" Use fzf for file finding
nnoremap <Leader>f :Files<CR>

" Search for a pattern in a file
nnoremap <Leader>l :Lines<CR>

" Open the PDF file that has the same name as the currently opened file
nnoremap <Leader>o :!open %:r.pdf<CR><CR>

" Spell check
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>

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
