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
Plugin 'edkolev/tmuxline.vim'
Plugin 'danchoi/ri.vim'
Plugin 'rizzatti/dash.vim'
call vundle#end()

let g:lightline = {
      \'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ]
      \]
      \ },
      \'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \'separator': { 'left': ' ', 'right': '⮂' },
      \'subseparator': { 'left': '⮁', 'right': '⮃' },
      \'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }
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
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}
filetype plugin indent on
syntax on
execute pathogen#infect()
let loaded_matchparen = 1
let mapleader = " "
" change the default EasyMotion shading to something more readable with
" Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

"rails vim
map <leader>a ;A<cr>
map <leader>c ;Rcontroller<cr>
map <leader>m ;Rmodel<cr>
map <leader>v ;Rview<cr>

"file navigation
map <leader>ls ;buffers<CR>;buffer<Space>

"for partial buffer match, list all, for single match go to file 
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")

"Rspec plugin remapping
cmap spec<cr> w<cr>;call RunCurrentSpecFile()<cr>
cmap lspec<cr> w<cr>;call RunLastSpec()<cr>
cmap run<cr> w<cr>;call RunNearestSpec()<cr>
cmap aspec<CR> w<CR>;A<CR>;call RunCurrentSpecFile()<CR>

"only use zeus if it exists
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
set nocompatible
set rnu
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
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>w <Plug>(easymotion-bd-w)

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
map <c-c> "*y
map <c-p> "*p
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
nnoremap ; :
nnoremap : ;
nnoremap gg G
nnoremap G gg
cmap agm<space> ag def\<space>
cmap ag<space> Ag<space>
autocmd bufnewfile,bufread *.html.erb set filetype=html.eruby
let g:ctrlp_map = '<leader>d' 
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
