PS1="\w\$ "
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

export SVN_EDITOR="/usr/bin/env vim"

alias ls="ls -G"
alias tree='tree -C'
alias diff='colordiff'
alias less='less -r'
alias tmux='TERM=xterm-256color tmux'
