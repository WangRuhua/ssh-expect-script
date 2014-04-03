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
#user="user_0"
echo "[system] input the passwd"
stty -echo
read passwd
stty echo

#read ip
myIFS=":"
cat $ipfile |grep -v ^$|grep -v ^\#|while read tmp
do
	ip=`echo $tmp|awk  '{print $1}'`
	#passwd=`echo $tmp|awk  '{print $2}'`
	#echo {$ip}
	#echo {$passwd}

	./ssh.exp $ip $user  $passwd $port "$commands"
done



#./ssh.exp ip user  passwd port commands
