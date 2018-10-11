#!/bin/bash
#args: text file with each host on a new line
while read line
do
    ip=$(dig +short $line)
    if [ "$ip" != "" ]
    then 
        echo "$line:" 
        echo $ip
    fi
done < $1
