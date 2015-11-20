set filetype=vim

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  "Required for NeoBundle
  set runtimepath+=~/.nvim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'dag/vim-fish'
NeoBundle 'powerline/fonts'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jszakmeister/vim-togglecursor'
NeoBundle 'fatih/vim-go'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'danchoi/rb_nav'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'ivalkeen/vim-ctrlp-tjump'
NeoBundle 'KurtPreston/vim-autoformat-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'groenewege/vim-less'
NeoBundle 'sjl/vitality.vim'
NeoBundle 'benekastah/neomake'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'haya14busa/incsearch.vim'

NeoBundle 'Valloric/YouCompleteMe'
let g:ycm_server_log_level = 'debug'

NeoBundle 'mxw/vim-jsx'
au BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx

NeoBundle 'thoughtbot/vim-rspec'
" Sspec mappings
cmap spec<cr> call RunCurrentSpecFile()<CR>
cmap run<cr> call RunNearestSpec()<CR>
cmap lspec<cr> call RunLastSpec()<CR>
cmap specs<cr> call RunAllSpecs()<CR>

" Send rspec command to tmux (defaults to right split)
function! RspecCommand()
  if !exists("g:target")
    let g:target = 'right'
  endif
    return '''!tmux send-keys -t ' . g:target . ' C-c " clear; cd ' . getcwd() . '; be rspec -f d {spec}" C-m'''
endfunction

function! SetTargetPane(target) 
  let g:target = a:target
endfunction
let g:rspec_command = 'silent execute ' . RspecCommand() . ' | redraw!'

NeoBundle 'kien/ctrlp.vim'
cnoremap P<space> CtrlP 
nnoremap <leader>r :CtrlPMRU<CR>
nnoremap <leader>l :CtrlPBuffer<cr>
nnoremap <leader>d :CtrlP<cr>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'

" Use ag for grep and CtrlP
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

NeoBundle 'sirver/ultisnips'
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<c-e>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"


NeoBundle 'scrooloose/nerdtree'
cnoremap fdir<cr> NERDTreeFind<cr>
cnoremap dir<cr> NERDTreeToggle<cr>

NeoBundle 'scrooloose/syntastic' 
let g:syntastic_mode_map = {
      \ "mode": "active",
      \ "active_filetypes": ["ruby", "javascript"],
      \ "passive_filetypes": ["puppet"] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_mri_exec = '~/.rvm/rubies/ruby-2.2.2/bin/ruby'
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}



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

NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'build': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'Valloric/YouCompleteMe', {
      \ 'build' : {
      \     'mac' : './install.sh',
      \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
      \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
      \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
      \    }
      \ }

" Required filetype plugin indent on " If there are uninstalled bundles found on startup,
filetype plugin indent on
" this will conveniently prompt you to install them.
NeoBundleCheck
call neobundle#end()
