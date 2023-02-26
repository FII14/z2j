#!/bin/bash

# Check if zip2john is installed
if ! command -v zip2john &> /dev/null
then
    echo "zip2john not found. Please install it first."
    exit
fi

# Ask for zip file name
read -p "Enter zip file name: " zipfile

if [[ ! -f "${zipfile}" ]]; then
    echo "Zip file not found."
    exit
fi

# Ask for wordlist file name
read -p "Enter wordlist file name: " wordlist

if [[ ! -f "${wordlist}" ]]; then
    echo "Wordlist file not found."
    exit
fi

# Ask for hash file name
read -p "Enter hash file name: " hash

if [[ -f "${hash}" ]]; then
    echo "Hash file already exists."
    exit
fi

# Check if zip file exists
if [ ! -f "$zipfile" ]
then
    echo "Zip file not found."
    exit
fi

# Create zip hash file using zip2john
zip2john "$zipfile" > "$hash"

# Try to crack zip file password
echo "Starting cracking..."
john --wordlist="${wordlist}" --format=PKZIP "${hash}"

# Show password if found
john --show "${hash}"
