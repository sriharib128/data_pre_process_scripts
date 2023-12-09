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

sed -i 's/\./ /g' "$input_file"

# Preprocess the text file: remove punctuation and convert to lowercase
cat "$input_file" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' > temp_processed_text

# replace multiple spaces with single space
processed_text=$(python -c "
with open("temp_processed_text", 'r') as f:
    content = f.read()

text = re.sub(r'\s+', ' ', text)
text = re.sub()

with open("processed_text", 'w') as f:
    f.write(modified_content)
    
")

# Split the processed text into words using spaces
words=$(echo "$processed_text" | tr ' ' '\n' | sort -u )

echo "$words" > unique.txt