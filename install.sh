#!/bin/bash

set -e

dir=$(dirname "$(realpath "$0")")

declare -A dotfiles
dotfiles[vimrc]=~/.vimrc
dotfiles[tmux.conf]=~/.tmux.conf
dotfiles[bashrc]=~/.bashrc
dotfiles[bash_aliases]=~/.bash_aliases

for f in "$dir"/*; do
  key=$(basename "$f")
  dest=${dotfiles[$key]}
  [ -z "$dest" ] && continue
  ln -srb "$f" $dest
done
