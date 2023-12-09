#!/bin/bash

# Function to calculate the duration of audio files in a folder
calculate_duration() {
    folder_name=$(basename "$1")
    folder_duration=0

    for file in "$1"/*.wav; do
        temp_temp=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")
        if [[ -n "$temp_temp" ]]; then
            folder_duration=$(echo "scale=2; $folder_duration + $temp_temp" | bc)
        fi
    done

    echo "$folder_name => $folder_duration"
    echo "$folder_name => $folder_duration" >> text.txt
    echo "$folder_duration" >> temp_duration.txt
}

# Get a list of all folders in the current directory
folder_dir=($(find . -maxdepth 1 -type d))

# Remove temporary files if they exist
rm text.txt
rm temp_duration.txt

# Run the calculate_duration function in parallel for each folder
export -f calculate_duration
parallel calculate_duration ::: "${folder_dir[@]}"

# Calculate the total duration from the temporary file
total_duration=$(awk '{sum += $1} END {print sum}' temp_duration.txt)

# Print the overall total duration of all audio files combined
echo "total Duration => $total_duration" >> temp.txt
echo "total Duration => $total_duration"

# Remove the temporary file
rm temp_duration.txt

