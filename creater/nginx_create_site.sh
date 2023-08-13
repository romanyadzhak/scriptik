#!/bin/bash

read -p "Did you start script with sudo permition (y/n): " permition

if [ "$permition" = "y" ];then
	read -p "Enter nginx site name: " autoname
	touch /etc/apache2/sites-available/$autoname.conf

	echo -e "\n
server {
        listen 80;
        listen [::]:80;



        server_name $autoname;

        location /default/ {
                index index.nginx-debian.html;
                root /var/www/html;
        }

         location / {
                 proxy_pass http://127.0.0.1:85;
                 proxy_set_header Host \$http_host;
                 proxy_set_header X-Real-IP \$remote_addr;
                 proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                 proxy_set_header X-Forwarded-Proto \$scheme;

        }

	location ~* ^.+\.(txt|jpg|jpeg|gif|mpg|mpeg|avi|png|swf|ico|zip|rar|sdt|js|bmp|wav|mp3|mmf|mid|vkp|sisx|sis|exe|jar|thm|nth|doc)$ {
                     root /var/www/word.local/;
                     expires 1d;
         }

         location ~ /\.ht {
                deny all;
        }

}"> /etc/nginx/sites-available/$autoname.conf

	sudo ln -s /etc/nginx/sites-available/$autoname.conf /etc/nginx/sites-enabled/$autoname.conf
	sudo service nginx restart
	echo "!!!!!SUCCESS!!!!!"
else
	echo "Start with sudo permition"
fi
