import re
import sys

input_file = "text_lexicon_after.txt"

# Read input file and replace periods with spaces
with open(input_file, 'r') as f:
    content = f.read()

content = content.replace('.', ' ')

# Preprocess the text: remove punctuation (except comma) and convert to lowercase
processed_text = re.sub(r'[^\w\s,]', ' ', content).lower()

# Replace multiple spaces with single space
processed_text = re.sub(r'\s+', ' ', processed_text)

# Split processed text into words using spaces
words = sorted(set(processed_text.split()))

with open("unique.txt", 'w') as f:
    f.write('\n'.join(words))

print("Unique words saved to unique.txt")
