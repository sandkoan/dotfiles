# emacs mode
bindkey -e

# cursor as thin line
echo -ne '\e[5 q'

# C-del and C-backspace
bindkey '^[[3;5~' kill-word
bindkey '^H' backward-kill-word

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# [Esc-l] - run command: ls
bindkey -s '\el' 'ls\n' 

# file rename magick
bindkey "^[m" copy-prev-shell-word
 
# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Use ctrl-z to toggle background processes
# don't need to type fg everytime
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        fg
        zle redisplay
    else
        zle push-input
        zle clear-screen
    fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Colored characters in completion
LISTMAX=0
unsetopt LIST_AMBIGUOUS MENU_COMPLETE COMPLETE_IN_WORD
setopt AUTO_MENU AUTO_LIST LIST_PACKED
unambigandmenu() {
  echo -n "\e[31m...\e[0m"
  # avoid opening the list on the first expand
  unsetopt AUTO_LIST
  zle expand-or-complete
  setopt AUTO_LIST
  zle magic-space
  zle backward-delete-char
  zle expand-or-complete
  zle redisplay
}

zle -N unambigandmenu
bindkey "^I" unambigandmenu

