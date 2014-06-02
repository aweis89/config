let mapleader = ","
set nocompatible              " be iMproved, required
filetype off                  " required
execute pathogen#infect()
set number
imap kj <esc>
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set hlsearch
set incsearch
cmap dir :execute 'NERDTreeToggle ' . getcwd()<CR>
nnoremap <S-l> :tabprevious<CR>
nnoremap <S-h> :tabnext<CR>
nnoremap <silent> <A-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
set nocompatible


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'
syntax on
filetype plugin indent on
