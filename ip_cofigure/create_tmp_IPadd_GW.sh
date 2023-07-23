#!/bin/bash


read -p "Did you start script with sudo permition (y/n): " permition

if [ "$permition" = "y" ];then
	interface_name=$(ifconfig | grep ^e | awk -F: '{print $1}')
	read -p "Enter tempolary IPv4: " ip_addr
	read -p "Enter tempolary mask: " mask
	read -p "Enter tempolary default address: " default_addr
	ifconfig $interface_name $ip_addr netmask $mask up
 	route add default gw $default_addr
	echo "$(ifconfig)"
	echo "$(netstat -nr)"
	echo "Seccess..."

else
	echo "Start with sudo permition"
fi
