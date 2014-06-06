let mapleader = ","
set nocompatible              " be iMproved, required
filetype off                  " required
execute pathogen#infect()
let loaded_matchparen = 1
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
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>sp :split<CR>
map <leader>sv :vsplit<CR>
map <leader>q :q<CR>
map <leader>w :w<cr>
cmap dir :execute 'NERDTreeToggle ' . getcwd()<CR>

map <leader>t :tabnew<CR>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <Tab>h <C-w>h
nnoremap <Tab>j <C-w>j
nnoremap <Tab>k <C-w>k
nnoremap <Tab>l <C-w>l
cmap mt :tabm
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <silent> <A-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap j gj
nnoremap k gk
nnoremap ; :

set nocompatible
set rnu
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'
syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby

" Snippets
"lazy erb snippet
imap er<Tab> <%<Space><Space><Space>%><esc>hhhi
imap pe<Tab> <%=<Space><Space><Space>%><esc>hhhi
" Track the engine.
 Plugin 'SirVer/ultisnips'
 " Snippets are separated from the engine. Add this if you want them:
 " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
 " If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"
