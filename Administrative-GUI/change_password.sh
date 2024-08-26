#!/bin/bash
#if the user cancels the input
input_cancel() {
if [ $? -ne 0 ]; then
   exit 1
fi }
#check if user is root or not
if [ $UID -eq 0 ]; then

        username=$(whiptail --inputbox "Enter the username:" 8 39 --title "Change Password" 3>&1 1>&2 2>&3)
        input_cancel
        #check if username is empty or not
        while [ -z "$username" ]; do
        whiptail --msgbox "User name cannot be empty. Please enter a valid name." 8 60 --title "Change Password"
        username=$(whiptail --inputbox "Enter the username:" 8 45 --title "Add User" 3>&1 1>&2 2>&3)
        input_cancel
        done
        #check if user exist
        id $username &>/dev/null
        while [ $? -ne 0 ]; do
        whiptail --msgbox "This username '${username}' is not exist, Exiting" 8 70 --title "Change Password"
        exit 1
        done

        #set password
        pass1=$(whiptail --passwordbox "please enter new password for user $username" 8 78 --title "Change Password" 3>&1 1>&2 2>&3)
        input_cancel
	#check if password is empty or not
        while [ -z "$pass1" ]; do
        whiptail --msgbox "No new password entered." 8 39 --title "Change Password"
        pass1=$(whiptail --passwordbox "please enter password for user $username" 8 78 --title "Change Password" 3>&1 1>&2 2>&3)
        input_cancel
	done

	pass2=$(whiptail --passwordbox "Retype new password" 8 78 --title "Change Password" 3>&1 1>&2 2>&3)
        input_cancel
	#check if passwords match or not
        until [ $pass1 -eq $pass2  ]; do
                whiptail --msgbox "Passwords do not match." 8 39 --title "Change Password"
                pass1=$(whiptail --passwordbox "please enter $username secret password" 8 78 --title "set password" 3>&1 1>&2 2>&3)
                input_cancel
		pass2=$(whiptail --passwordbox "Retype new password" 8 78 --title "Change Password" 3>&1 1>&2 2>&3)
        	input_cancel
	done
            	echo "$username:$pass2" | chpasswd
                whiptail --msgbox "all authentication tokens updated successfully." 8 60 --title "Change Password"
		./main_menu.sh
else
   whiptail --msgbox "you need root privilages to change password" 8 50 --title "Change Password"
   exit 1
fi

