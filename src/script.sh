#!/bin/bash

cat << EOF
zip2john is a command-line tool that is used to extract the hash of a password-protected ZIP archive file.
The hash that is generated by zip2john can then be used with password cracking tools such as John the Ripper 
to try and crack the password of the ZIP file.
EOF

echo ""

# Asking for the zip file name and storing it in the variable zipfile.
read -p "Enter zip file name: " zipfile

# Checking if the file exists or not.
if [[ ! -f "${zipfile}" ]]; then
    echo "Zip file not found."
    exit
fi

# Asking for the wordlist file name and storing it in the variable wordlist.
read -p "Enter wordlist file name: " wordlist

# Checking if the file exists or not.
if [[ ! -f "${wordlist}" ]]; then
    echo "Wordlist file not found."
    exit
fi

# Asking for the hash file name and storing it in the variable hash.
read -p "Enter hash file name: " hash

# Checking if the file exists or not.
if [[ -f "${hash}" ]]; then
    echo "Hash file already exists."
    exit
fi

# Creating a hash file from the zip file.
zip2john "$zipfile" > "$hash"

# Using the wordlist to crack the hash file.
echo "Starting cracking..."
sleep 3
john --wordlist="${wordlist}" --format=PKZIP "${hash}"

# Showing the password if found.
john --show "${hash}"
