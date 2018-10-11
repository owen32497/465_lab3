#Author     Nicholas Carrigan
#Realized we can only have 1 python script so gonna try to do this in bash
# file      Port_Scanner
#!bin/bash
ip=$1
port=$2

# Take user input for ip, ip range, port or port range
echo "What would you like to scan?"
read scan

# Scan the IP's
network=scan
for host in {1..254}; do
    ping -c1 $network$host &>/dev/null;
    [ $? -eq 0 ] && echo "$network$host is up"
done

# Scan the ports
network=scan
for port in {1..150}; do 
    (echo > /dev/tcp/$host/$port) &>/dev/null;
    [ $? -eq 0 ] && echo "$port open"
done
