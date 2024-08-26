#!/bin/bash
website="https://github.com/ziyad-tarek1/Youtube-dowenlader"
# Check if website is accessible
if curl --output /dev/null --silent --head --fail "$website"; then
echo "Website is up."
else
echo "Website is down."
fi
