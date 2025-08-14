#!/bin/bash

# Define VPN config file paths
VPN1="<full path to ovpn file>"
VPN2="<full path to ovpn file>"
VPN3="<full path to ovpn file>"

# Prompt the user
echo "Choose a VPN option:"
echo "1) Offsec"
echo "2) TryHackMe"
echo "3) HackTheBox"
read -p "Enter your choice (1/2/3): " choice

# Check for empty input
if [[ -z "$choice" ]]; then
    echo "No input received. Exiting."
    exit 1
fi

# Function to connect to VPN if file exists
connect_vpn() {
    local config_file="$1"
    local label="$2"
    
    if [[ ! -f "$config_file" ]]; then
        echo "Error: VPN config file '$config_file' not found."
        echo "Please make sure the VPN file exists and is correctly named."
        exit 1
    fi

    echo "Connecting to $label..."
    sleep 1
    sudo openvpn "$config_file"
}

# Decide based on input
case "$choice" in
    1)
        connect_vpn "$VPN1" "Offsec VPN "
        ;;
    2)
        connect_vpn "$VPN2" "TryHackMe VPN "
        ;;
    3)
        connect_vpn "$VPN3" "VPN 3 "
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
