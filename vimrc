set hlsearch incsearch ignorecase smartcase
set ts=2 sw=2 sts=2 et
set t_Co=256
set hidden
set showcmd
set wildmenu
set wildignore=/**/compiled,/public/javascripts/jst,/public/images
filetype off
set listchars=tab:▸\ ,trail:·
set list
set laststatus=2 " always show the status line
set undodir=~/.vim/undo
set undofile
set diffopt=vertical

" true color support
set termguicolors
if !has("nvim") && $TERM == "screen-256color"
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set guioptions=
set guifont=Consolas\ 11

" highlighting matching parens confuses me
let loaded_matchparen = 1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'The-NERD-Commenter'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-eunuch.git'
Plugin 'vim-coffee-script'
Plugin 'vimux'
Plugin 'YankRing.vim'
let g:yankring_persist = 0
Plugin 'nono/vim-handlebars'
"Plugin 'CSApprox'
Plugin 'kien/rainbow_parentheses.vim'
if v:version > 704
  Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'Gundo'
Plugin 'vimwiki/vimwiki'
" clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
" go
"Plugin 'fatih/vim-go'
"javascript
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0
"typescript
Plugin 'leafgarland/typescript-vim'
" colorschemes
Plugin 'molokai'
Plugin 'dusk'
Plugin 'github-theme'
Plugin 'nanotech/jellybeans.vim'
Plugin 'pink'
Plugin 'chriskempson/base16-vim'
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim'

" fzf - i wish this was installed with vundle...
"  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"  ~/.fzf/install
set rtp+=~/.fzf
nnoremap <silent> <Leader>t :FZF<cr>

if v:version > 704
  packadd! matchit
endif

call vundle#end()
filetype plugin indent on

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

syntax on
set background=dark
color gruvbox

" vim wiki
let g:vimwiki_list = [{'path': '~/.vim/wiki'}]

" filetype specific stuff
au FileType python setlocal ts=4 sw=4 sts=4

augroup rails-specs
  au!
  au User Rails
        \ if rails#buffer().relative() =~ "^spec" |
        \   map <buffer> <F6>
        \     :call VimuxRunCommand("rspec " . expand("%") )<CR>|
        \   map <buffer> <F5>
        \     :call VimuxRunCommand("rspec ".expand("%").":".line("."))<CR>|
        \ elseif rails#buffer().relative() =~ "^test" |
        \   map <buffer> <F6>
        \     :call VimuxRunCommand("b rails test ".expand("%") )<cr>|
        \   map <buffer> <F5>
        \     :call VimuxRunCommand("b rails test ".expand("%").":".line("."))<cr>|
        \ endif
augroup END

augroup clojure-rainbow
  au!
  au FileType clojure RainbowParenthesesActivate
  au Syntax clojure RainbowParenthesesLoadRound
  au Syntax clojure RainbowParenthesesLoadSquare
  au Syntax clojure RainbowParenthesesLoadBraces
augroup END

augroup js
  au FileType javascript.jsx,javascript setlocal formatprg=./node_modules/.bin/prettier\ --stdin
  au FileType javascript.jsx,javascript map <leader>ff mfgggqG`f<cr>
  set backupcopy=yes "this fixes webpack's crappy watcher
augroup END

augroup salt
  au!
  au BufNewFile,BufRead *.sls setf yaml
augroup END
