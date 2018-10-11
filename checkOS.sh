#!/bin/bash

#result=$(ping 8.8.8.8 -c 1 | tail -5 | head -1| cut -d ' ' -f6)

#if[$result -eq 'ttl=124']
#then 
    #echo 


file=$1
if [ -z $file ]
then
    echo "Usage: ./getOS.sh [file containing IP addresses]"
    exit 1
fi

while read addr
do

    result=$(ping "$addr" -c 1 | tail -5 | head -1| cut -d ' ' -f6)
    #echo $result
    if [ "$result" == "ttl=128" ] 
    then
        echo -e "$addr\t=> Windows"

    else
        echo -e "$addr\t=> Linux"
    fi

done < $file