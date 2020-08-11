# vi mode
bindkey -v
export KEYTIMEOUT=20

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Fancy ctrl+z
function fancy-ctrl-z () {
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

# Edit line in vim with ctrl-q:
autoload edit-command-line; zle -N edit-command-line
bindkey '^q' edit-command-line
