#!/bin/bash
rm utt2spk
while read -r line; do
    words=($line)
    echo "${words[0]} ${words[0]}" >> utt2spk
done < wav.scp
