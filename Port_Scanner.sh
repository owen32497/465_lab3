#Author     Nicholas Carrigan
#Realized we can only have 1 python script so gonna try to do this in bash
# file      Port_Scanner
#!bin/bash

ip=$1
port=$2

#check for cidr
if [[ip == */*]]; 
then
    prips $ip
fi

#check for ip range
if [[ip == *-*]];
then 
    
fi
#check for port range

#check for port list
