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

" Let NeoBundle manage NeoBundle
" Required
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note You don't set neobundle setting in .gvimrc!

call neobundle#end()
NeoBundle 'fatih/vim-go'
NeoBundle 'hlissner/vim-forrestgump'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'danchoi/rb_nav'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'vim-scripts/ruby-matchit'
let g:ycm_server_log_level = 'debug'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
cnoremap tdir NERDTreeFind
cnoremap dir NERDTreeToggle

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'benmills/vimux'
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'terryma/vim-multiple-cursors'
cnoremap spec VroomRunTestFile
cmap lspec VroomRunLastTest
cmap run VroomRunNearestTest
let g:vroom_map_keys = 0
"cmap specs<cr> w<cr>;call RunAllSpecs()<CR> 
let g:vroom_write_all = 1
let g:vroom_use_vimux = 1

NeoBundle 'junegunn/fzf'
" List of buffers
function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! BufOpen(e)
  execute 'bufferl'. matchstr(a:e, '^[ 0-9]*')
endfunction

command! -nargs=1 AgFZF call fzf#run({
            \'source': Arghandler(<f-args>),
            \'sink' : function('AgHandler'),
            \'options' : '-m',
            \ 'tmux_height': '60%'
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
  \ 'tmux_height': '60%'
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
\   'tmux_height': '60%'
\   })

command! FZFMru call fzf#run({
            \'source': v:oldfiles,
            \'sink' : 'e ',
            \'options' : '-m',
            \   'tmux_height': '60%'
            \})

nnoremap <Leader>l :call fzf#run({'source': reverse(BufList()),'sink': function('BufOpen'), 'options': '--black', 'tmux_height': 20})<CR>
nnoremap <Leader>d :FZF<cr>
nnoremap <Leader>a :AgFZF<space>
nnoremap <Leader>s :FZFLines<cr>
nnoremap <Leader>t :FZFTag<cr>

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

NeoBundle 'vim-scripts/YankRing.vim'
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
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Required
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"settings
syntax on
color desert
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set hlsearch
set incsearch
set gdefault
set noshowmatch
set encoding=utf-8
set noswapfile
set cursorline
hi CursorLine cterm=NONE ctermbg=234 guibg=Grey90
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
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\033]Pl71ED39\033\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl828690\033\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]Pl71ED39\033\033]50;CursorShape=0\x7\033\\"
else
    let &t_EI = "\033]Pl71ED39\033\\"
    let &t_SI = "\033]Pl828690\033\\"
    silent !echo -ne "\033]Pl71ED39\033\\"
    autocmd VimLeave * silent !echo -ne "\033]Pl71ED39\033\\"
endif 

set guicursor=n-v-c:block-cursor
set guicursor+=i:ver100-icursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
"normal mode key mappings
nmap Y y$

"command mode mappings
cnoremap rl source ~/.nvimrc

nnoremap j gj
nnoremap k gk
nnoremap <leader>c :tabnew<cr>
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- :split<cr><c-w>j
nnoremap <leader>p :tabprevious
nnoremap <leader>n :tabnext
imap <c-h> <left>
imap <c-l> <right>
imap <c-j> <down>
imap <c-k> <up>

" visualmode mappings
vnoremap < <gv
vnoremap > >gv 
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap H ^
nnoremap L $
autocmd FileType ruby iabbrev <buffer> bp binding.pry
nmap <leader>bp Obinding.pryJJ
