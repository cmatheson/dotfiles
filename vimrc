set hlsearch incsearch ignorecase smartcase
set ts=2 sw=2 sts=2 et
set t_Co=256
set hidden
set showcmd
set wildmenu
set wildignore=/**/compiled,/public/javascripts/jst,/public/images,/tmp/sassc
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
set listchars=tab:▸\ ,trail:·
set list
set laststatus=2 " always show the status line

set guioptions=
set guifont=Consolas\ 11

" highlighting matching parens confuses me
let loaded_matchparen = 1

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-vinegar'
Bundle 'The-NERD-Commenter'
Bundle 'ctrlp.vim'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-characterize.git'
Bundle 'vim-coffee-script'
Bundle 'vimux'
Bundle 'YankRing.vim'
Bundle 'nono/vim-handlebars'
Bundle 'CSApprox'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'Valloric/YouCompleteMe'
" clojure
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
" colorschemes
Bundle 'molokai'
Bundle 'dusk'
Bundle 'github-theme'
Bundle 'nanotech/jellybeans.vim'

" maps {{{
nnoremap <silent> <Leader>f :NERDTreeToggle<CR>

" replace caps-lock?
inoremap <leader>u <esc>vawUea
nnoremap <leader>u vawU
" }}}

inoremap jk <esc>

" vimrc editing/sourcing
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$|\.hg$|\.svn$|compiled$|jst$|.sass-cache'
  \ }

" fix C-CR binding in Command-T plugin
"let g:CommandTSelectNextMap=['<C-n>', '<Down>']
"let g:CommandTAcceptSelectionSplitMap='<C-j>'

" ctrl-p
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 20
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

filetype plugin indent on
syntax on
set background=dark
color molokai

" filetype specific stuff
au FileType python setlocal ts=4 sw=4 sts=4

augroup rails-specs
  au!
  au User Rails
        \ if rails#buffer().relative() =~ "^spec" |
        \   map <buffer> <F6>
        \     :call VimuxRunCommand("spec -u " . expand("%") )<CR>|
        \   map <buffer> <F5>
        \     :call VimuxRunCommand("spec -u ".expand("%").":".line("."))<CR>|
        \ endif
augroup END

augroup clojure-rainbow
  au!
  au FileType clojure RainbowParenthesesActivate
  au Syntax clojure RainbowParenthesesLoadRound
  au Syntax clojure RainbowParenthesesLoadSquare
  au Syntax clojure RainbowParenthesesLoadBraces
augroup END
