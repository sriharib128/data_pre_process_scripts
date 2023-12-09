#!/bin/bash

# Define a variable in Bash
bash_variable="Hello from Bash!"

# Run the Python script and pass the Bash variable as an argument
python_output=$(python -c "
import sys

# Access the argument passed from the Bash script
bash_variable = sys.argv[1]

print('Python received:', bash_variable)
print('Python processing...')
" "$bash_variable")

# Print the Python output obtained in the Bash script
echo "Python output:"
echo "$python_output"
