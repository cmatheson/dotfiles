# so technically these aren't all aliases.  don't worry about it.
alias tmux="tmux -2 "
b() { bundle-check && bundle exec "$@"; }
bt() { RAILS_ENV=test b "$@"; }
bundle-check() { bundle check > /dev/null || bundle update; }
spec() { bundle-check; bundle exec spec "$@"; }
rspec() { bundle-check; b rspec --color --format NyanCatFormatter "$@"; }
new() { ls -c $1 | head -n ${2:-5}; }
newbranch() { git checkout -b $1 -t ${2:-origin/master}; }
weather() {
  curl http://wttr.in/${1:-84009}
}

ssh() {
  if [[ "$TERM" == screen* ]]; then
    tmux rename-window $1
    trap "tmux set-window-option automatic-rename on" RETURN
  fi
  TERM=${TERM%-italic} command ssh "$@"
}

export LESS=-SXRF
alias grep='grep --color=auto'
alias ag='ag --pager less'

LOCAL_ALIASES=~/.bash_aliases.local
[ -e $LOCAL_ALIASES ] && . $LOCAL_ALIASES
