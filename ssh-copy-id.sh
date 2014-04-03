#!/bin/bash
[ -f "$1" ] || exit 3
while read IP
do
        echo 
        ./ssh-copy-id.exp  $IP
done<$1

