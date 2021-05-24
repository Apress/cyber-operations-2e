#!/usr/bin/python

# Python script to use ScaPY to send UDP/514 syslog data to a remote server,
#  spoofing the source address.

from scapy.all import IP,UDP,Raw,send
import time

priority = 3  # error
facility = 1  # user
code = '<' + str(8 * facility + priority) +'>'
timestamp = time.strftime("%b %d %H:%M:%S")
message = "Host named [31337] I just experienced a critical error"

packet = IP(dst="10.0.2.32", src="10.0.2.26")
packet = packet/UDP(dport=514, sport=31337)
packet = packet/Raw(code + timestamp + " " + message)

send(packet,verbose=0)
