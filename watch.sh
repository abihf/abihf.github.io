#!/bin/bash

curdir=$(cd `dirname "$0"`; pwd)
conf_file="${curdir}/public/.watch"

export PATH=${curdir}/node_modules/.bin:$PATH

main() {
    workdir=$(cd `dirname "$conf_file"`; pwd)

    read_conf "$conf_file"
    while true; do
        main_loop
        sleep 1
    done
}

main_loop() {
    for name in ${names}; do
        cd "${workdir}/$( get ${name}_base )"
        out=$( get ${name}_out )
        watch="$( get ${name}_watch )"
        out_time=$( filemtime "$out" )

        #is_changed $watch
        changed=0
        for f in ${watch}; do
            in_time=$( filemtime "$f" )
            if [ ${in_time} -gt $out_time ]; then
                echo " # $f changed $in_time > $out_time"
                changed=1
            fi
        done

        if [ ${changed} = "1" ]; then
            cmd=$( get ${name}_cmd )
            echo " # executing $cmd"
            eval ${cmd}
            echo "---"
        fi
    done
}

read_conf() {
    eval $(
        cat "$1" | while read line; do
            if [ "[" = "${line:0:1}" ]; then
                prefix="${line:1:-1}"
                echo "names=\"\$names $prefix\""
            elif [ -n "$line" -a "#" != "${line:0:1}" ]; then
                echo "${prefix}_${line}"
            fi
        done
    )
}

get() {
    eval "tmp=\$$1"
    echo $tmp
}

filemtime() {
    if [ -e "$1" ]; then
        stat -c %Y "$1"
    else
        echo 0
    fi
}

main