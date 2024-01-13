# Start SSH SOCKS5

This repository contains a bash script `start-ssh-socks5.sh` that sets up a SOCKS5 proxy using SSH.

## Script Overview

The `start-ssh-socks5.sh` script performs the following operations:

1. It prompts the user to enter the port number, username, hostname, and sleep duration. These values are used to establish the SSH connection and control the reconnection behavior.

2. If the `.ssh_settings` file exists (which stores the previously entered values), the script will read the values from this file and ask the user if they want to use these saved values. If the user chooses not to use the saved values, they will be prompted to enter new ones.

3. The entered values are stored in an array and also saved to the `.ssh_settings` file for future use.

4. The script then starts the SSH command in the background, establishing a SOCKS5 proxy. If the SSH connection drops, the script will wait for the specified sleep duration and then attempt to re-establish the connection.

## Usage

To run the script, navigate to the directory containing `start-ssh-socks5.sh` and execute the following command:

```sh
bash start-ssh-socks5.sh
```
