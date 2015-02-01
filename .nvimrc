"Note Skip initialization for vim-tiny or vim-small.
let mapleader = " "
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required
  set runtimepath+=~/.nvim/bundle/neobundle.vim/
endif

" Required
call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note You don't set neobundle setting in .gvimrc!

call neobundle#end()
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'danchoi/rb_nav'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Valloric/YouCompleteMe'
let g:ycm_server_log_level = 'debug'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
cnoremap tdir NERDTreeFind
cnoremap dir NERDTreeToggle

NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-tag'
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
"let g:vroom_write_all = 1
"let g:vroom_use_vimux = 1

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

nnoremap <Leader>l :call fzf#run({'source': reverse(BufList()),'sink': function('BufOpen'), 'options': '--black', 'tmux_height': 20})<CR>
nnoremap <Leader><Enter> :FZF<cr>
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

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
let g:unite_enable_start_insert = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 40

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <leader>d :<C-u>Unite  -buffer-name=files  buffer file_rec/async:!<cr>
"nnoremap <leader>d :FZF<cr>
nnoremap <leader>us :Unite -buffer-name=search grep<CR>.<CR>
nnoremap <leader>ut :Unite -buffer-name=tags outline<CR>
nnoremap <leader>um :Unite -buffer-name=method_search grep<CR>.<CR>def (self.)?
nnoremap <leader>f :Unite -buffer-name=file_search line<CR>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  nmap <buffer> <C-j>   <Plug>(unite_select_next_line)

  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  imap <silent><buffer><expr> <C--> unite#do_action('split')
  nmap <silent><buffer><expr> <C--> unite#do_action('split')

  imap <silent><buffer><expr> <C-\> unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-\> unite#do_action('vsplit')

  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <C-z> <Plug>(unite_toggle_transpose_window)
  imap <C-z> <Plug>(unite_toggle_transpose_window)

  imap <buffer> <C-x> <Plug>(unite_exit)
  nmap <buffer> <C-x> <Plug>(unite_exit)
endfunction

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
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]Pl71ED39\033\033]50;CursorShape=1\x7\033\\"
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
nmap y y$

"command mode mappings
cnoremap rl source ~/.nvimrc

nnoremap j gj
nnoremap k gk
nnoremap <leader>t :tabnew<cr>
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
