#!/usr/bin/python
#Nicholas Carrigan
import socket
import subprocess
import sys
from datetime import datetime

# Ask for input
host    = raw_input("Enter a remote host to scan: ")
ip  = socket.gethostbyname(host)

print "Please wait, scanning remote host. This will take around a couple of minutes. Starting Scan of =", ip


# Check what time the scan started
t1 = datetime.now()

# Using the range function to specify ports between 1 and 1024
#Using the following socket functions in python we are able to find the TCP and UDP options below.
#SOCK_STREAM
#Socket type TCP connections
#SOCK_DGRAM
#Socket type UDP connections
try:
    for port in range(1,1025):  
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex((ip, port))
        if result == 0:
            print "Port {}: 	 Open".format(port)
        sock.close()

#random functions stolen online for error debugging
except socket.gaierror:
    print 'Hostname could not be resolved. Exiting'
    sys.exit()

except socket.error:
    print "Couldn't connect to server"
    sys.exit()

except KeyboardInterrupt:
    print "You pressed Ctrl+C"
    sys.exit()

# Recheck time
t2 = datetime.now()

# Calculates the difference of time for duration of scan
total =  t2 - t1

# Printing the information to screen
print 'Scanning Completed. Took: ', total
