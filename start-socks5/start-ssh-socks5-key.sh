#!/bin/bash

# Function to get user input for port, user, host, private key path
get_user_input() {
    read -p "Enter the port number: " port
    read -p "Enter the user name: " user
    read -p "Enter the host name: " host
    read -p "Enter the path to the private key file: " private_key_path
}

# Check if the variables have already been set
if [ -f ".ssh_settings" ]; then
    # Read the values from the file
    ssh_settings=($(cat .ssh_settings | grep -E "port=|user=|host=|key=" | cut -d '=' -f 2))
    port=${ssh_settings[0]}
    user=${ssh_settings[1]}
    host=${ssh_settings[2]}
    private_key_path=${ssh_settings[3]}

    # Display saved values
    echo "Saved values:"
    echo "Port: $port"
    echo "User: $user"
    echo "Host: $host"
    echo "Private key path: $private_key_path"

    # Ask user if they want to use saved values or enter new ones
    read -p "Do you want to use these saved values? (y/n): " use_saved
    if [ "$use_saved" == "n" ]; then
        get_user_input
    fi
else
    get_user_input
fi

# Store the values in an array and a file
ssh_settings=("$port" "$user" "$host" "$private_key_path")
echo "port=${ssh_settings[0]}" > .ssh_settings
echo "user=${ssh_settings[1]}" >> .ssh_settings
echo "host=${ssh_settings[2]}" >> .ssh_settings
echo "key=${ssh_settings[3]}" >> .ssh_settings

# Start the SSH command in the background
ssh -D ${ssh_settings[0]} -q -C -N -i ${ssh_settings[3]} ${ssh_settings[1]}@${ssh_settings[2]}
