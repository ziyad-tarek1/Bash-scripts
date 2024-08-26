#!/bin/bash
#check if press cancel
input_cancel() {
if [ $? -ne 0 ] ; then
   exit 1
fi }
get_username() {
	username=$(whiptail --inputbox "Enter the username to modify :" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
	input_cancel
	#check if username is empty or not
	while [ -z "$username" ]; do
	whiptail --msgbox "User name cannot be empty. Please enter a valid name." 8 39 --title "Enter user to modify"
	username=$(whiptail --inputbox "Enter the username to modify :" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
	input_cancel
	done
}
get_username
#check user exist
id $username &> /dev/null
until [ $? -eq 0 ]; do
    whiptail --msgbox "This username (${username}) is not exist" 8 39 --title "Modify User"
    username=$(whiptail --inputbox "Enter the username to modify:" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
    get_username
done

sub_menu() {
ACTION=$(whiptail --title "Modify User $username" --menu "Choose an action to modify :" 15 70 7 \
        "UID" "Change user ID" \
        "Primary Group" "Change user primary group" \
        "Secondary Group" "Add user to secondary group" \
        "Home Directory" "change the home directory of a user" \
        "Login Shell" "Change user login shell" \
        "back" "Go to main menu" 3>&1 1>&2 2>&3)
input_cancel
case $ACTION in
        "UID") ch_uid ;;
        "Primary Group") ch_primary_grp ;;
        "Secondary Group") add_user_sec_grp ;;
        "Home Directory") ch_home_dir ;;
        "Login Shell") ch_shell ;;
        "back") ./main_menu.sh ;;
esac
}

ch_uid() {
	uid=$(whiptail --inputbox "Assign new UID to $username" 8 39 --title "Change UID" 3>&1 1>&2 2>&3)
	input_cancel
        #validate uid
        # Check if UID is a number and within a valid range (e.g., 1000 to 60000)
        if [[ "$uid" =~ ^[0-9]+$ ]] && [ "$uid" -ge 1000 ] && [ "$uid" -le 60000 ]; then
                #check if UID is unique
                id -u $uid &> /dev/null
                while [ $? -eq 0 ]; do
                     whiptail --msgbox "This UID '${uid}' already exist" 8 39 --title "UID validation"
                     uid=$(whiptail --inputbox "Assign new UID to $username" 8 39 --title "Change UID" 3>&1 1>&2 2>&3)
		     id -u $uid &> /dev/null
		     input_cancel
                done
                usermod -u $uid $username
                whiptail --title "UID" --msgbox "UID for $username Successfully updated to $uid." 8 70
                sub_menu
        else
            	whiptail --msgbox "UID must be number in valid range (1000 to 60000) " 8 78 --title "UID validation"
                input_cancel
        fi
}

get_primary_grp() {
        primary_grp=$(whiptail --inputbox "Assign new primary group to $username"  8 39 --title "Change Primary Group" 3>&1 1>&2 2>&3)
        input_cancel
	#check if username is empty or not
        while [ -z "$primary_grp" ]; do
        whiptail --msgbox "Group name cannot be empty. Please enter a valid name." 8 70 --title "Change Primary Group"
        primary_grp=$(whiptail --inputbox "Assign new primary group to $username" 8 39 --title "Change Primary Group" 3>&1 1>&2 2>&3)
        input_cancel
        done
}
ch_primary_grp() {
	get_primary_grp
	#check if group exist or not
        getent group $primary_grp &> /dev/null
        until [ $? -eq 0 ]; do
        whiptail --msgbox "This group '${primary_grp}' is not exist" 8 39 --title "Change Primary Group"
        get_primary_grp
        done
	usermod -g $primary_grp $username
        whiptail --title "Change Primary Group" --msgbox "Primary group of $username Successfully updated to $primary_grp." 8 78
        sub_menu
}

get_secondry_grp() {
        sec_grp=$(whiptail --inputbox "Enter the secondary group to which you will add user $username"  8 70 --title "secondary Group" 3>&1 1>&2 2>&3)
        input_cancel
	#check if sec_grp is empty or not
        while [ -z "$sec_grp" ]; do
	whiptail --msgbox "Secondary group cannot be empty. Please enter a valid name." 8 39 --title "Secondary Group"
	sec_grp=$(whiptail --inputbox "Enter the secondary group to which you will add user $username"  8 70 --title "secondary Group" 3>&1 1>&2 2>&3)
        input_cancel
	done
}

add_user_sec_grp() {
	get_secondry_grp
	#check if group exist or not
	getent group $sec_grp &> /dev/null
	until [ $? -eq 0 ]; do
		whiptail --msgbox "This group '${sec_grp}' is not exist" 8 39 --title "Secondary Group"
                get_secondry_grp
	done
	usermod -a -G $sec_grp $username
        whiptail --title "Secondary Group" --msgbox "$username has been successfully added to the secondary group '$sec_grp'." 8 78
        sub_menu
}

ch_home_dir(){
	home_dir=$(whiptail --inputbox "Enter the path to the new home directory."  8 39 --title "Home Directory" 3>&1 1>&2 2>&3)
        if [ -d "$home_dir" ]; then
        usermod -d $home_dir -m $username &> /dev/null
        whiptail --title "Home Directory" --msgbox "Directory '$home_dir' already exists." 8 78
        input_cancel
        else
	mkdir $home_dir
        usermod -d $home_dir -m $username &> /dev/null
        sub_menu
        fi
}

ch_shell(){
	shell=$(whiptail --title "Login Shell" --menu "Choose login shell:" 15 70 7 \
        "Bash" "(Bourne-Again SHell)" \
        "sh" "(Bourne Shell)" \
        "Nologin Shell" "" 3>&1 1>&2 2>&3)
        case $shell in
        "Bash") usermod -s /bin/bash $username ; sub_menu ;;
        "sh") usermod -s /bin/sh $username ; sub_menu ;;
        "Nologin Shell") usermod -s /sbin/nologin $username ; sub_menu ;;
        esac
}
sub_menu
