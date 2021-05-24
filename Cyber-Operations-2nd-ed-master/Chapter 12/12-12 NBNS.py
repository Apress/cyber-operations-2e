#!/bin/python

# Script to send packets on UDP/137 to the broadcast address 10.2.255.255 see if other systems on the network respond.
# Filter assumes that the sending system has the address 10.0.2.95; this and the broadcast address should be modified.


import random
from scapy.all import IP,UDP,NBNSQueryRequest,send,sniff
import threading
import time

def read():
  print "Reading"
  sniff(iface="enp0s3",
      prn = lambda x: "Source IP:{} Source UDP:{} --> Dest IP {} 
        Dest UDP:{}".format(x[IP].src,x[UDP].sport,x[IP].dst,x[UDP].dport),
      filter = "udp and port 137 and (not src 10.0.2.95)") 

def write():
  print "Writing"
  ip = IP(dst="10.0.255.255")
  udp = UDP(sport=137,dport=137)
  nbns = NBNSQueryRequest(QUESTION_TYPE="NB", QUESTION_NAME="WPAD",   
                          SUFFIX="file server service")
  packet = ip/udp/nbns

  while(1):
    send(packet)
    time.sleep(5)

def main():
  readthread = threading.Thread(target=read, args=())
  readthread.start()
  write()

main()

