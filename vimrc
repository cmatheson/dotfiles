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
set directory=~/.vim/swapfiles

" true color support
set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set guioptions=
set guifont=Consolas\ 11

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/bundle')
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-eunuch'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/YankRing.vim'
let g:yankring_persist = 0
Plug 'ConradIrwin/vim-bracketed-paste'
"Plug 'CSApprox'
Plug 'kien/rainbow_parentheses.vim'
if v:version > 704
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --go-completer' }
  " let g:ycm_log_level = 'debug'
  let g:ycm_language_server = [
  \ {
  \   'name': 'elixir-ls',
  \   'cmdline': [ expand( '$HOME/opt/elixir-ls/rel/language_server.sh' ) ],
  \   'filetypes': [ 'elixir', 'eelixir' ],
  \ },
  \ ]
endif
Plug 'mbbill/undotree'
" clojure
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
"javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
"typescript
Plug 'leafgarland/typescript-vim'
"elixir
Plug 'elixir-editors/vim-elixir'
" colorschemes
Plug 'vim-scripts/molokai'
Plug 'vim-scripts/dusk'
Plug 'vim-scripts/github-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-scripts/pink'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'lifepillar/vim-solarized8'
Plug 'NLKNguyen/papercolor-theme'
Plug 'haishanh/night-owl.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" fzf - i wish this was installed with vundle...
"  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"  ~/.fzf/install
set rtp+=~/.fzf
nnoremap <silent> <Leader>t :FZF<cr>

if v:version > 704
  packadd! matchit
endif

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

set background=dark
color gruvbox

set grepprg=rg\ --vimgrep\ --no-heading

" vim wiki
let g:vimwiki_key_mappings = {'headers': 0}
let g:vimwiki_list = [{'path': '~/.vim/wiki', 'syntax': 'markdown', 'ext': '.md'}]

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
  au FileType javascript.jsx,javascript,typescript setlocal formatprg=prettier\ --parser=typescript
  au FileType javascript.jsx,javascript,typescript map <buffer> <leader>ff mfgggqG`f<cr>
  au FileType javascript.jsx,javascript,typescript noremap <buffer>  :YcmCompleter GoTo<cr>
  au FileType javascript.jsx,javascript,typescript noremap <buffer> <leader>gti :YcmCompleter GoToImplementation<cr>
  au FileType javascript.jsx,javascript,typescript noremap <buffer> <leader>gtr :YcmCompleter GoToReferences<cr>
  au FileType javascript.jsx,javascript,typescript map <buffer> K :YcmCompleter GetDoc<cr>
  set backupcopy=yes "this fixes webpack's crappy watcher
augroup END

augroup salt
  au!
  au BufNewFile,BufRead *.sls setf yaml
augroup END

augroup go
  au FileType go setlocal listchars=tab:\ \ ,trail:·
  au FileType go setlocal noexpandtab
  au FileType go setlocal formatprg=gofmt\ -s
  au FileTYpe go noremap <buffer>  :YcmCompleter GoTo<cr>
  au FileTYpe go noremap <buffer> <leader>gti :YcmCompleter GoToImplementation<cr>
  au FileTYpe go noremap <buffer> <leader>gtr :YcmCompleter GoToReferences<cr>
  au FileType go map <buffer> <leader>ff :YcmCompleter Format<cr>
  au FileType go map <buffer> K :YcmCompleter GetDoc<cr>
augroup END
