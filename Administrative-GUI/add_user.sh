#!/bin/bash
#if the user cancels the input
input_cancel() {
if [ $? -ne 0 ]; then
   exit 1
fi }

get_username() {
        username=$(whiptail --inputbox "Enter the username to add:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
        input_cancel
        #check if username is empty or not
	while [ -z "$username" ]; do
        whiptail --msgbox "User name cannot be empty. Please enter a valid name." 8 70 --title "Add User"
        username=$(whiptail --inputbox "Enter the username to add :" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
        input_cancel
	done
}

set_password() {
        pass1=$(whiptail --passwordbox "please enter password for user $username" 8 78 --title "set password" 3>&1 1>&2 2>&3)
        input_cancel
        #check if password is empty or not
        while [ -z "$pass1" ]; do
        	whiptail --msgbox "No new password entered." 8 39 --title "Set password "
        	pass1=$(whiptail --passwordbox "please enter password for user $username" 8 78 --title "set password" 3>&1 1>&2 2>&3)
        	input_cancel
        done
        pass2=$(whiptail --passwordbox "Retype new password" 8 78 --title "set password" 3>&1 1>&2 2>&3)
        input_cancel
}

#check if user is root or not
if [ $UID -eq 0 ]; then
	get_username
	#check if user exist
        id $username &>/dev/null
        while [ $? -eq 0 ]; do
        whiptail --msgbox "This username (${username}) already exist, choose another" 8 70 --title "Add User"
	get_username
        done

	#add user
        useradd $username
        whiptail --msgbox "User $username added successfully." 8 39 --title "Add User"

	set_password
	#check if passwords match
        until [ $pass1 -eq $pass2  ]; do
                whiptail --msgbox "Passwords do not match." 8 39 --title "set password"
		set_password
        done
            	echo "$username:$pass2" | chpasswd
                whiptail --msgbox "all authentication tokens updated successfully." 8 60 --title "set password"
                ./main_menu.sh

else
   whiptail --msgbox "you need root privilages to add user" 8 50 --title "Add User"
fi
