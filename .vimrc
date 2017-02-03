set nocompatible
filetype off

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if has('vim_starting')
  set runtimepath+=~/.vim/bundles/neobundle.vim/

  call neobundle#begin(expand('~/.vim/bundles/'))
endif

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" File Open
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
" Unite.vim views histories
NeoBundle 'Shougo/neomru.vim'
" Comment in/out
NeoBundle 'tyru/caw.vim'
nmap <C-_> <Plug>(caw:i:toggle)
vmap <C-_> <Plug>(caw:i:toggle)

" html tag plug-in
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-t>'

"-------------------------
" NERDTree : Tree-view
"-------------------------
NeoBundle 'scrooloose/nerdtree'

"-------------------------
" Easy-Align : Auto Align
"-------------------------
NeoBundle 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

NeoBundle 'Yggdroot/indentLine', { 'autoload' : {
    \   'commands' : ['IndentLinesReset', 'IndentLinesToggle']
    \ }}
"-------------------------

"-------------------------
" neocomplcache : Auto completion
"-------------------------
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
if filereadable(expand('~/.vim/.vimrc.auto_complete'))
    source ~/.vim/.vimrc.auto_complete
endif
"-------------------------

NeoBundle 'tpope/vim-fugitive'
"-------------------------
" coffee-script : CoffeScript
"-------------------------
" syntax + auto-compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDD
NeoBundle 'claco/jasmine.vim'
" indent colors
NeoBundle 'nathanaelkane/vim-indent-guides'

" slim
NeoBundle "slim-template/vim-slim"

" YAML
NeoBundle 'stephpy/vim-yaml'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
""""""""""""""""""""""""""""""

"--------------------------
" NeoBundleVariables
"--------------------------
let g:indentLine_faster=1
let g:indentLine_enabled=1
set list listchars=tab:\¦\
let g:indentLine_color_term = 90
let g:indentLine_color_gui = '#4682B4'

"-------------------------
" settings
"-------------------------

set number      " display row numbers
set smartindent " smart indent
set autoindent  " auto indent
set expandtab   " convert tab to spaces
set cursorline  " highlight active line
set showmatch   " highlight parethesis
set nobackup    " do not create backup file
set noswapfile  " do not create swap file
set hlsearch    " highlight search result
set tabstop=4   " set tab equal to space numbers
set shiftwidth=4
set clipboard=unnamed,unnamedplus   " available to yank/put between clipboard
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set backspace=start,eol,indent
set fdm=marker
let php_folding=1
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

augroup vimrc
    autocmd! FileType perl setlocal shiftwidth=4 tabstop=2 softtabstop=2
    autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd! FileType css  setlocal shiftwidth=4 tabstop=2 softtabstop=2
    autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd! FileType slim setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd! FileType twig setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd! FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd! FileType javascript   setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

colorscheme molokai
syntax on

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

autocmd BufWritePre * :%s/\s\+$//ge
nmap / /\v
"""""""""""""""""""""""""""""
