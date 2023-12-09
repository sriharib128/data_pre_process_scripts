#!/bin/bash
# tr '[:upper:]' '[:lower:]' < input.txt > output.txt

rm temp.txt
rm words_lexicon.txt

# Check if a file is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Preprocess the text file: remove punctuation and convert to lowercase
temp_processed_text=$(cat "$input_file" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]')

# replace multiple spaces with single space
processed_text=$(python -c "

import re
import sys
text = sys.argv[1]
text = re.sub(r'\s+', ' ', text)
print(text)

" "$temp_processed_text")

# Split the processed text into words using spaces
words=$(echo "$processed_text" | tr ' ' '\n' | sort -u )

echo "$words" > unique.txt