#Author     Nicholas Carrigan
#Realized we can only have 1 python script so gonna try to do this in bash
# file      Port_Scanner
#!bin/bash

ip=($1)
port=($2)

#check for cidr
if [[ip == */*]]; 
then
    prips $ip
fi

#check for ip range
if [[ $ip == *-* ]];
then
    firstsub="$(cut -d '.' -f1 <<< $ip)"
    secondsub="$(cut -d '.' -f2 <<< $ip)"
    third="$(cut -d '.' -f3,4 <<< $firstsub)"
    forth="$(cut -d '.' -f3,4 <<< $secondsub)"
    #echo $third //used to make sure it prints the right thing
    #echo $forth
fi
#check for port range

#check for port list
