#!/bin/bash

# Get a list of all folders in the current directory
folder_dir=($(find . -maxdepth 1 -type d))

rm wav.scp

for dir in "${folder_dir[@]}"; do

    # Extract the folder name from the full path
    folder_name=$(basename "$dir")
    echo $folder_name

    # Loop through all files in the folder
    count=1
    for file in "$dir"/*.wav; do
        # To make sure the ffprobe is not returning ntg
        # echo $file
        if [[ -f "$file" && "$file" == *.wav ]]; then
            echo $folder_name"_"$count" "$(readlink -f $file) >> wav.scp
        fi
        ((count =count + 1))
    done
done
