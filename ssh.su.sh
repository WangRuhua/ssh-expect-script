#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage:$0 ipfile username newpasswd"
	exit
fi

ipfile=$1
user=$2
newpasswd=$3
port=22
user="MSDOMAIN1\\rwang4"
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
	#passwd=`echo $tmp|awk  '{print $2}'`
	#echo {$ip}
	#echo {$passwd}

	./ssh.su.exp $ip 
done
