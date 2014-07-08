set nocompatible              " be iMproved, required
filetype off                  " required
set shell=zsh
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloosr/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/SearchComplete'
Plugin 'kien/ctrlp.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
"Plugin 'vim-scripts/TabBar'

let g:lightline = {
      \'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ]
      \]
      \ },
      \'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }
call vundle#end()
filetype plugin indent on
syntax on
execute pathogen#infect()
let loaded_matchparen = 1
let mapleader = " "
" change the default EasyMotion shading to something more readable with
" Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>w <Plug>(easymotion-bd-w)

map <leader>a ;A<CR>
cmap spec<CR> w<CR>;call RunCurrentSpecFile()<CR>
cmap lspec<CR> w<CR>;call RunLastSpec()<CR>
cmap run<CR> w<CR>;call RunNearestSpec()<CR>
cmap aspec<CR> w<CR>;A<CR>;call RunCurrentSpecFile()<CR>
"cmap allspec<CR> !tmux new-window -n Spec cicall RunAllSpecs()<CR>

"let g:rspec_command = "!clear && zeus rspec {spec}"
if !empty(glob(getcwd() . "/.zeus.sock"))
  let g:rspec_command = "!clear && zeus rspec {spec}"
else
  let g:rspec_command = "!clear && bundle exec rspec {spec}"
endif

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
set t_Co=256
set backspace=indent,eol,start
set laststatus=2
set noshowmode


"function! RSpecFile()
  "execute("!clear && zeus rspec " . expand("%p"))
"endfunction
"cmap spec<CR> :call RSpecFile() <CR>
"command! RSpecFile call RSpecFile()

"function! RSpecCurrent()
  "execute("!clear && zeus rspec " . expand("%p") . ":" . line("."))
"endfunction
"cmap tspec<CR> :call RSpecCurrent() <CR>
"command! RSpecCurrent call RSpecCurrent()

cmap dir<CR> NERDTreeToggle<CR> 
map <leader>n ;noh<cr>
map <leader>t ;tabnew<cr>
map <leader>s <c-w>v<c-w>l
map <leader>sh ;split<cr><c-w>j
imap jj <esc>
map <leader>h <c-w>h
map <leader>j <c-w>j
map <leader>k <c-w>k
map <leader>l <c-w>l
map <s-h> ;tabprevious<cr>
map <s-l> ;tabnext<cr>
"map <silent> <a-s-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
"map <silent> <a-right> :execute 'silent! tabmove ' . tabpagenr()<cr>
map j gj
map k gk
nnoremap ; :
nnoremap : ;
nnoremap gg G
nnoremap G gg
set nocompatible
set rnu
autocmd bufnewfile,bufread *.html.erb set filetype=html.eruby
let g:ctrlp_map = '<leader>d' 
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
