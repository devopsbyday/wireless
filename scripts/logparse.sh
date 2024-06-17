#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file> <value>"
    exit 1
fi

# Assign input arguments to variables
file="$1"
value="$2"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Search for the specified value in the file
grep "$value" "$file"

# Print a success message
echo "Search complete. Found occurrences of '$value' in '$file'."
