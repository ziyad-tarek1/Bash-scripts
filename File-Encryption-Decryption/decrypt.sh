#!/bin/bash

# Source the functions file
source functions.sh

# Set the file path
read -p "Enter your file path as /path/tofile.txt: " file

echo "Choose a decryption method:"
echo "1. AES-256-CBC"
echo "2. AES-128-CBC"
echo "3. DES3"
echo "4. Base64"
read -p "Enter your choice: " method

case $method in
  1)
    decrypt_file aes-256-cbc "$file"
    ;;
  2)
    decrypt_file aes-128-cbc "$file"
    ;;
  3)
    decrypt_file des3 "$file"
    ;;
  4)
    decrypt_file base64 "$file"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

echo "File $file has been decrypted"
