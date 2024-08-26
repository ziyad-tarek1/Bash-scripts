#!/bin/bash

# Get the list of users (excluding system users)
users=$(cut -d: -f1 /etc/passwd)

# Display the user list and let the admin choose a user to delete
whiptail --title "List Users" --menu "List of all users in system:" 25 78 15 \
$(echo "$users" | awk '{print $1 , NR}')

./main_menu.sh

#if user input cancel
if [ $? -ne 0 ] ; then
 exit 1
fi
