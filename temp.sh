#!/bin/bash

# Get a list of all folders in the current directory
folder_dir=($(find . -maxdepth 1 -type d))

for dir in "${folder_dir[@]}"; do

    # Extract the folder name from the full path
    folder_name=$(basename "$dir")
    echo -ne $folder_name
    
    echo " "$(find ./$folder_name -type f | wc -l )
done
