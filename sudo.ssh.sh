#!/bin/bash

if [ $# -ne 2 ]
then
	echo "usage:$0 ipfile commands "
	exit
fi

ipfile=$1
commands=$2
port=22
user="MSDOMAIN1\\rwang4"
user="user_0"
user="MSDOMAIN1\\rwang4"
#echo "[system] input the passwd"
#echo   -e   "passwd:\c " 
#oldtty=`stty   -g` 
#stty   -echo 
#read   passwd 
#stty   $oldtty 
#echo   -e   "\nyour   passwd:$passwd " 

#read ip
myIFS=":"
cat $ipfile |grep -v ^$|grep -v ^\#|while read tmp
do
	ip=`echo $tmp|awk  '{print $1}'`
	#tar_dir=`echo $tmp|awk  '{print $5}'`
	#passwd=`echo $tmp|awk  '{print $2}'`
	#echo {$ip}
	#echo {$passwd}

	./sudo.ssh.exp $ip "$commands"
	#echo ./sudo.ssh.exp $ip "sudo mkdir $tar_dir;sudo chown -R  monitor.linux-server-admins  $tar_dir;"
	#./sudo.ssh.exp $ip "mkdir $tar_dir/conf;sudo chown -R  msdomain1\\\\rwang4 $tar_dir;ls $tar_dir"
#	./sudo.ssh.exp $ip "mkdir $tar_dir/conf;ls $tar_dir"
#	echo ./sudo.ssh.exp $ip "$commands"
    trap 'echo "exit now...";exit'  2
    sleep 3;
done



#./ssh.exp ip user  passwd port commands
