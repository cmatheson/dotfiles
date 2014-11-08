# so technically these aren't all aliases.  don't worry about it.
alias tmux="tmux -2"
alias ack=ack-grep
b() { bundle-check && bundle exec "$@"; }
bundle-check() { bundle check || bundle update; }
spec() { bundle-check; bundle exec spec "$@"; }
new() { ls -c $1 | head -n ${2:-5}; }
newbranch() { git checkout -b $1 -t ${2:-origin/master}; }

vim() {
  if [[ $# -eq 0 && -e Session.vim ]]; then
    command vim -S
  else
    command vim "$@"
  fi
}

_cleanup_after_ssh_alias() {
  trap - SIGCHLD
  tmux set-window-option automatic-rename on
}
ssh() {
  if [[ "$TERM" == screen* ]]; then
    tmux rename-window $1
    trap _cleanup_after_ssh_alias SIGCHLD
  fi
  TERM=${TERM%-italic} command ssh "$@"
}

export LESS=-SXRF
export GREP=--color=auto
alias ag='ag --pager less'

LOCAL_ALIASES=~/.bash_aliases.local
[ -e $LOCAL_ALIASES ] && . $LOCAL_ALIASES
