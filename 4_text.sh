#!/bin/bash
rm text
while read -r line; do
    words=($line)
    text=$(cat "${words[1]::-4}.txt")
    if [ -n "$text" ]; then
        echo "${words[0]} $text" >> text
    fi
done < wav.scp

