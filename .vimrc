set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmfrik/Vundle.Fmavim'
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
Plugin 'justinmk/vim-sneak'
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
" change the default EasyMotion shading to something more readable with
" Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
"replace 'f' with inclusive 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with exclusive 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
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

imap jj <esc>
map <c-d> :Vex<cr>
cmap dir NERDTreeToggle<CR> 
cmap <leader>d <c-p>
map <leader>sp :split<cr>
map <jeader>sv :vsplit<cr>
map <leader>n :noh<cr>
map <leader>t :tabnew<cr>
map <leader>s <c-w>v<c-w>l
map <leader>sh :split<cr><c-w>j

map <leader>h <c-w>h
map <leader>j <c-w>j
map <leader>k <c-w>k
map <leader>l <c-w>l
cmap mt :tabm
map <s-h> :tabprevious<cr>
map <s-l> :tabnext<cr>
map <silent> <a-s-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
map <silent> <a-right> :execute 'silent! tabmove ' . tabpagenr()<cr>
cmap ev <c-w><c-v><c-l>:e $myvimrc<cr>
map j gj
map k gk
map ; :

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
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

