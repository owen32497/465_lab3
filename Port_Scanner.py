!/usr/bin/python
# Nicholas Carrigan
# Port_Scanner.py

import struct
import socket
import os
import sys
from netaddr import *
import pprint
 
def tcpScan(ipaddress, ports):
    try:
        for ip in ipaddress:
            print "Scanning ", ip, ":"
            for port in ports:
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                result = sock.connect_ex((ip, int(port)))
                if result == 0:
                    print "Port ", port, " - open"
                else:
                    print "Port ", port, " - closed"
            sock.close()
 
    except KeyboardInterrupt:
        print "Exiting"
    sys.exit()
 
 
 
def getRange(start, end):
    ipstruct = struct.Struct('>I')
    start, = ipstruct.unpack(socket.inet_aton(start))
    end, = ipstruct.unpack(socket.inet_aton(end))
    return [socket.inet_ntoa(ipstruct.pack(i)) for i in range(start, end+1)]
 
 
def main():
    # get ip
    targets = raw_input("Enter the ip address (Single host, Range or CIDR): ")
    counter = 0      # counter
    range1 = None      # First ip add
    range2 = None      # 2nd ip addr or CIDR
    inputType = 0      # 0 = 1 host, 1 = range, 2 = cidr
 
    for a in targets:
        if a == '-':
            range1 = targets[:counter]    #ip start
            range2 = targets[counter+1:]    #ip end
            inputType = 1
            break 
        if a == '/':
            inputType = 2
            range1 = targets
            break
        counter= counter + 1
        range1 = targets 
    
    # Obtaining all ips now:
    ipList = []
    if inputType == 0:
        ipList.append(range1)
 
    if inputType == 1:
        ipList = getRange (range1, range2)
    
    if inputType == 2:
        for ip in IPNetwork(range1):
           ipList.append(str(ip))
    try:
       ports = raw_input("Enter port range (IE: 20-80): ").split('-')
    except:
       ports = raw_input("Enter ports (IE: 20,21,22): ").split(',')
    tcpScan(ipList, ports)
 
main()
