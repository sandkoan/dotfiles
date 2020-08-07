# load bashcompinit for some old bash completions
# Basic auto/tab complete:
zmodload -i zsh/complist

# bookmark directories, kind of like z
setopt cdablevars
code=~/Code
scripts=~/scripts
zrc=~/.zshrc
zdir=~/.config/zsh
doom=~/.config/doom
i3dir=~/.config/i3
kit=~/.config/kitty
qti=~/.config/qtile
ala=~/.config/alacritty
xmo=~/.xmonad/

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


# Sort filenames numerically when it makes sense
setopt numericglobsort 
 # Case insensitive globbing
setopt nocaseglob  

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' max-errors 5 numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' prompt 'Δ'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle :compinstall filename '~/.config/zsh/completions.zsh'


# Sets up support for colors and a calculator
autoload -Uz compinit zed zmv allopt colors zcalc
colors
compinit
# End of lines added by compinstall

autoload -U +X bashcompinit && bashcompinit
