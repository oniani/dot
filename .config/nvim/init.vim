"
" Filename: init.vim
" Author:   David Oniani
" Modified: August 01, 2020
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
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" Language support
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'

" Color consistency
Plug 'lifepillar/vim-gruvbox8'

" Initialize the plugin system
call plug#end()

" }}}

" Plugin Settings {{{

" fzf {{{

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" }}}

" completion-nvim {{{

let g:completion_enable_auto_paren = 1
let g:completion_timer_cycle = 100

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <Tab> as a trigger key
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

" }}}

" diagnostic-nvim {{{

let g:diagnostic_insert_delay = 1

" }}}

" Colorscheme {{{

set termguicolors
colorscheme gruvbox8_hard

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

" Set a marker at column 80
set colorcolumn=80

" Highlight the current line
set cursorline

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

" Enable smartcase
set smartcase

" }}}

" Statusline {{{

" Left side settings
set statusline=
set statusline+=%#InsertMode#
set statusline+=\ %Y
set statusline+=\ %r
set statusline+=%#CursorLine#
set statusline+=\ %F

" Right side settings
set statusline+=%=
set statusline+=%#DiffChange#
set statusline+=\ %l/%L
set statusline+=\ [%c]

" }}}

" Automatic Commands {{{

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

" Unset last registered search pattern by hitting return
nnoremap <CR> :nohlsearch<CR>

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

" Sourcing {{{

luafile $HOME/.config/nvim/init.lua

" }}}
