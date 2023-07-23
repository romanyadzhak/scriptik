#!/bin/bash

read -p "Did you start script with sudo permition (y/n): " permition

if [ "$permition" = "y" ];then

	read -p "Enter auto site name: " autoname
	rm -rf /etc/apache2/sites-available/$autoname.conf
	rm -rf /etc/apache2/sites-enabled/$autoname.conf
	rm -rf /var/www/$autoname
	rm -rf /var/log/apache2/$autoname*.log
	echo "===Site $autoname hes been removed==="
	echo "-------------------------------------"
else
	echo "Start with sudo permition"
fi
