function countdown() {
    date1=$((`date +%s` + (60 * $1)));
    while [ "$date1" -ge `date +%s` ]; do
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r" | lolcat -t;
        sleep 0.1
    done
}

# After 220 seconds, run screen saver (either pipes or cmatrix)
TMOUT=220

PIPES() {
    x=$(shuf -n 1 -e 0 ${4-8})
    pipes.sh -t $x
}

MATRIX() {
    y=$(shuf -n 1 -e 0 1)
    if [ $y -eq 0 ]
    then 
        cmatrix -ms -C cyan
    else 
        cmatrix -s -C cyan
    fi
}

TRAPALRM() {
    n=$(shuf -n 1 -e 1 2 3 4 5 6 7 8 9 10)
    if [ $n -lt 7 ]
    then
        PIPES
    else
        MATRIX
    fi
}
