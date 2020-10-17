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

# https://www.bigeekfan.com/post/20200705_z_in_zsh_with_cdr/
function z () {

    # grep the list of dirs known by cdr 
    local lines=$(cdr -l | grep --ignore-case "${1}")

    # if grep doesn't find anything do nothing and
    # return an error code.
    if [ -z "$lines" ]; then
        return 1

    elif [ $(wc -l <<< "$lines") -eq 1 ]; then
        # if there is only one match, cdr to it using the
        # number prefix
        cdr "${lines%% *}"
        
    else
        # if there are multiple matches, run
        # fzf
        local selected_dir=$(cdr -l | fzf --query "${1}")
        if [ -n "$selected_dir" ]; then
            cdr "${selected_dir%% *}"
        fi
    fi
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
