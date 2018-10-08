#!/bin/sh
# author        noah michaels
# assignment    lab 3 csec465
# date          10/8/2018
# file          getOS.sh

file=$1
winport=445
nixport=22

while read addr; do
    #check for linux
    nix="$(nc -nzv $addr $nixport 2>&1)"
    if [[ "$nix" == *"(ssh) open"* ]] 
    then
        echo -e "$addr\t=> Linux"
    else
        win="$(nc =nzv $addr $winport 2>&1)"
        if [[ "$win" == *"(smb) open"* ]]
        then
            echo -e "$addr\t=> Windows"
        fi
    fi

done < $file
