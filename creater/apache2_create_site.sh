#!/bin/bash

read -p "Enter auto site name: " autoname
touch /etc/apache2/sites-available/$autoname.conf
echo -e  "<VirtualHost *:85>
	\n	ServerName $autoname
	\n              #Using Word Press
        \n      #DirectoryIndex index.php

		        #Using Joomla
		#DirectoryIndex index.html index.php

			#Using for Opencart
                #DirectoryIndex index.php

                ServerAlias www.$autoname
                ServerAdmin webmaster@$autoname
                DocumentRoot /var/www/$autoname/ #upload

                ErrorLog \${APACHE_LOG_DIR}/$autoname-error.log
                CustomLog \${APACHE_LOG_DIR}/$autoname-access.log combined

		        # Using for Drupal Site

		#<Directory /var/www/$autoname>
                #   Options Indexes FollowSymLinks
                #   AllowOverride All
                #   Require all granted
                #   RewriteEngine on
                #   RewriteBase /
                #   RewriteCond %{REQUEST_FILENAME} !-f
                #   RewriteCond %{REQUEST_FILENAME} !-d
                #   RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
                #</Directory>

	\n</VirtualHost>">> /etc/apache2/sites-available/$autoname.conf
mkdir /var/www/$autoname
touch /var/www/$autoname/index.html
echo "====Hello auto $autoname====">> /var/www/$autoname/index.html
a2ensite $autoname.conf
service apache2 reload
echo "Configure /etc/hosts for IOS"
echo "!!!!!SUCCESS!!!!!"
