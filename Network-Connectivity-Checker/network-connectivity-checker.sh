#!/bin/bash

host="8.8.8.8"

# Check network connectivity by pinging a host
if ping -c 1 "$host" &>/dev/null; then
    echo "Network is up."
else
    echo "Network is down."
fi
