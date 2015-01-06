set nocompatible              " be iMproved, required
filetype off                  " required
set shell=zsh
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
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
"Plugin 'vim-scripts/SearchComplete'
Plugin 'kien/ctrlp.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'ecomba/vim-ruby-refactoring'
"Plugin 'jlanzarotta/bufexplorer'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-unimpaired'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-repeat'
Plugin 'tell-k/vim-browsereload-mac'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'dsawardekar/ember.vim'
Plugin 'vim-scripts/YankRing.vim' 
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'junkblocker/unite-codesearch'
Plugin 'junkblocker/codesearch'
Plugin 'brandonbloom/csearch.vim'
Plugin 'Shougo/vimproc'
Plugin 'vim-scripts/tetragrammaton'
Plugin 'digitaltoad/vim-jade'
Plugin 'mklabs/vim-backbone'
call vundle#end()


" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
"neoBundleCheck
"End NeoBundle Scripts-------------------------
"NeoBundle 'Shougo/vimproc.vim', {
"\ 'build' : {
"\     'windows' : 'tools\\update-dll-mingw',
"\     'cygwin' : 'make -f make_cygwin.mak',
"\     'mac' : 'make -f make_mac.mak',
"\     'linux' : 'make',
"\     'unix' : 'gmake',
"\    },
"\ }
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
      \'separator': { 'left': ' ', 'right': '⮂' },
      \'subseparator': { 'left': '⮁', 'right': '⮃' },
      \'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

"let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'


augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y']}
syntax enable
filetype plugin indent on

"Smart % functionality
runtime macros/matchit.vim


execute pathogen#infect()
let loaded_matchparen = 1
let mapleader = " "
" change the default EasyMotion shading to something more readable with
" Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment


"only use zeus if it exists
if !empty(glob(getcwd() . "/.zeus.sock"))
  let g:rspec_command = "!clear && zeus rspec {spec}"
else
  let g:rspec_command = "!clear && bundle exec rspec --color {spec}"
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
set nocompatible
set rnu

set ignorecase
set smartcase
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=Yellow


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

"motion mappings
map H ^
map L $
"rails vim
map <leader>a ;A<cr>
map <leader>c ;Rcontroller<cr>
map <leader>m ;Rmodel<cr>
map <leader>v ;Rview<cr>

"remove mappings
let g:gitgutter_map_keys = 0

"add a binding.pry
map <leader>bp Obinding.pryjj
"remove binding.pry
map <leader>br /binding.pry<cr>dd

"map <leader>ls ;buffers<CR>;buffer<Space>
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>f <Plug>(easymotion-bd-w)

map <leader>n ;noh<cr>
map <leader>t ;tabnew<cr>
map <leader>\ <c-w>v<c-w>l
map <leader>- ;split<cr><c-w>j
imap jj <esc>
imap <c-h> <left>
imap <c-l> <right>
imap <c-j> <down>
imap <c-k> <up>
nmap <leader>s ;TagbarToggle<CR>

"Pane navigation
"map <leader>h <c-w>h
"map <leader>j <c-w>j
"map <leader>k <c-w>k
"map <leader>l <c-w>l

map <leader>h ^
map <leader>l $

map <S-h> ;tabprevious<cr>
map <S-l> ;tabnext<cr>
"Copy to clipboard
"map <c-c> "*y
"map <c-p> "*p

"Intuitive navigation for overlapping lines
map j gj
map k gk

map f <Plug>(easymotion-fl)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>w <Plug>(easymotion-bd-w)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>w <Plug>(easymotion-bd-w)
"scrolling
"map <c-j> <c-d>
"map <c-k> <c-u>

"preferences
nnoremap Y y$
nnoremap ; :
"nnoremap : ;
"
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>d :Unite -start-insert file file_rec/async buffer<CR>
"nnoremap <leader>r :Unite -start-insert file_mru<CR>
"nnoremap <leader>b :Unite -start-insert buffer<CR>
nnoremap <leader>us :Unite -start-insert grep<CR>.<CR>
nnoremap <leader>um :Unite -start-insert grep<CR>.<CR>def (self.)?
nnoremap / :Unite -start-insert line<CR>

"trying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
"let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 40

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <leader>d :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <buffer> <C-x> <esc>;q<cr>
  imap <silent><buffer><expr> <C--> unite#do_action('split')
  imap <silent><buffer><expr> <C-\> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
"trying


"nnoremap <leader>be :Unite buffer<CR>
"Don't leave visual when modifying indentation
vnoremap < <gv
vnoremap > >gv 

"Rspec plugin remapping
cmap spec<cr> w<cr>;call RunCurrentSpecFile()<cr>
cmap lspec<cr> w<cr>;call RunLastSpec()<cr>
cmap run<cr> w<cr>;call RunNearestSpec()<cr>
cmap as<cr> w<cr>;call RunAllSpecs()<CR> 

"Nerdtree
cmap dir<CR> NERDTreeToggle<CR> 

"Ag mappings
cmap agm<space> ag def\<space>
cmap * <c-r><c-w>
cmap ag<space> Ag<space>

map <leader>sm <esc><leader>s<c-w>l/

map gm ;Ag def\<space><c-r><c-w>

let g:ctrlp_match_window = 'bottom'
"let g:ctrlp_map = '<leader>d' 

"map <leader>p ;CtrlPMRUFiles<cr>
"map <leader>b ;CtrlPBuffer<cr>

let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
