[ -f $HOME/.config/zsh/exports.zsh ] && source $HOME/.config/zsh/exports.zsh
[ -f $HOME/.config/zsh/aliases.zsh ] && source $HOME/.config/zsh/aliases.zsh
[ -f $HOME/.config/zsh/history.zsh ] && source $HOME/.config/zsh/history.zsh
[ -f $HOME/.config/zsh/functions.zsh ] && source $HOME/.config/zsh/functions.zsh
[ -f $HOME/.config/zsh/keys.zsh ] && source $HOME/.config/zsh/keys.zsh
[ -f $HOME/.config/zsh/dirs.zsh ] && source $HOME/.config/zsh/dirs.zsh
[ -f $HOME/.config/zsh/completions.zsh ] && source $HOME/.config/zsh/completions.zsh
[ -f $HOME/.config/zsh/prompt.zsh ] && source $HOME/.config/zsh/prompt.zsh

# opam configuration
test -r /home/govindg/.opam/opam-init/init.zsh && . /home/govindg/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
