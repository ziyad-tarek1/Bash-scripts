#!/bin/bash

length=12

# Generate a random password
password=$(openssl rand -base64 $length | tr -dc 'a-zA-Z0-9')

echo "Generated password: $password"
