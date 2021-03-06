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
set ruler
set backspace=eol,indent,start

" true color support
set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set guioptions=
set guifont=Consolas\ 11

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-eunuch.git'
Plugin 'vimux'
Plugin 'YankRing.vim'
let g:yankring_persist = 0
Plugin 'ConradIrwin/vim-bracketed-paste'
"Plugin 'CSApprox'
Plugin 'kien/rainbow_parentheses.vim'
if v:version > 704
  Plugin 'Valloric/YouCompleteMe'
  let g:ycm_language_server = [
  \ {
  \   'name': 'elixir-ls',
  \   'cmdline': [ expand( '$HOME/opt/elixir-ls/rel/language_server.sh' ) ],
  \   'filetypes': [ 'elixir', 'eelixir' ],
  \ },
  \ ]
endif
Plugin 'mbbill/undotree'
Plugin 'vimwiki/vimwiki'
" clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
" go
"Plugin 'fatih/vim-go'
"javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0
"typescript
Plugin 'leafgarland/typescript-vim'
"elixir
Plugin 'elixir-editors/vim-elixir'
" colorschemes
Plugin 'molokai'
Plugin 'dusk'
Plugin 'github-theme'
Plugin 'nanotech/jellybeans.vim'
Plugin 'pink'
Plugin 'chriskempson/base16-vim'
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim'
Plugin 'lifepillar/vim-solarized8'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'haishanh/night-owl.vim'

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
nnoremap <silent> <Leader>gu :UndotreeToggle<CR>

" replace caps-lock?
inoremap <leader>u <esc>vawUea
nnoremap <leader>u vawU

inoremap jk <esc>

nnoremap <leader>cn :cn<cr>

" vimrc editing/sourcing
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
" }}}

syntax on
set background=dark
color gruvbox

set grepprg=rg\ --vimgrep\ --no-heading

" vim wiki
let g:vimwiki_list = [{'path': '~/.vim/wiki'}]

" filetype specific stuff
au FileType python setlocal ts=4 sw=4 sts=4

augroup ruby
  au!
  au FileType ruby map <buffer> <Leader>cw :!ruby -cw %<cr>
  au FileType ruby map <buffer> <Leader>rr :!ruby %<cr>
augroup END

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

augroup elixir
  au!
  au FileType elixir setlocal formatprg=mix\ format\ \-
  au FileType elixir
        \ if expand("%") =~ ".exs$" |
        \   map <buffer> <F6>
        \     :call VimuxRunCommand("mix test ".expand("%"))<cr>|
        \   map <buffer> <F5>
        \     :call VimuxRunCommand("mix test ".expand("%").":".line("."))<cr>|
        \ endif
  au FileType elixir noremap  :YcmCompleter GoTo<cr>
augroup END

augroup clojure-rainbow
  au!
  au FileType clojure RainbowParenthesesActivate
  au Syntax clojure RainbowParenthesesLoadRound
  au Syntax clojure RainbowParenthesesLoadSquare
  au Syntax clojure RainbowParenthesesLoadBraces
augroup END

augroup js
  au FileType javascript.jsx,javascript setlocal formatprg=./node_modules/.bin/prettier\ --parser=babel\ --stdin
  au FileType javascript.jsx,javascript map <buffer> <leader>ff mfgggqG`f<cr>
  au FileTYpe javascript.jsx,javascript noremap <buffer>  :YcmCompleter GoTo<cr>
  set backupcopy=yes "this fixes webpack's crappy watcher
augroup END

augroup salt
  au!
  au BufNewFile,BufRead *.sls setf yaml
augroup END
