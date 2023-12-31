#!/bin/bash

read -p "Did you start script with sudo permition (y/n): " permition

if [ "$permition" = "y" ];then
	read -p "Enter nginx site name: " autoname
	touch /etc/nginx/sites-available/$autoname.conf
	mkdir /etc/nginx/nginx_self/ssl/$autoname
	echo -e "\n
server {
        listen 80;
        listen [::]:80;



        server_name $autoname;

		# ===Redirect on https===
#        return 301 https://\$server_name$request_uri;

                #===if nginx site not answer -- it loaded default page===
         location /default/ {
                index index.nginx-debian.html;
                root /var/www/html;
        }

                #===location for site
         location / {
                 proxy_pass http://back-apache;
                 proxy_set_header Host \$http_host;
                 proxy_set_header X-Real-IP \$remote_addr;
                 proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                 proxy_set_header X-Forwarded-Proto \$scheme;

        }


}

server {
        listen   443 ssl;

         server_name $autoname;

         gzip on;
         gzip_disable "msie6";
         gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;


#         ssl_certificate      /etc/nginx/nginx_self/ssl/$autoname/$autoname.crt;
#         ssl_certificate_key  /etc/nginx/nginx_self/ssl/$autoname/$autoname.key;

         ssl_session_cache    shared:SSL:1m;
         ssl_session_timeout  5m;

         ssl_ciphers  HIGH:!aNULL:!MD5;
         ssl_prefer_server_ciphers  on;

		#===if nginx site not answer -- it loaded default page===
	 location /default/ {
                index index.nginx-debian.html;
                root /var/www/html;
        }

		#===location for site
         location / {
                 proxy_pass http://back-apache;
                 proxy_set_header Host \$http_host;
                 proxy_set_header X-Real-IP \$remote_addr;
                 proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                 proxy_set_header X-Forwarded-Proto \$scheme;

        }

		# ===Static for nginx===
	location ~* ^.+\.(txt|jpg|jpeg|gif|mpg|mpeg|avi|png|swf|ico|zip|rar|sdt|js|bmp|wav|mp3|mmf|mid|vkp|sisx|sis|exe|jar|thm|nth|doc)$ {
                     root /var/www/$autoname/;
                     expires 1d;
         }

		# ===additional securitu===
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
