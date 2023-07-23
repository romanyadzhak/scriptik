#!/bin/bash

interface_name=$(ifconfig | grep ^e | awk -F: '{print $1}')
read -p "Enter local IP address: " local_address
read -p "Enter mask (from 1 to 32): " mask
read -p "Enter gateway address: " gateway_address
echo -e "#This is the network config written by 'subiquity'
network:
  renderer: networkd
  ethernets:
    $interface_name:
      dhcp4: false
      addresses:
        - $local_address/$mask
      routers:
        - to: default
          via: $gateway_address
      nameservers:
         addresses: [8.8.8.8,8.8.4.4]
  version: 2\n"> /etc/netplan/00-installer-config.yaml

netplan try

echo "Success..."

echo "Enter command <sudo netplan apply>"
