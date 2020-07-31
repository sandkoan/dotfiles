# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -f $HOME/.config/zsh/aliases.zsh ] && source $HOME/.config/zsh/aliases.zsh
[ -f $HOME/.config/zsh/functions.zsh ] && source $HOME/.config/zsh/functions.zsh
[ -f $HOME/.config/zsh/history.zsh ] && source $HOME/.config/zsh/history.zsh
[ -f $HOME/.config/zsh/exports.zsh ] && source $HOME/.config/zsh/exports.zsh
[ -f $HOME/.config/zsh/keys.zsh ] && source $HOME/.config/zsh/keys.zsh

if [ -d "$HOME/bin" ]; then
    PATH=$PATH:$HOME/bin
fi

if [ -d ~/bin/shell-color-scripts ]; then 
    PATH=$PATH:~/bin/shell-color-scripts:~/bin/shell-color-scripts/colorscripts
fi

startcolors() {
    r=$(shuf -n 1 -e 0 1 2 3 4 5)
    if [ $r -lt 4 ]
    then
        colorscript random
    else 
        fortune | cowsay | lolcat -t
    fi
}

startcolors

# Kitty blur only works on KDE {{{
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi
# }}}


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
