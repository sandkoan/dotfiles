# aliases

alias vi='/usr/bin/vim'
alias vim='nvim'
# emacs in terminal, decent functionality, beautiful with background
alias em="/usr/bin/emacsclient -nw"
# terminal is tied up
alias emacs="emacsclient -c -a ''"
# the terminal is not longer tied up with emacs
alias nemacs='emacsclient -nc'

alias inst='sudo pacman -S'
alias rem='sudo pacman --remove'
alias up='sudo pacman -Syu'

cco() { gcc -std=c99 -g -O2 -o $1 $1.c -Wall; }
run() { cco $1 && ./$1 & fg; }
# co() { g++ -std=c++17 -O2 -o $1 $1.cpp -Wall; }
# run() { co $1 && ./$1 & fg; }

# ls aliases
alias ls='ls --color=auto'
alias l='ls -lahCF --color=auto'
alias ll='ls -alhF --color=auto'
alias la='ls -A --color=auto'

# lsd aliases
# alias ls='lsd'
# alias l='ls -l'
# alias la='ls -a'
# alias lla='ls -la'
# alias lt='ls --tree'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias sgrep='grep -R -n -H -C 5 --color=auto --exclude-dir={.git,.svn,CVS}'
alias hgrep='fc -El 0 | grep --color=auto'

# TODO if you run clear, every 10th time run asciiquarium or sl steam locomotive
alias cls='clear'

alias rm='rm -I'
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

# git aliases
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgs='cfg status'
alias cfga='cfg add'
alias cfgc='cfg commit'
alias cfgp='cfg push'
