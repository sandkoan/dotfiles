# aliases

# editors
alias vi='/usr/bin/vim'
alias vim='/usr/bin/nvim'
# terminal emacs
alias em="/usr/bin/emacsclient -nw"
# terminal is tied up
alias emacs="emacsclient -c -a ''"
# the terminal is not longer tied up with emacs
alias nemacs='emacsclient -nc'

# utils
alias cls='clear'

alias top='top -u $USER'  

if command -v nvim &> /dev/null
then
    alias diff='nvim -d'
else
    alias diff='diff --color=auto'
fi

if command -v kitty &> /dev/null
then
    alias icat="kitty +kitten icat"
fi

# ls
alias ls='ls --color=auto'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

# lsd aliases
# alias ls='lsd'
# alias l='ls -l'
# alias la='ls -a'
# alias lla='ls -la'
# alias lt='ls --tree'

# grep

EXC_FOLDERS="{.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
GREP_OPTIONS="--color=auto --exclude-dir=$EXC_FOLDERS"
alias grep="grep $GREP_OPTIONS"
alias egrep="egrep $GREP_OPTIONS"
alias fgrep="fgrep $GREP_OPTIONS"
alias sgrep="grep -R -n -H -C 5 $GREP_OPTIONS"

alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
                                              # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

cco() { gcc -std=c99 -g -O2 -o $1 $1.c -Wall; }
run() { cco $1 && ./$1 & fg; }

# Dotfiles aliase
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
