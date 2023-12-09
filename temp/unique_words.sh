#!/bin/bash

# Replace 'your_file.txt' with the actual path to your text file
filename="temp.txt"

rm words_lexicon.txt

# Loop through each unique word and print it
tempword=""
while IFS= read -r word; do
    normalized_word = "${word// /}"
    if [[ "$tempword" != "$normalized_word" ]]; then
        echo "$normalized_word" >> words_lexicon.txt
        tempword="$normalized_word"
    fi
done <<< "$_words"
