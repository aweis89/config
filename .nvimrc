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

NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jszakmeister/vim-togglecursor'
NeoBundle 'fatih/vim-go'
NeoBundle 'git://github.com/jsx/jsx.vim.git'
NeoBundle 'hlissner/vim-forrestgump'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'danchoi/rb_nav'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'KurtPreston/vim-autoformat-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'groenewege/vim-less'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'sjl/vitality.vim'
let g:ycm_server_log_level = 'debug'
let g:syntastic_javascript_checkers = ['eslint']
au BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
cnoremap fdir<cr> NERDTreeFind<cr>
cnoremap dir<cr> NERDTreeToggle<cr>

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
"NeoBundle 'benmills/vimux'
"NeoBundle 'skalnik/vim-vroom'
NeoBundle 'thoughtbot/vim-rspec'

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

let g:vroom_spec_command = 'rescue rspec -f d'

NeoBundle 'christoomey/vim-tmux-navigator'
"NeoBundle 'terryma/vim-multiple-cursors'
"cmap spec<cr> VroomRunTestFile<cr>
"cmap lspec<cr> VroomRunLastTest<cr>
"cmap run<cr> VroomRunNearestTest<cr>
" vim-rpec mapping
cmap spec<cr> call RunCurrentSpecFile()<CR>
cmap run<cr> call RunNearestSpec()<CR>
cmap lspec<cr> call RunLastSpec()<CR>
cmap specs<cr> call RunAllSpecs()<CR>
let g:vroom_map_keys = 0
"cmap specs<cr> w<cr>;call RunAllSpecs()<CR> 
let g:vroom_write_all = 1
let g:vroom_use_vimux = 1

nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"Html tags
imap <c-w> <esc>bywi<<esc>ea></<esc>pa><esc>bhhi

NeoBundle 'junegunn/fzf'
" List of buffers
function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! BufOpen(e)
  execute 'buffer'. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options': '--extended --nth=3..,',
\   'tmux_height': '50%'
\ })<CR>

command! -nargs=1 AgFZF call fzf#run({
            \'source': Arghandler(<f-args>),
            \'sink' : function('AgHandler'),
            \'options' : '-m',
            \ 'tmux_height': '50%'
            \})

function! AgHandler(l)
    let keys = split(a:l,':')
    execute 'tabe +' . keys[-2] . ' ' . escape(keys[-1], ' ')
endfunction 

function! Arghandler(l)
    return "ag -i " . a:l . " | sed 's@\\(.[^:]*\\):\\(.[^:]*\\):\\(.*\\)@\\3:\\2:\\1@' "
endfunction

command! FZFLines call fzf#run({
  \ 'source':  BuffersLines(),
  \ 'sink':    function('LineHandler'),
  \ 'options': '--extended --nth=3..,',
  \ 'tmux_height': '70%'
\})


function! LineHandler(l)
  let keys = split(a:l, ':\t')
  exec 'buf ' . keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! BuffersLines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

function! TagCommand()
  return substitute('awk _!/^!/ { print \$1 }_ ', '_', "'", 'g')
              \ . join(tagfiles(), ' ')
endfunction

command! FZFTag call fzf#run({
\   'source'     : TagCommand(),
\   'sink'       : 'tag',
\   'tmux_height': '70%'
\   })

command! FZFMru call fzf#run({
            \'source': v:oldfiles,
            \'sink' : 'e ',
            \'options' : '-m',
            \'tmux_height': '70%'
            \})

"nnoremap <Leader>l :call fzf#run({'source': reverse(BufList()),'sink': function('BufOpen'), 'options': '--black', 'tmux_height': 20})<CR>
"nnoremap <Leader>d :FZF<cr>
nnoremap <leader>l :CtrlPBuffer<cr>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'

"nnoremap <leader>d :FZF<cr>
nnoremap <leader>d :CtrlP<cr>
"nnoremap <Leader>d :call fzf#run({'sink': 'e', 'tmux_height': 30})<CR>
nnoremap <Leader>a :AgFZF<space>
nnoremap <Leader>s :FZFLines<cr>
nnoremap <Leader>t :FZFTag<cr>
cnoremap mr<cr> :FZFMru<cr>

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

"NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0

nmap <Down> ]e
nmap <Up> [e

" Required filetype plugin indent on " If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
filetype plugin indent on
NeoBundleCheck

"settings
syntax on
color desert
set tabstop=4
set shiftwidth=2
set expandtab
set smartindent
set incsearch
set gdefault
set noshowmatch
"set encoding=utf-8
set noswapfile
set cursorline
"hi CursorLine cterm=NONE ctermbg=234 guibg=Grey90
"highlight SignColumn ctermbg=234 guibg=red set t_Co=256
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
"
"insert mode key mappings
inoremap jj <esc>
inoremap JJ <esc>:w<cr>

" Cursor to yellow on insert mode
" Blue on command/other mode
" Note the use of hex codes (ie 3971ED)
"if exists('$TMUX')
    "let &t_SI = "\<Esc>Ptmux;\<Esc>\033]Pl71ED39\033\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl828690\033\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    "autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]Pl71ED39\033\033]50;CursorShape=0\x7\033\\"
"else
    "let &t_EI = "\033]Pl71ED39\033\\"
    "let &t_SI = "\033]Pl828690\033\\"
    "silent !echo -ne "\033]Pl71ED39\033\\"
    "autocmd VimLeave * silent !echo -ne "\033]Pl71ED39\033\\"
"endif 

if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[4 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif


"set guicursor=n-v-c:block-cursor
"set guicursor+=i:ver100-icursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

"command mode mappings
cnoremap rl<cr> source ~/.nvimrc<cr>
nnoremap j gj
nnoremap k gk
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- :split<cr><c-w>j
nnoremap <leader>c :tabnew<cr>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>
imap <c-h> <left>
imap <c-l> <right>
imap <c-j> <down>
imap <c-k> <up>

"terminal specific mappings
tnoremap jj <C-\><C-n>

if has('nvim')
  nmap <BS> <C-h>
  tmap <BS> <C-h>
endif
"split navigation
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"noremap <C-h> <C-w>h
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l

" visualmode mappings
vnoremap < <gv
vnoremap > >gv 
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap H ^
nnoremap L $
nnoremap Y y$ 
"for yankring compatibility
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

autocmd FileType ruby iabbrev <buffer> bp binding.pry
nmap <leader>bp Obinding.pryJJ
call neobundle#end()
colors monokai
