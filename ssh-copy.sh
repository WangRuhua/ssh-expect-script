#!/usr/bin/expect
####!/bin/sh
set ip [lindex $argv 0]
set user msdomain1\\rwang4
set passwd Rome0322 

set timeout 30
#spawn ssh -q ${user}@${ip}
spawn /usr/bin/ssh-copy-id -i /home/MSDOMAIN1/rwang4/.ssh/id_rsa_15.232.pub msdomain1\\rwang4@$ip
expect "assword:"
send "$passwd\r"
expect "expecting."
exit
