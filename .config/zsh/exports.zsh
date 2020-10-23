# exports

export EDITOR='nvim'

# Use syntax highlighting
[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
[ -f "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ] &&
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

[ -d "$HOME/bin" ] && PATH=$PATH:$HOME/bin

[ -d ~/bin/shell-color-scripts ] && PATH=$PATH:$HOME/bin/shell-color-scripts:$HOME/bin/shell-color-scripts/colorscripts

[ -d "$HOME/.emacs.d/bin/" ] && PATH=$PATH:~/.emacs.d/bin

[ -d "$HOME/.cargo/bin" ] && PATH=$PATH:$HOME/.cargo/bin


# Kitty blur only works on KDE
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
    for wid in $(xdotool search --pid $PPID); do
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

# color man pages
# export LESS_TERMCAP_mb=$'\E[01;32m'
# export LESS_TERMCAP_md=$'\E[01;32m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;47;34m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;36m'
# export LESS=-r

# vim as a pager
# export PAGER="nvim -R"
# vim as a manpager
export MANPAGER='nvim +Man!'
# soft-wrapping
export MANWIDTH=999

# export VISUAL="emacsclient -c -a emacs"   # $VISUAL use Emacs in GUI mode
# export ALTERNATE_EDITOR=""
export ZSHRC="~/.zshrc"

if [ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi
