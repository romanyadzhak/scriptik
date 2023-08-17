#!/bin/bash

read -p "Enter auto site name: " autoname
touch /etc/apache2/sites-available/$autoname.conf
echo -e  "<VirtualHost *:85>
	\n	#ServerName $autoname
	\n              #Using Word Press
        \n      #DirectoryIndex index.php
        \n              #Using Joomla
        \n      #DirectoryIndex index.html index.php
		#ServerAdmin webmaster@$autoname
		#DocumentRoot /var/www/$autoname
		#ErrorLog /var/log/apache2/$autoname-error.log
		#CustomLog /var/log/apache2/$autoname-access.log combined
	\n              # Using for Drupal Site
        \n      #<Directory /var/www/$autoname>
                #   Options Indexes FollowSymLinks
                #   AllowOverride All
                #   Require all granted
                #   RewriteEngine on
                #   RewriteBase /
                #   RewriteCond %{REQUEST_FILENAME} !-f
                #   RewriteCond %{REQUEST_FILENAME} !-d
                #   RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
                #</Directory>

	              #Using for Opencart

		ServerName $autoname
	        ServerAlias www.$autoname
                ServerAdmin webmaster@$autoname
	        DirectoryIndex index.php
                DocumentRoot /var/www/$autoname/upload

                ErrorLog \${APACHE_LOG_DIR}/$autoname-error.log
                CustomLog \${APACHE_LOG_DIR}/$autoname-access.log combined

	\n</VirtualHost>">> /etc/apache2/sites-available/$autoname.conf
mkdir /var/www/$autoname
touch /var/www/$autoname/index.html
echo "====Hello auto $autoname====">> /var/www/$autoname/index.html
a2ensite $autoname.conf
service apache2 reload
echo "Configure /etc/hosts for IOS"
echo "!!!!!SUCCESS!!!!!"
