#!/bin/bash

# Get the IP address of eth0
ip_address=$(ip -o -4 addr show eth0 | awk '{print $4}' | cut -d/ -f1)

# Check if IP was found
if [ -z "$ip_address" ]; then
    echo "No IP address found for eth0."
    exit 1
fi

# Save to file
echo "$ip_address" > /home/bob/physical_ipaddress
echo "Saved IP address '$ip_address' to /home/bob/physical_ipaddress"
