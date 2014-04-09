#!/bin/bash

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-hv] [-f IPs.txt ] [-u user ] [-p port] [-s source_files ] [ -d target_dir ]...
    
    -f          read target names from IPs.txt
    -u          username specifies the user to log in as on the remote machine 
    -p          ssh port,default is 22/tcp
    -s          source files,or directory
    -d          target dir
    -h          display this help and exit
    -v          verbose mode. Can be used multiple times for increased
EOF
}                

#if [ $# -le 3 ]
#then
#	show_help
#	exit
#fi
# Initialize our own variables:
output_file=""
verbose=0
port=22
user=$(whoami)

OPTIND=1 # Reset is necessary if getopts was used previously in the script.  
while getopts "h:v:f:u:p:s:d:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        v)  verbose=1
            ;;
        f)  IPfile=$OPTARG
            [ -s $IPfile ] || { echo "no IP in $IPfile";exit 2; }
            ;;
        u)  user=$OPTARG
            ;;
        p)  port=$OPTARG
            ;;
        s) source_files=$OPTARG
            ;;
        d) target_dir=$OPTARG
            ;;
        '?')
                    show_help >&2
                    exit 1
                    ;;
    esac
    #echo "again:$OPTARG ===="
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

#printf 'verbose=<%s>\nuser=<%s>\nIPfile=<%s>\nport=<%s>\ncommands=<%s>\nLeftovers:\n' "$verbose" "$user" "$IPfile" "$port" "$commands"
#printf '<%s>\n' "$@"

if ls  $source_files;then 
    echo  ls "$source_files"
else
    echo "no commands is found,check the arguments please";
    show_help;
    exit 3;
fi


echo "enter passord of $user"
stty   -echo 
read   passwd 
stty   echo 

echo "IPfile=$IPfile"
echo "remote machines list:"
head -10 $IPfile
#echo "script will execute commands:$commands on `head -2 $IPfile|xargs ` by user:$user passwd:$passwd"

#read ip
myIFS=":"
i=0;
cat $IPfile |grep -v ^$|grep -v ^\#|while read tmp

do
	ip=`echo $tmp|awk  '{print $1}'`

	echo ./rsync.exp $user $ip $port $passwd $source_files $target_dir
	./rsync.exp $user $ip $port $passwd $source_files $target_dir
    trap 'echo "exit now...";exit'  2
    sleep 3;
    i=`expr $i + 1 `
done
