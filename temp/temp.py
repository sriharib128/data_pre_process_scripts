import re

text = "harin,45,54 65.65 h.ar,3"

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

