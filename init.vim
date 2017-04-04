let mapleader = " "

inoremap jj <Esc>
nnoremap L $
nnoremap H ^
nnoremap j gj
nnoremap k gk
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- :split<cr><c-w>j
nnoremap <leader>c :tabnew<cr>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>

" window/tab
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- :split<cr><c-w>j
nnoremap <leader>c :tabnew<cr>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>

" fixes C-H neovim issue
if has('nvim')
  nnoremap <BS> <C-w>h
else
  nnoremap <C-h> <C-w>h
endif
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
set wildignore+=*/tmp/*,*/log/*,*.zip,*.so,*.swp,node_modules,bower_components
nnoremap <leader>f :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>
nnoremap Y y$ 
vnoremap < <gv
vnoremap > >gv 
set clipboard=unnamed
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
"set rnu
set undofile
set undodir=~/tmp
set ignorecase
set smartcase
" disable mouse
set mouse=c

" Remove '|' for splits 
set fillchars+=vert:\ 

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-i> :ZoomToggle<CR>

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'morhetz/gruvbox'
Plug 'isRuslan/vim-es6'
Plug 'neomake/neomake'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'elixir-lang/vim-elixir'
Plug 'kien/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go'
Plug 'vim-scripts/bash-support.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
" Currently, es6 version of snippets is available in es6 branch only
Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk

" Initialize plugin system
call plug#end()

" True color
set termguicolors
set background=dark
colorscheme gruvbox

autocmd! BufWritePost * Neomake
let g:ctrlp_map = '<leader>d'
map <leader>l :CtrlPBuffer<CR>
map <C-n> :NERDTreeToggle<CR>

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
