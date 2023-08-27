#!/bin/bash

read -p "Enter yuor site name: " autoname

cat $autoname\_CA.pem >> $autoname.crt

sudo mv $autoname.crt /etc/nginx/nginx_self/ssl/$autoname
sudo mv $autoname.key /etc/nginx/nginx_self/ssl/$autoname

echo "Bundle was created and copied"
echo "!!!!!SUCCESS!!!!!"

