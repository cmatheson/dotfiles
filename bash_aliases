# so technically these aren't all aliases.  don't worry about it.
alias tmux="tmux -2 "
b() { bundle-check && bundle exec "$@"; }
bt() { RAILS_ENV=test b "$@"; }
bundle-check() { bundle check > /dev/null || bundle update; }
rspec() { bundle-check; b spring rspec --color --format NyanCatFormatter "$@"; }
new() { ls -t $1 | head -n ${2:-5}; }
newbranch() { git checkout -b $1 -t ${2:-origin/master}; }
weather() {
  curl http://wttr.in/${1:-84009}
}
rg() { command rg -p "$@" | less; }
acurl () { curl -H "Authorization: Bearer $AUTH_TOKEN" "$@" ; }


export LESS=-SXRF
alias grep='grep --color=auto'
alias ag='ag --pager less'

LOCAL_ALIASES=~/.bash_aliases.local
[ -e $LOCAL_ALIASES ] && . $LOCAL_ALIASES

export ERL_AFLAGS="-kernel shell_history enabled"
