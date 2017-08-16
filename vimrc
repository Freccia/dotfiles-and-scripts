
filetype on
filetype plugin on
filetype indent on

set mouse=a
set number

set shiftwidth=4
set tabstop=2
" set softtabstop=4

set ruler
set hlsearch

" On pressing tab, insert 4 spaces
set expandtab
set autoindent

syntax on
colorscheme elflord

set wildmenu
set wildmode=longest,full

nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>
