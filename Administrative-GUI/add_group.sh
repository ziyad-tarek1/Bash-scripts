#!/bin/bash
#if the user cancels the input
input_cancel() {
if [ $? -ne 0 ]; then
   exit 1
fi }

get_group_name() {
        group_name=$(whiptail --inputbox "Enter the group name to add:" 8 39 --title "Add Group" 3>&1 1>&2 2>&3)
        input_cancel
        #check if username is empty or not
        while [ -z "$group_name" ]; do
        whiptail --msgbox "Group name cannot be empty. Please enter a valid name." 8 70 --title "Add Group"
        group_name=$(whiptail --inputbox "Enter the group name to add :" 8 39 --title "Add Group" 3>&1 1>&2 2>&3)
        input_cancel
        done
}

get_group_name
#check if group exist
id -g $group_name &> /dev/null
while [ $? -eq 0 ]; do
	whiptail --msgbox "This group (${group_name}) already exist, choose another" 8 70 --title "Add Group"
	get_group_name
done

#create new group
        groupadd $group_name
        whiptail --msgbox "Group '$group_name' created successfully." 8 39 --title "Add Group"
	./main_menu.sh

