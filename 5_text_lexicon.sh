rm text_lexicon.txt

while read -r line; do

    # words=($line)
    # echo "${words[0]} $(cat "${words[1]::-4}.txt")" >> text_lexicon.txt

    echo "$line" | cut -d ' ' -f 1 --complement >> text_lexicon_before.txt

done < text