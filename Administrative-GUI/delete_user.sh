#!/bin/bash
# Function to delete a user
delete_user() {
    username="$1"
    # Confirm user deletion
    if  whiptail --title "Confirm Deletion" --yesno "Are you sure you want to delete the user '$username'?" 8 60; then
	#press yes --> Delete the user
	userdel -r "$username"
	if [ $? -eq 0 ]; then
        	whiptail --title "Success" --msgbox "User '$username' deleted successfully." 8 60
		./main_menu.sh
	else
		whiptail --title "Error" --msgbox "Failed to delete user '$username'." 8 60
		exit 1
	fi
   else
	whiptail --title "Delete User" --msgbox "Deletion cancelled" 8 40
	exit 1
   fi
}
# Get the list of users (excluding system users)
users=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

# Display the user list and let the admin choose a user to delete
username=$(whiptail --title "Delete User" --menu "Select the user to delete:" 15 50 7 \
$(echo "$users" | awk '{print $1 , NR }') 3>&1 1>&2 2>&3)

#if user press cancel
if [ $? != 0 ]; then
    exit 1
fi

# Call the function to delete the user
delete_user "$username"
