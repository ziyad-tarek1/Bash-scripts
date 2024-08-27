#!/bin/bash

# Function to display a welcome message
welcome_message() {
    echo "==============================="
    echo "   Task Scheduler Script"
    echo "==============================="
    echo "This script allows you to schedule tasks using cron."
    echo "You can specify the task, date, and time interactively."
    echo
}

# Function to prompt the user for task details
prompt_for_task() {
    read -p "Enter the full path to the script or command you want to schedule: " scheduled_task

    echo "Please provide the scheduling details for the task."
    read -p "Enter the minute (0-59): " minute
    read -p "Enter the hour (0-23): " hour
    read -p "Enter the day of the month (1-31, * for every day): " day
    read -p "Enter the month (1-12, * for every month): " month
    read -p "Enter the day of the week (0-6 where 0 is Sunday, * for every day): " weekday

    # Validate inputs (optional)
    if [[ -z "$scheduled_task" || -z "$minute" || -z "$hour" || -z "$day" || -z "$month" || -z "$weekday" ]]; then
        echo "Error: One or more required inputs are missing. Exiting..."
        exit 1
    fi
}

# Function to add the task to crontab
add_task_to_crontab() {
    schedule_time="$minute $hour $day $month $weekday"
    echo "$schedule_time $scheduled_task" | crontab -
    echo "Task scheduled successfully at $hour:$minute on $day/$month."
    echo "Cron schedule: $schedule_time $scheduled_task"
    echo
}

# Function to allow scheduling multiple tasks
schedule_multiple_tasks() {
    while true; do
        prompt_for_task
        add_task_to_crontab
        read -p "Do you want to schedule another task? (yes/no): " choice
        if [[ "$choice" != "yes" ]]; then
            break
        fi
    done
    echo "All tasks have been scheduled. Exiting..."
}

# Main script execution
welcome_message
schedule_multiple_tasks
