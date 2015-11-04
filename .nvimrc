"Note Skip initialization for vim-tiny or vim-small.
let mapleader = " "
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

"Required
  set runtimepath+=~/.nvim/bundle/neobundle.vim/
endif

"Required
call neobundle#begin(expand('~/.nvim/bundle/'))

"adds jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" Let NeoBundle manage NeoBundle
" Required
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note You don't set neobundle setting in .gvimrc!

"Ruby settings
let ruby_spellcheck_strings = 1

NeoBundle 'sirver/ultisnips'
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<c-e>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"

NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jszakmeister/vim-togglecursor'
NeoBundle 'fatih/vim-go'
NeoBundle 'git://github.com/jsx/jsx.vim.git'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'danchoi/rb_nav'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'ivalkeen/vim-ctrlp-tjump'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'KurtPreston/vim-autoformat-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'groenewege/vim-less'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'sjl/vitality.vim'
NeoBundle 'benekastah/neomake'
let g:ycm_server_log_level = 'debug'
let g:syntastic_javascript_checkers = ['eslint']
au BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx

" Switch between the last two files
nnoremap <leader><leader> <c-^>

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
cnoremap fdir<cr> NERDTreeFind<cr>
cnoremap dir<cr> NERDTreeToggle<cr>
let g:syntastic_ruby_mri_exec = '/Users/aweisberg/.rvm/rubies/ruby-2.2.2/bin/ruby'
let g:syntastic_aggregate_errors = 1
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'thoughtbot/vim-rspec'

" Rvm integration
set shell=/usr/local/bin/zsh

" Syntastic settings
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

set wildignore+=node_modules,bower_components

function! RspecCommand()
  if !exists("g:target")
    let g:target = 'right'
  endif
    return '''!tmux send-keys -t ' . g:target . ' C-c " clear; cd ' . getcwd() . '; be rspec -f d {spec}" C-m'''
endfunction

function! SetTargetPane(target) 
  let g:target = a:target
endfunction

"com! -nargs=1 T call SetTargetPane(<f-args>) | source ~/.nvimrc

"cnoremap rl<cr> source ~/.nvimrc<cr>
let g:rspec_command = 'silent execute ' . RspecCommand() . ' | redraw!'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

cnoremap P<space> CtrlP 
nnoremap <leader>r :CtrlPMRU<CR>
nnoremap <leader>l :CtrlPBuffer<cr>
nnoremap <leader>d :CtrlP<cr>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'


" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

NeoBundle 'christoomey/vim-tmux-navigator'

" vim-rpec mapping
cmap spec<cr> call RunCurrentSpecFile()<CR>
cmap run<cr> call RunNearestSpec()<CR>
cmap lspec<cr> call RunLastSpec()<CR>
cmap specs<cr> call RunAllSpecs()<CR>

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
      \'colorscheme': 'wombat',
      \'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ }, 
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \'separator': { 'left': ' <<', 'right': '<< ' },
      \'subseparator': { 'left': ' <<', 'right': '>> ' },
      \'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

NeoBundle 'Valloric/YouCompleteMe', {
      \ 'build' : {
      \     'mac' : './install.sh',
      \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
      \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
      \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
      \    }
      \ }

NeoBundle 'scrooloose/syntastic' 
let g:syntastic_mode_map = {
      \ "mode": "active",
      \ "active_filetypes": ["ruby", "javascript"],
      \ "passive_filetypes": ["puppet"] }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" swap lines
nmap <Down> ]e
nmap <Up> [e

" Required filetype plugin indent on " If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
filetype plugin indent on
NeoBundleCheck

"settings
set wildcharm=<Tab>
color desert
set modifiable
set tabstop=4
set shiftwidth=2
set expandtab
set smartindent
set incsearch
set gdefault
set noshowmatch
set noswapfile
set cursorline
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set nocompatible
set number
set rnu

"Infinite undos
set undofile
set undodir=~/tmp

set ignorecase
set smartcase

inoremap jj <esc>

cnoremap rl<cr> source ~/.nvimrc<cr>

" for long wrapped lines make j/k behave intuitively
nnoremap j gj
nnoremap k gk

" window splits
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- :split<cr><c-w>j
nnoremap <leader>c :tabnew<cr>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>

" insert mode navigation
imap <c-h> <left>
imap <c-l> <right>
imap <c-j> <down>
imap <c-k> <up>

" fixes C-H neovim issue
if has('nvim')
  nmap <BS> <C-h>
  tmap <BS> <C-h>
endif

" visualmode mappings
vnoremap < <gv
vnoremap > >gv 

" wrap word with single/double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" move begining/end of line
nnoremap H ^
nnoremap L $

" make Y behave like D P
nnoremap Y y$ 

autocmd FileType ruby compiler ruby

" Open help at vertical split
autocmd BufRead,BufEnter */doc/* wincmd L

" insert binding.pry in above line
autocmd Filetype ruby nmap <leader>bp Obinding.pryJJ
call neobundle#end()
"colors monokai
syntax enable
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au FileType elixir setl sw=2 sts=2 et iskeyword+=!,?
