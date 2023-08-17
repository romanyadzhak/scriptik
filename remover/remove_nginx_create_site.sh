#!/bin/bash

read -p "Did you start script with sudo permition (y/n): " permition

if [ "$permition" = "y" ];then

	read -p "Enter auto site name: " autoname
	rm -rf /etc/nginx/sites-available/$autoname.conf
	rm -rf /etc/nginx/sites-enabled/$autoname.conf
	rm -rf /etc/nginx/nginx_self/ssl/$autoname
	service nginx restart
	echo "===Site $autoname has been removed==="
	echo "-------------------------------------"

else
	echo "Start with sudo permition"
fi
