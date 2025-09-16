#!/bin/bash

# Extract OS information
os_info=$(cat /etc/os-release)

# Determine the matching option
if echo "$os_info" | grep -q 'Ubuntu 20.04'; then
    answer="Ubuntu 20.4"
elif echo "$os_info" | grep -q 'Ubuntu 18.04'; then
    answer="Ubuntu 18.04"
elif echo "$os_info" | grep -q 'CentOS Linux 8'; then
    answer="CentOS 8"
elif echo "$os_info" | grep -q 'CentOS Stream 9'; then
    answer="CentOS 9"
elif echo "$os_info" | grep -q 'Red Hat Enterprise Linux 6'; then
    answer="RHEL 6"
else
    echo "OS not recognized from the provided options."
    exit 1
fi

# Save the result
echo "$answer" > /home/bob/host-os
echo "Saved OS as '$answer' in /home/bob/host-os"
