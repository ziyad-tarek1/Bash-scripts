Overview
This project provides a text-based user interface (TUI) for performing common user and group management tasks on Red Hat-based Linux systems. The script uses whiptail to create an intuitive, menu-driven interface, simplifying administrative tasks such as user creation, password management, and group modifications.

Features
The TUI offers the following options:

Add User: Easily add a new user to the system.
Modify User: Change user details including UID, primary group, secondary groups, home directory, and shell.
Delete User: Remove an existing user from the system.
List All Users: View a list of all system users.
Change Password: Update an existing user’s password.
Lock/Unlock User Account: Manage user access by locking or unlocking accounts.
Add/Delete Group: Create or remove groups on the system.
Modify Group: Change group details including GID and group membership.
List All Groups: Display a list of all system groups.


Prerequisites
whiptail: Required for the graphical TUI interface.
sudo: Necessary for executing administrative tasks.

Installation
Clone the repository:
git clone https://github.com/ziyad-tarek1/Administrative-GUI

Navigate to the project directory:
cd Administrative-GUI

chmod +x main_menu.sh

Usage
Run the Script:

bash
Copy code
./main_menu.sh
Navigate the Menu: Use the whiptail interface to select options and provide the required information.
