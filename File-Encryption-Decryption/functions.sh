#!/bin/bash

# Set the password
password="yourpassword"

# Function to encrypt a file
encrypt_file() {
  local method=$1
  local file=$2

  case $method in
    aes-256-cbc)
      openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -pass pass:$password
      ;;
    aes-128-cbc)
      openssl enc -aes-128-cbc -salt -in "$file" -out "$file.enc" -pass pass:$password
      ;;
    des3)
      openssl enc -des3 -salt -in "$file" -out "$file.enc" -pass pass:$password
      ;;
    base64)
      openssl enc -base64 -in "$file" -out "$file.b64"
      ;;
    *)
      echo "Invalid encryption method"
      exit 1
      ;;
  esac
}

# Function to decrypt a file
decrypt_file() {
  local method=$1
  local file=$2

  case $method in
    aes-256-cbc)
      openssl enc -d -aes-256-cbc -salt -in "$file.enc" -out "$file" -pass pass:$password
      ;;
    aes-128-cbc)
      openssl enc -d -aes-128-cbc -salt -in "$file.enc" -out "$file" -pass pass:$password
      ;;
    des3)
      openssl enc -d -des3 -salt -in "$file.enc" -out "$file" -pass pass:$password
      ;;
    base64)
      openssl enc -d -base64 -in "$file.b64" -out "$file"
      ;;
    *)
      echo "Invalid encryption method"
      exit 1
      ;;
  esac
}
