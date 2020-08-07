# aliases

alias vim='nvim'
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a ''"

# ls aliases
alias ls='ls --color=auto'
alias l='ls -lahCF --color=auto'
alias ll='ls -alhF --color=auto'
alias la='ls -A --color=auto'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias sgrep='grep -R -n -H -C 5 --color=auto --exclude-dir={.git,.svn,CVS}'
alias hgrep='fc -El 0 | grep --color=auto'

# autocd by typing directory name
setopt auto_cd

# push old dir onto stack
setopt auto_pushd
setopt pushdminus

alias ~="cd ~"
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'

# TODO if you run clear, every 10th time run asciiquarium or sl steam locomotive
alias cls='clear'

alias rm='rm -I'
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

# git aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgs='config status'
alias cfga='config add'
alias cfgc='config commit -m'
alias cfgp='config push'

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gau='git add -u'
alias gc='git commit -m'
alias gp='git push'
alias gitu='git add . && git commit && git push'
