#!/usr/bin/python3
#This script was written by Nicholas Graca
import socket, sys

f = str(sys.argv[1]);
hosts_file = open(f, 'r');
hosts= []; 
for line in hosts_file:
    line = line.replace(" ", "").strip().split(",");
    hosts = hosts + line;

hosts_file.close();

for host in hosts:
    try:
        addr = socket.gethostbyname(host);
        print(host  + ": " + addr);
    except:
        print("There is no IP address for the host: " + host);
