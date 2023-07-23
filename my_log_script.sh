#!/bin/bash

#variables list

log="fileinfo.log"
add_to_log="/home/roman/$log"
date_now=$(date +%d/%m/%Y)
time_now=$(date +%H:%M)
interface_name=$(ifconfig | grep ^e | awk -F: '{print $1}')
ip_address=$(ifconfig $interface_name | grep "inet " | awk '{print $2 " " $4}')
UID1=$(grep -E 1[0-9]{3} /etc/passwd | awk -F: '{print $3 ":" $1}')
cut_line=$(perl -E 'say "=" x 70')
echo "Please wait..."
#create log file
if [[ -r $log ]];then
	echo "		$date_now  $time_now">> $add_to_log
else
	touch $log
	echo "		$date_now  $time_now">> $add_to_log
fi

#show HOST_NAME
echo -e "\nHost name: $(hostname) \n$cut_line \n">> $add_to_log

#information about system
echo -e "$(lscpu) \n$cut_line \n">> $add_to_log

#show all active users
echo "User's id and names list">> $add_to_log
echo "$UID1">> $add_to_log
echo -e "\n$cut_line \n">> $add_to_log

#print interface name and IP addr with mask
echo -e "Interface name: $interface_name \n\nIP address is:  $ip_address \n$cut_line\n">> $add_to_log

#show gateway table
echo -e "$(netstat -nr) \n$cut_line \n">> $add_to_log

#check internet connect by PING 8.8.8.8
echo -e "Check internet connect \n">> $add_to_log
echo -e "$(ping -c 4 8.8.8.8) \n$cut_line \n">> $add_to_log

#check DNS connect by PING google.com
echo -e "Check DNS \n">> $add_to_log
echo -e "$(ping -c 4 google.com) \nEND \n$cut_line">> $add_to_log
echo -e "$(perl -E 'say "*" x 70') \n \n">> $add_to_log
echo -e "Success. \nGo to <fileinfo.log> in your directory"

