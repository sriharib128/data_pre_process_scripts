#!/bin/bash

# Get a list of all folders in the current directory
folder_dir=($(find . -maxdepth 1 -type d))

rm text.txt

total_duration=0

for dir in "${folder_dir[@]}"; do

    # Extract the folder name from the full path
    folder_name=$(basename "$dir")

    folder_duration=0

    # Loop through all files in the folder
    for file in "$dir"/*.wav; do

        temp_temp=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")

        # To make sure the ffprobe is not returning ntg
        if [[ -n "$temp_temp" ]]; then
            folder_duration=$(echo "scale=2; $folder_duration + $temp_temp" | bc)
        fi

    done

    echo "$folder_name => $folder_duration"
    echo "$folder_name => $folder_duration" >> text.txt

    total_duration=$(echo "scale=2; $total_duration + $folder_duration" | bc) 
    echo "Total_duration => $total_duration"
    echo "-------------------------------------------------------------------"
done
echo "total Duration => $total_duration" >> temp.txt
echo "total Duration => $total_duration"
