import re
import inflect

def replace_num(ch, text):
    pattern = rf'(\d){re.escape(ch)}(\d)'  # Corrected pattern with re.escape
    matches = re.finditer(pattern, text)

    indices_to_keep = [(match.start() + 1) for match in matches]
    pattern = re.escape(ch)  # Use re.escape here as well
    matches = re.finditer(pattern, text)

    indices = [match.start() for match in matches if match.start() not in indices_to_keep]
    
    string_list = list(text)
    for i in indices:
        string_list[i] = ' '
    text = ''.join(string_list)
    return text

def preprocess_line(line):

    indices_object = re.finditer(pattern=',', string=line)
    for index in indices_object:
        print(index)
    # Add space between digits and text
    line = re.sub(r'(\d)([a-zA-Z])', r'\1 \2', line)
    line = re.sub(r'([a-zA-Z])(\d)', r'\1 \2', line)
    # Add space before and after parentheses, hyphens, and periods
    line = re.sub(r'([\d)])([(-])', r'\1 \2', line)
    line = re.sub(r'([(-])([\d(])', r'\1 \2', line)
    line = re.sub(r'(\d)%', r'\1 %', line)
    # Convert the line to lowercase
    line = line.lower()
    return line

def replace_numbers_with_pronunciations(line):
    p = inflect.engine()
    words = line.split()
    new_words = []

    for word in words:
        if word == '%':
            new_words.append('percent')
        elif word.replace(',', '').replace('.', '').isdigit():
            if '.' in word:
                num = float(word.replace(',', ''))
                new_words.append(p.number_to_words(num, decimal='point'))
            else:
                num = int(word.replace(',', ''))
                new_words.append(p.number_to_words(num))
        else:
            new_words.append(word)
    new_line = (' '.join(new_words)) + '\n'
    return new_line

def main(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    new_lines = []

    for line in lines:
        # Preprocess each line
        preprocessed_line = preprocess_line(line)
        # Replace numbers and percentages with pronunciations
        new_line = replace_numbers_with_pronunciations(preprocessed_line)
        new_lines.append(new_line)

    with open(output_file, 'w') as f:
        f.writelines(new_lines)

if __name__ == '__main__':
    input_file = 'text_lexicon_before.txt'  # Replace with your input file path
    output_file = 'text_lexicon_after.txt'  # Replace with your output file path
    main(input_file, output_file)
