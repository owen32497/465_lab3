#!/usr/bin/python3
#This script was written by Nicholas Graca
#it takes a .csv file that has a list of host names as a cmd line argument
#It will then check to see if that host name has an ip address
import socket

#this section will get the file name from argv and then read the file
#It puts the hostnames in the file in a list.
f = str(sys.argv[1]);
hosts_file = open(f, 'r');
hosts= []; 
for line in hosts_file:
    line = line.replace(" ", "").strip().split(",");
    hosts = hosts + line;

#It is good practice to close the file when you are done reading from it.
hosts_file.close();

#This section loops through all the host names in the list and checks for their IP
for host in hosts:
    try:
        addr = socket.gethostbyname(host);
        print(host  + ": " + addr);
    except:
        print("There is no IP address for the host: " + host);
