import re
from collections import defaultdict

def pre_process(text):
    # Convert to lowercase
    text = text.lower()

    # Replace URLs with <URL>
    text = re.sub(
        r'(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?', '<URL>', text)

    # Replace hashtags with <HASHTAG>
    text = re.sub(r'#\w+', '<HASHTAG>', text)

    # Replace mentions with <MENTION>
    text = re.sub(r'@\w+', '<MENTION>', text)

    # Replace with <PERCENT>
    text = re.sub(r'(\d+(\.\d+)?%)', "<PERCENT>", text)

    # Replace multiple spaces with a single space
    text = re.sub(r'\s+', ' ', text)

    # replace numbers with <NUM>
    text = re.sub("^\d+\s|\s\d+\s|\s\d+$", " <NUM> ", text)
    text = re.sub(r'\b\d+\w*\b', '<NUM>', text)
    text = re.sub(r'\w*\d\w*', '<NUM>', text)

    # contractions
    text = re.sub(r"can't", "can not", text)
    text = re.sub(r"won't", "will not", text)

    # hypens and underscore characters at beginning and end of words
    text = re.sub(r'(\b|\-|_)(\w+)\-?(\b|\-|_)', r'\2 ', text)
    text = re.sub(r'(\b|\-|_)(\w+)\-?(\b|\-|_)', r'\2 ', text)

    # Ensure that there's a space between punctuation and words
    text = re.sub(r'(\w)([.,!?])', r'\1 \2', text)
    text = re.sub(r'([.,!?])(\w)', r'\1 \2', text)

    # Remove all punctuation
    text = re.sub(r'[^\w\s]', '', text)

    # Split the text into words
    words = text.split()

    # make dict word freq
    word_freq = defaultdict(int)
    for word in words:
        word_freq[word] += 1

    # vocab contains unique tokens with freq > 5
    vocabulary = [word for word, count in word_freq.items()]
    return vocabulary

with open('1.txt') as file:
    fdata = file.read()

# cleaned_text = cleean(text)
unique_words = pre_process(fdata)

# Write the unique words to the file
with open('unique.txt', 'w') as f:
    f.write('\n'.join(unique_words))
