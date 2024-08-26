#!/bin/bash
#if the user cancels the input
input_cancel() {
if [ $? -ne 0 ]; then
   exit 1
fi }

get_group_name() {
        group_name=$(whiptail --inputbox "Enter the group name to modify:" 8 39 --title "Modify Group" 3>&1 1>&2 2>&3)
        input_cancel
        #check if username is empty or not
        while [ -z "$group_name" ]; do
        whiptail --msgbox "Group name cannot be empty. Please enter a valid name." 8 70 --title "Modify Group"
        group_name=$(whiptail --inputbox "Enter the group name to modify :" 8 39 --title "Modify Group" 3>&1 1>&2 2>&3)
        input_cancel
	getent group $group_name &> /dev/null
        done
}

get_group_name
until [ $? -eq 0 ]; do
        whiptail --msgbox "This group '${group_name}' is not exist, choose another" 8 70 --title "Modify Group"
	get_group_name
done

sub_menu() {
ACTION=$(whiptail --title "Modify Group $group_name" --menu "Choose an action to modify :" 15 70 7 \
        "GID" "Change Group ID" \
	"Add Members" "set the list of members of group." \
        "back" "Go to main menu" 3>&1 1>&2 2>&3)
case $ACTION in
        "GID") ch_gid ;;
	"Add Members") add_users_grp ;;
        "back") ./main_menu.sh ;;
esac
}


ch_gid() {
	gid=$(whiptail --inputbox "Assign new GID to $group_name" 8 39 --title "Change GID" 3>&1 1>&2 2>&3)
        #validate gid
        # Check if GID is a number and within a valid range (e.g., 1000 to 60000)
        if [[ "$gid" =~ ^[0-9]+$ ]] && [ "$gid" -ge 1000 ] && [ "$gid" -le 60000 ]; then
                #check if GID is unique
                id -g $gid &> /dev/null
                if [ $? -eq 0 ]; then
                whiptail --msgbox "This GID '${gid}' already exist" 8 39 --title "GID validation"
                exit 1
                fi
                groupmod -g $gid $group_name
                whiptail --title " Change GID" --msgbox "GID for $group_name Successfully updated to $gid." 8 70
                sub_menu
        else
            	whiptail --msgbox "GID must be number in valid range (1000 to 60000) " 8 78 --title "GID validation"
                exit 1
        fi
}

add_users_grp() {
# Get the list of local users (UID >= 1000)
users=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

# Format users for whiptail checklist
menu_options=""
while IFS= read -r user; do
    menu_options+="$user $user \n"
done <<< "$users"

# Display a checklist to select users
selected_users=$(whiptail --title "Select Local Users" --checklist "Select one or more local users to add to the group:" 20 60 15 $menu_options 3>&1 1>&2 2>&3)

# Check if the user pressed Cancel
if [ $? -ne 0 ]; then
    echo "User selection was canceled."
    exit 1
fi

# Process selected users
IFS="|" read -r -a users_array <<< "$selected_users"

for user in "${users_array[@]}"; do
    user=$(echo "$user" | xargs)
    if [ -n "$user" ]; then
        # Add user to the group
        if sudo gpasswd -a "$user" "$group_name"; then
            whiptail --msgbox "User '$user' added to group '$group_name'" 8 39 --title "success"
	    ./main_menu.sh
        else
            whiptail --msgbox "Failed to add user '$user' to group '$group_name'." 8 39 --title "Failed"
        fi
    fi
done
}
sub_menu
