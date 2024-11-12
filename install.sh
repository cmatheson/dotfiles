#!/bin/bash

set -e

dir=$(dirname "$0")

declare -A dotfiles
dotfiles[vimrc]=~/.vimrc
dotfiles[nvimrc]=~/.config/nvim/init.vim
dotfiles[tmux.conf]=~/.tmux.conf
dotfiles[bashrc]=~/.bashrc
dotfiles[bash_aliases]=~/.bash_aliases
dotfiles[gitconfig]=~/.gitconfig
dotfiles[gitignoreglobal]=~/.gitignore_global
dotfiles[git_template]=~/.git_template
dotfiles[inputrc]=~/.inputrc

ln=$(which gln) || true
[ -z "$ln" ] && ln=$(which ln)

for f in "$dir"/*; do
  key=$(basename "$f")
  dest=${dotfiles[$key]}
  mkdir -p "$(dirname "$dest")"
  [ -z "$dest" ] && continue
  $ln -srb "$f" $dest
done

# install fzf
if [ ! -e ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# install plug (vim & neovim)
VIM_PLUG=~/.vim/autoload/plug.vim
[ -e "$VIM_PLUG" ] ||
  curl -fLo "$VIM_PLUG" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

NEOVIM_PLUG=~/.local/share/nvim/site/autoload/plug.vim
[ -e "$NEOVIM_PLUG" ] || cp "$VIM_PLUG" "$NEOVIM_PLUG"

# install z
if [ ! -e ~/opt/z/z.sh ]; then
  mkdir -p ~/opt
  git clone https://github.com/rupa/z  ~/opt/z
fi
