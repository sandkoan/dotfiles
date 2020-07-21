# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="~/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# [ -f $HOME/.config/zsh/prompt.zsh ] && source $HOME/.config/zsh/prompt.zsh
[ -f $HOME/.config/zsh/aliases.zsh ] && source $HOME/.config/zsh/aliases.zsh
[ -f $HOME/.config/zsh/functions.zsh ] && source $HOME/.config/zsh/functions.zsh
[ -f $HOME/.config/zsh/history.zsh ] && source $HOME/.config/zsh/history.zsh
[ -f $HOME/.config/zsh/exports.zsh ] && source $HOME/.config/zsh/exports.zsh


if [ -d "$HOME/bin" ]
then
    export PATH=$PATH:$HOME/bin
fi

if [ -d "/opt/shell-color-scripts" ]
then
    export PATH=$PATH:/opt/shell-color-scripts
fi

startcolors (){
    r=$(shuf -n 1 -e 0 1 2 3 4 5)
    if [ $r -lt 3 ]
    then
        colorscript.sh random
    else 
        fortune | cowsay | lolcat -t
    fi
}

startcolors

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
