#!/bin/bash

set -e

dir=$(dirname "$0")

declare -A dotfiles
dotfiles[vimrc]=~/.vimrc
dotfiles[tmux.conf]=~/.tmux.conf
dotfiles[bashrc]=~/.bashrc
dotfiles[bash_aliases]=~/.bash_aliases
dotfiles[gitconfig]=~/.gitconfig
dotfiles[git_template]=~/.git_template
dotfiles[inputrc]=~/.inputrc

for f in "$dir"/*; do
  key=$(basename "$f")
  dest=${dotfiles[$key]}
  [ -z "$dest" ] && continue
  ln -srb "$f" $dest
done

# install fzf
if [ ! -e ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi
