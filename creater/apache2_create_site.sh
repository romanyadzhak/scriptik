#!/bin/bash

read -p "Enter auto site name: " autoname
touch /etc/apache2/sites-available/$autoname.conf
echo -e  "<VirtualHost *:85>
	\n	ServerName $autoname
	\n              #Using Word Press
        \n      #DirectoryIndex index.php
        \n              #Using Joomla
        \n      #DirectoryIndex index.html index.php
	\n	ServerAdmin webmaster@$autoname
	\n	DocumentRoot /var/www/$autoname
	\n	ErrorLog /var/log/apache2/$autoname-error.log
	\n	CustomLog /var/log/apache2/$autoname-access.log combined
	\n              # using for Drupal Site
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

              #using for opencart

       # <Directory /var/www/$autoname/opencart-master/upload>
       #         allowoverride all
       #         allow from all
       #    </Directory>
        \n
	\n</VirtualHost>">> /etc/apache2/sites-available/$autoname.conf
mkdir /var/www/$autoname
touch /var/www/$autoname/index.html
echo "====Hello auto $autoname====">> /var/www/$autoname/index.html
a2ensite $autoname.conf
service apache2 reload
echo "Configure /etc/hosts for IOS"
echo "!!!!!SUCCESS!!!!!"
