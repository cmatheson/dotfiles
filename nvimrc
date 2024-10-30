set hlsearch incsearch ignorecase smartcase
set ts=2 sw=2 sts=2 et
" set wildignore=/**/compiled,/public/javascripts/jst,/public/images
filetype off
set listchars=tab:▸\ ,trail:·
set list
set undodir=~/.config/nvim/undo
set undofile
set diffopt=vertical
set backspace=eol,indent,start
set mouse=

" true color support
set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set guioptions=
set guifont=Consolas\ 11

call plug#begin('~/.vim/bundle')
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dadbod'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/YankRing.vim'
let g:yankring_persist = 0
Plug 'ConradIrwin/vim-bracketed-paste'
"Plug 'CSApprox'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mbbill/undotree'
" clojure
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
"javascript
Plug 'pangloss/vim-javascript'
"typescript
Plug 'leafgarland/typescript-vim'
"jsx
Plug 'MaxMEllon/vim-jsx-pretty'
let g:vim_jsx_pretty_colorful_config = 1
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
Plug 'folke/tokyonight.nvim'
" nvim stuff
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
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

if v:version > 704
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --go-completer' }
  " let g:ycm_log_level = 'debug'
  let g:ycm_tsserver_binary_path = '$HOME/.volta/bin/tsserver'
  let g:ycm_always_populate_location_list = 1
  let g:ycm_language_server = [
  \ {
  \   'name': 'elixir-ls',
  \   'cmdline': [ expand( '$HOME/opt/elixir-ls/rel/language_server.sh' ) ],
  \   'filetypes': [ 'elixir', 'eelixir' ],
  \ },
  \ ]
  highlight YcmErrorLine guibg=#3f0000
  " highlight YcmErrorLine guibg=#3f0000
endif
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

augroup js
  au FileType javascript.jsx,javascript,typescript,typescriptreact setlocal formatprg=prettier\ --parser=typescript
  au FileType javascript.jsx,javascript,typescript,typescriptreact map <buffer> <leader>ff mfgggqG`f<cr>
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
augroup END

nmap <silent> K :lua vim.lsp.buf.hover()<cr>
nmap <silent> <leader>fi :lua vim.lsp.buf.code_action()<cr>
nmap <silent> <leader>gtr :lua vim.lsp.buf.references()<cr>
nmap <silent> <leader>gtt :lua vim.lsp.buf.type_definition()<cr>
nmap <silent> <leader>gti :lua vim.lsp.buf.implementation()<cr>
nmap <silent> <leader>d :lua vim.diagnostic.open_float()<cr>
nmap <silent> [e :lua vim.diagnostic.goto_prev()<cr>
nmap <silent> ]e :lua vim.diagnostic.goto_next()<cr>

lua <<EOF
local cmp = require'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.confirm({select = true }),
  }),
  sources  = cmp.config.sources({
    -- { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  --[[
  sorting = {
    priority_weight = 2,
    comparators = {
      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      require("copilot_cmp.comparators").prioritize,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  --]]
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

require'lspconfig'.ts_ls.setup{}
--[[
require('copilot').setup({
  panel = { enabled = false },
  suggestion = { enabled = false },
})
require("copilot_cmp").setup()
--]]
EOF
