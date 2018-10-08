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
    nix="$(nc -nzv $addr $nixport)"
    test="$(echo "what the fuck")"
    echo "nix? ${nix}"
    if [[ "${nix}" == *"(ssh) open"* ]] 
    then
        echo "$addr"
        break
    fi
    echo "sdfasdfasdf"

done < $file
