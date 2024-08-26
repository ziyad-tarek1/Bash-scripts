#!/bin/bash
# Function to delete a group
delete_group() {
    group_name="$1"
    # Confirm group deletion
    if  whiptail --title "Confirm Deletion" --yesno "Are you sure you want to delete the group '$group_name'?" 8 60; then
        #press yes --> Delete the user
        groupdel  $group_name
        if [ $? -eq 0 ]; then
                whiptail --title "Success" --msgbox "Group '$group_name' deleted successfully." 8 60
                ./main_menu.sh
        else
            	whiptail --title "Error" --msgbox "Failed to delete group '$group_name'." 8 60
                exit 1
        fi
   else
       	whiptail --title "Delete Group" --msgbox "Deletion cancelled" 8 40
        exit 1
   fi
}
# Get the list of groups (excluding system groups)
groups=$(awk -F: '$3 >= 1000 {print $1}' /etc/group)

# Display the user list and let the admin choose a user to delete
group_name=$(whiptail --title "Delete Group" --menu "Select the group to delete:" 15 50 7 \
$(echo "$groups" | awk '{print $1 , NR }') 3>&1 1>&2 2>&3)

if [ $? != 0 ]; then
    exit 1
fi

# Call the function to delete the user
delete_group "$group_name"
