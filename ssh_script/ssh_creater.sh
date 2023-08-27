#!/bin/bash

	# Creating pair ssh keys
read -s -p "Enter passphrase for ssh_key: " passphrase
echo -e " \n
---------------------------------------------------"
mkdir -p ~/my_ssh
cd ~/my_ssh

ssh-keygen -t rsa -b 4096 -f my_key -N "$passphrase"

	# Creating variables list
touch ~/my_ssh/tmp.txt
echo -n "How many servers are you going to creat? = "
read quantity

if ! [[ "$quantity" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a valid number."
    exit 1
fi

interface_name=$(ifconfig | grep ^e | awk -F: '{print $1}')
ip_address=$(ifconfig $interface_name | grep "inet " | awk '{print $2}')

echo "===== Enter parameters for your servers ====="
echo "*********************************************"
for ((i = 1; i <= $quantity; i++)); do

	echo "========== Enter parameters for server $i =========="
	read -p "Enter servername for ssh connection: " servername
	read -p "Enter server username: " username
	read -p "Enter server ip_address: " remote_server_ip
	read -p "Enter user password: " your_password
	echo -e " \n====================================================="

	echo "$i:$servername:$username:$remote_server_ip:22:$your_password" >> ~/my_ssh/tmp.txt
	touch ~/my_ssh/config$i
	echo -e "\n
#------------------------------------------------------------
		#  Multiplication key
#------------------------------------------------------------

Host $servername
	User $username
	IdentityFile ~/.ssh/my_key
\n
Host *
	StrictHostKeyChecking no         # Don't ask configuration for fingerprint
	UserKnownHostsFile /dev/null     # Don't save into known_hosts

#--------------------------------------------------------------
# My SSH configuration to connect to servers
#--------------------------------------------------------------
\n" >> ~/my_ssh/config$i

		# SSH copy public key, privat keys and adding to authorized_key

	if [ "$remote_server_ip" == "$ip_address" ]; then
		cp ~/my_ssh/my_key* ~/.ssh
		cat ~/ssh/my_key.pub >> ~/.ssh/authorized_keys && rm -f ~/.ssh/my_key.pub
		echo "Warning: Permanently added '$ip_address'"
		echo "Warning: Permanently added '$ip_address'"
	else

		sshpass -p '$your_password' scp ~/my_ssh/my_key* $username@$remote_server_ip:~/.ssh
		sshpass -p '$your_password' ssh "$username@$remote_server_ip" "cat ~/ssh/my_key.pub >> ~/.ssh/authorized_keys && rm -f ~/.ssh/my_key.pub"
	fi
done

		# Creating config for ssh

for ((i = 1; i <= $quantity; i++)); do

server_ip1=$(awk -F: -v ip1="$i" 'NR== ip1 {print $4}' ~/my_ssh/tmp.txt)
password=$(awk -F: -v ip1="$i" 'NR== ip1 {print $6}' ~/my_ssh/tmp.txt)
user=$(awk -F: -v ip1="$i" 'NR== ip1 {print $3}' ~/my_ssh/tmp.txt)

	for ((j = 1; j <= $quantity; j++)); do

		server_ip2=$(awk -F: -v ip2="$j" 'NR== ip2 {print $4}' ~/my_ssh/tmp.txt)

                if [ "$server_ip1" == "$server_ip2" ]; then
			echo "                            "
                        echo "***** config$i created *****"
                else

                        field=$(awk -F: -v line="$j" 'NR == line {print "Host", $2, "\n", "    HostName", $4, "\n", "    User", $3, "\n", "    Port", $5}' ~/my_ssh/tmp.txt)
                        echo "$field">> ~/my_ssh/config$i
                fi
        done
echo "==================================" >> ~/my_ssh/config$i


        if [ "$server_ip1" == "$ip_address" ]; then
		cp ~/my_ssh/config$i ~/.ssh/config
		echo "Warning: Permanently added '$ip_address'"
	else
		sshpass -p '$password' scp ~/my_ssh/config$i $user@$server_ip1:~/.ssh/config
	fi
done

		# Removing tempolary directory
echo "                                     "
echo "Wait... removing tempolary directory "
rm -rf ~/my_ssh
echo "To entry into remote server use command 'ssh <server name>'"
