set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
call vundle#end()
filetype plugin indent on
syntax on
execute pathogen#infect()
let loaded_matchparen = 1
let mapleader = ","
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set hlsearch
set incsearch
set gdefault
set noshowmatch
set encoding=utf-8
set noswapfile
set cursorline
set fileencoding=utf-8

imap kj <esc>
imap jj <esc>
map <C-d> :execute 'NERDTreeToggle ' . getcwd()<CR>
cmap dir :execute 'NERDTreeToggle ' . getcwd()<CR>
cmap <leader>d <C-p>
map <leader>sp :split<CR>
map <leader>sv :vsplit<CR>
map <leader>q :q<CR>
map <leader>w :w<cr>
nnoremap <leader><space> :noh<cr>
map <leader>t :tabnew<CR>
nnoremap <leader>s <C-w>v<C-w>l
nnoremap <leader>sh :split<CR><C-w>j

nnoremap <Tab>h <C-w>h
nnoremap <Tab>j <C-w>j
nnoremap <Tab>k <C-w>k
nnoremap <Tab>l <C-w>l
cmap mt :tabm
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <silent> <A-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
cmap ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap j gj
nnoremap k gk
nnoremap ; :

set nocompatible
set rnu
autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby
let g:ctrlp_map = '<leader>d'

" Snippets
" Track the engine.
 " Snippets are separated from the engine. Add this if you want them:
 " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
 let g:UltiSnipsListSnippets="<c-l>"
 " If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"
