# so technically these aren't all aliases.  don't worry about it.
alias tmux="tmux -2"
alias ack=ack-grep
alias b="bundle exec"
alias spec="bundle exec spec"
alias bake='bundle exec rake'
alias new='ls -c | head'

newbranch() {
  git checkout -b $1 -t ${2:-origin/master}
}

vim() {
  if [[ $# -eq 0 && -e Session.vim ]]; then
    command vim -S
  else
    command vim $@
  fi
}

export LESS=-SXRF
export GREP=--color=auto
alias ag='ag --pager less'

LOCAL_ALIASES=~/.bash_aliases.local
[ -e $LOCAL_ALIASES ] && . $LOCAL_ALIASES
