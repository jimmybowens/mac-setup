set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'ervandew/supertab'
call vundle#end()
filetype plugin indent on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
colorscheme gruvbox
set background=dark
set colorcolumn=80
set laststatus=2
syntax on
set number
set autoread
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set fileformat=unix
set fileformats=unix
set shiftwidth=2
set softtabstop=2
set noexpandtab
set autoindent
set incsearch
set hlsearch
set cindent
set showtabline=2
set splitbelow
set splitright

let mapleader = ","
let maplocalleader = "\\"
"inoremap <Esc> <NOP>
"inoremap <Up> <NOP>
noremap <Up> <NOP>
"inoremap <Down> <NOP>
noremap <Down> <NOP>
"inoremap <Left> <NOP>
noremap <Left> <NOP>
"inoremap <Right> <NOP>
noremap <Right> <NOP>
"inoremap jk <esc>
"inoremap kj <esc>
"inoremap ii <esc>
nnoremap <leader>b :bprevious<cr>
nnoremap <leader>n :bnext<cr>
nnoremap <leader>c :bd<cr><C-W><C-C>
nnoremap <leader>o :enew<cr>:edit 
nnoremap <leader>s :w<cr>
nnoremap <leader>q <C-W><C-O>:qa<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>vf :vsplit 
nnoremap <leader>h :split<cr>
nnoremap <leader>hf :split 
nnoremap <leader>, :source $MYVIMRC<cr>
inoremap sl; <C-X><C-L>
