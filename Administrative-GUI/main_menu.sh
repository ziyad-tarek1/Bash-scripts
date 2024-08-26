#!/bin/bash

OPTION=$(whiptail --title "Main Menu" --menu "Choose an option" --cancel-button "Exit" --ok-button "select"  25 78 16 \
	"Add User" "Create new user to the system." \
	"Modify User" "Modify an existing user." \
	"Delete User" "Delete an existing user." \
	"List Users" "List all users on the system." \
	"Change Password" "Change password of existing user" \
	"Disable User" "Lock user account." \
	"Enable User" "Unlock user account." \
	"Add Group" "Create new group to the system." \
	"Delete Group" "Delete an existing group." \
	"Modify Group" "Modify a group and its list of members." \
	"List Groups" "List all groups on the system." \
	"Exit" " " 3>&1 1>&2 2>&3)
if [ $? != 0 ] ; then  exit ; fi
case $OPTION in
	"Add User") bash ./add_user.sh ;;
	"Modify User") bash ./modify_user.sh ;;
        "Delete User") bash ./delete_user.sh ;;
        "List Users") bash ./list_users.sh ;;
	"Change Password") bash ./change_password.sh ;;
        "Disable User") bash ./disable_user.sh ;;
        "Enable User") bash ./enable_user.sh ;;
        "Add Group") bash ./add_group.sh ;;
	"Delete Group") bash ./delete_group.sh ;;
        "Modify Group") bash ./modify_group.sh ;;
	"List Groups") bash ./list_groups.sh ;;
	"Exit") exit 1 ;;
esac




