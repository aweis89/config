set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
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
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
set rtp+={repository_root}/powerline/bindings/vim
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
      \   'fugitive': '(exists("*fugitive#head") &&
      \""!=fugitive#head())'
      \ },
      \ }
call vundle#end()
filetype plugin indent on
syntax on
execute pathogen#infect()
let loaded_matchparen = 1
let mapleader = " "
map <Leader> <Plug>(easymotion-prefix)
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
"set hlsearch
set incsearch
set gdefault
set noshowmatch
set encoding=utf-8
set noswapfile
set cursorline
"set fileencoding=utf-8
set t_Co=256
set backspace=indent,eol,start
set laststatus=2
set noshowmode

imap kj <esc>
imap jj <esc>
map <c-d> :Vex<cr>
cmap dir NERDTreeToggle<CR> 
cmap <leader>d <c-p>
map <leader>sp :split<cr>
map <jeader>sv :vsplit<cr>
nnoremap <leader>n :noh<cr>
map <leader>t :tabnew<cr>
map <leader>s <c-w>v<c-w>l
map <leader>sh :split<cr><c-w>j

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
cmap mt :tabm
nnoremap <s-h> :tabprevious<cr>
nnoremap <s-l> :tabnext<cr>
nnoremap <silent> <a-s-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <a-right> :execute 'silent! tabmove ' . tabpagenr()<cr>
cmap ev <c-w><c-v><c-l>:e $myvimrc<cr>
nnoremap j gj
nnoremap k gk
nnoremap ; :

set nocompatible
set rnu
autocmd bufnewfile,bufread *.html.erb set filetype=html.eruby
let g:ctrlp_map = '<leader>d'

" snippets
" track the engine.
" snippets are separated from the engine. add this if you want them:
" trigger configuration. do not use <tab> if you use
" https://github.com/valloric/youcompleteme.
let g:ultisnipsexpandtrigger="<tab>"
let g:ultisnipsjumpforwardtrigger="<c-b>"
let g:ultisnipsjumpbackwardtrigger="<c-z>"
let g:ultisnipslistsnippets="<c-l>"
" if you want :ultisnipsedit to split your window.
let g:ultisnipseditsplit="vertical"

"Get YouCompleteMe to play nice with UltiSnipps!
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

