if [[ ! -a ~/.config/zsh/zsh-async ]]
then
    git clone -b 'v1.5.2' https://github.com/mafredri/zsh-async.git ~/.config/zsh/zsh-async 2> /dev/null
fi
source ~/.config/zsh/zsh-async/async.zsh

# enable substitution for prompt
setopt prompt_subst

# change cursor and prompt depending on vi mode
vim_ins_mode="❯"
vim_cmd_mode="❮"
vim_mode=$vim_ins_mode
echo -ne '\e[5 q'

function zle-keymap-select {
    if [ $KEYMAP = vicmd ]
    then
        vim_mode=$vim_cmd_mode
        echo -ne '\e[1 q'
    else
        vim_mode=$vim_ins_mode
        echo -ne '\e[5 q'
    fi
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() {
    vim_mode=$vim_ins_mode
    return $(( 128 + $1 ))
} 

exit_status() {
    # 256 colors
    echo '%(?.%F{76}${vim_mode}%f %{$reset_color%}.%F{196}${vim_mode}%f %{$reset_color%})'
}
exit_status_root(){
    echo '%(?.%{$fg[green]%}# %{$reset_color%}.%{$fg[red]%}# %{$reset_color%})'
}

PROMPT="%(!.%{$fg[red]%}%1~%{$reset_color%} "$(exit_status_root)" .%F{32}%(4~|%-2~/.../%1~|%~)%f%{$reset_color%} "$(exit_status)""

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
    # Show Git branch/tag, or name-rev if on detached head
    ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
    # Show different symbols as appropriate for various Git repository states
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi
    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi
    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi
    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

git_prompt_string() {
    local git_where="$(parse_git_branch)"

  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg_bold[blue]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"

  [ ! -n "$git_where" ] && echo "%F{32}%D{%r}%f"

}

# # There are 2 ways to set color -> in the terminal emulator (like in kitty.conf), or the zshell itself which is what I'm doing
# # Base16 Shell color themes.
# # possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
# # atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties, 
# # embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
# # marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
# # solarized, summerfruit, tomorrow, twilight
# theme="londontube"
# # Possible variants: dark and light
# shade="dark"

# BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

RPROMPT='$(git_prompt_string)'
