# source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# # source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
# source ~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

export VISUAL="emacsclient -c -a emacs"   # $VISUAL use Emacs in GUI mode
export ALTERNATE_EDITOR=""

# Kitty blur only works on KDE
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
    for wid in $(xdotool search --pid $PPID); do
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

if [ -d "$HOME/bin" ]; then
    PATH=$PATH:$HOME/bin
fi

if [ -d ~/bin/shell-color-scripts ]; then 
    PATH=$PATH:$HOME/bin/shell-color-scripts:$HOME/bin/shell-color-scripts/colorscripts
fi

if [ -d "$HOME/.emacs.d/bin/" ]; then
    PATH=$PATH:~/.emacs.d/bin
fi

if [ -d "$HOME/.cargo/bin" ]; then
    PATH=$PATH:$HOME/.cargo/bin
fi

# color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

