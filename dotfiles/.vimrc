function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! GitStatusLine()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '  '.l:branchname.' ':''
endfunction
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
call vundle#end()
filetype plugin indent on
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
colorscheme gruvbox
set background=dark
"set statusline=%t%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
"set statusline+=%=
"set statusline+=%{GitStatusLine()}
set colorcolumn=80
set laststatus=2
syntax on
set autowrite
set hidden
set modelines=0
set ttyfast
set showmode
set showcmd
set showmatch
set number
set autoread
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set fileformat=unix
set fileformats=unix
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set smarttab
set cindent
set showtabline=2
set splitbelow
set splitright
set completeopt=longest,menuone
set complete=.,w,b,u,k,i,U
set matchpairs+=<:>
set encoding=utf-8
set nowrap
set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set pastetoggle=<F2>
"autocmd filetype python set expandtab
let mapleader = ","
let maplocalleader = "\\"
nnoremap <leader><esc> :noh<return>a<esc>
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
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>
inoremap <expr> ;;  pumvisible() ? '<C-n>' :  '<C-P>'
inoremap <expr> <C-I> pumvisible() ? '<C-n>' : '<Tab>'
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> :bprevious<cr>
noremap <Right> :bnext<cr>
noremap <Tab><Tab> :buffers<cr>:buffer<space>
