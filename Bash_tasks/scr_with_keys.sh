#!/bin/bash


function all_hosts {
echo -e "\tscanning network"
n_hosts=`nmap -sn 192.168.0.101/24`
ip_addr=`echo $n_hosts | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
for i in $ip_addr
do
echo $i
done
}

function target {
echo -e "\topen tcp ports"
#ss -t | awk '{print$5}' | awk -F ':' '{print $1}'
 ss -t | awk '{print $5}' | awk -F ':?:' '{print $2}'
}

while [ -n "$1" ]
do
    case "$1" in
        --all)
                all_hosts;;
        --target)
                target;;
        *) echo "Incorrect option $1"
        echo "exit"
        exit 1
#       break;;
    esac
shift
done
