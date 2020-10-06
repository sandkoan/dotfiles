# vi mode
bindkey -v
export KEYTIMEOUT=20

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
# fix delete key
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# use ctrl-z to toggle background processes
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


# vim surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# History substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Emacs-like bindings in insert mode
bindkey -M viins '^A' beginning-of-line                  
bindkey -M viins '^E' end-of-line                  
bindkey -M viins '^F' forward-char                  
bindkey -M viins '^K' kill-line                  
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward  
bindkey -M viins '^U' backward-kill-line 
bindkey -M viins '^W' backward-kill-word   
bindkey -M viins '^Y' yank   
bindkey -M viins '^_' undo                        

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


# [Esc-l] - run command: ls
bindkey -s '\el' 'ls\n' 


# file rename magick
bindkey "^[m" copy-prev-shell-word
 
# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
