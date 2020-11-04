ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# fff - cd on exit
if command -v fff &> /dev/null; then
  f() {
      fff "$@"
      cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
  }
fi


function countdown() {
    date1=$((`date +%s` + (60 * $1)));
    while [ "$date1" -ge `date +%s` ]; do
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r" | lolcat -t;
        sleep 0.1
    done
}

# After 220 seconds, run screen saver (either pipes or cmatrix)
TMOUT=300
if command -v pipes.sh &> /dev/null; then
  PIPES() {
      x=$(shuf -n 1 -e 0 ${4-8})
      pipes.sh -t $x
  }
fi

if command -v unimatrix &> /dev/null; then
  MATRIX() {
      y=$(shuf -n 1 -e 0 1)
      if [ $y -eq 0 ]
      then 
          unimatrix -a -f -s 96 -c blue
      else 
          unimatrix -f -s 96
      fi
  }
fi

if typeset -f PIPES &> /dev/null && typeset -f MATRIX &> /dev/null; then
  TRAPALRM() {
      n=$(shuf -n 1 -e 1 2 3 4 5 6 7 8 9 10)
      if [ $n -lt 7 ]
      then
          PIPES
      else
          MATRIX
      fi
  }
fi

startcolors() {
    r=$(shuf -n 1 -e 0 1 2 3 4 5)
    if [ $r -lt 4 ]
    then
      if command -v colorscript &> /dev/null; then
          colorscript random
      fi
    else
      if command -v fortune &> /dev/null && command -v cowsay &> /dev/null && command -v lolcat &> /dev/null; then
          fortune | cowsay | lolcat -t
      fi
    fi
}

if command -v curl &> /dev/null
  wttr() {
      curl wttr.in
  }
fi

startcolors

autoload -U tetriscurses sticky-note
autoload -U calendar zed zmv allopt zcalc
