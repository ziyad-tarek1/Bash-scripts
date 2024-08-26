#!/bin/bash

# Get the list of groups (excluding system users)
groups=$(cut -d: -f1 /etc/group)

# Display the group list
whiptail --title "List Users" --menu "List of all groups in system:" 25 78 15 \
$(echo "$groups" | awk '{print $1 , NR}')

./main_menu.sh

#if user input cancel
if [ $? -ne 0 ] ; then
 exit 1
fi
