# directory functions and aliases

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# autocd by typing directory name
setopt auto_cd

# push old dir onto stack
setopt auto_pushd
setopt pushdminus


# current working directory in terminal titlebar
function chpwd() {
    print -Pn "\e]2;%~\a"
}

cr() {
    cdr
}

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
