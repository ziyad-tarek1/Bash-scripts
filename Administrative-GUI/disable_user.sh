#!/bin/bash
username=$(whiptail --inputbox "Enter the username to lock:" 8 45 --title "Lock User Account" 3>&1 1>&2 2>&3)
if [ -z "$username" ]; then
    whiptail --msgbox "No username entered. Exiting."
    exit 1
fi
#check if user exist
id $username &>/dev/null
while [ $? -ne 0 ]; do
   whiptail --msgbox "This username (${username}) is not exist" 8 60 --title "Lock User Account"
   exit 1
done

# Lock the user account
usermod -L $username

if [ $? -eq 0 ]; then
    whiptail --msgbox "User account '$username' has been locked successfully!" 10 60
    ./main_menu.sh
else
    whiptail --msgbox "Failed to lock user account '$username'!" 10 60
    exit 1
fi
