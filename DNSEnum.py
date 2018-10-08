#This script was written by Nicholas Graca
import socket

f = input("Please enter the full name of the file with the host names. Make sure it is in CSV format: ");
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
