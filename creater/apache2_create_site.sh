#!/bin/bash

read -p "Enter auto site name: " autoname
touch /etc/apache2/sites-available/$autoname.conf
echo -e  "<VirtualHost *:85>
	\n	ServerName $autoname
	\n	#DirectoryIndex index.php
	\n	ServerAdmin webmaster@$autoname
	\n	DocumentRoot /var/www/$autoname
	\n	ErrorLog /var/log/apache2/$autoname-error.log
	\n	CustomLog /var/log/apache2/$autoname-access.log combined
	\n</VirtualHost>">> /etc/apache2/sites-available/$autoname.conf
mkdir /var/www/$autoname
touch /var/www/$autoname/index.html
echo "====Hello auto $autoname====">> /var/www/$autoname/index.html
a2ensite $autoname.conf
service apache2 reload
echo "Configure /etc/hosts for IOS"
echo "!!!!!SUCCESS!!!!!"
