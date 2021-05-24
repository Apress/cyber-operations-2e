#!/bin/python

# Script to send packets on UDP/5355 to the multicast address 224.0.0.252 see if other systems on the network respond.
# Filter assumes that the sending system has the address 10.0.2.95; this should be modified.


import random
from scapy.all import IP,UDP,LLMNRQuery,DNSQR,send,sniff
import threading
import time

def read():
  print "Reading"
  sniff(iface="enp0s3",
      prn = lambda x: "Source IP:{} Source UDP:{} --> Dest IP {} 
       Dest UDP:{}".format(x[IP].src,x[UDP].sport,x[IP].dst,x[UDP].dport),
      filter = "udp and port 5355 and (not src 10.0.2.95)") 

def write():
  print "Writing"
  ip = IP(dst="224.0.0.252")
  udp = UDP(dport=5355)
  llmnr = LLMNRQuery()
  llmnr.qr = 0
  llmnr.opcode = 0
  llmnr.qdcount = 1 
  llmnr.id = random.getrandbits(16)
  llmnr.qd = DNSQR(qname="wpad",qtype="A")
  packet = ip/udp/llmnr

  while(1):
    send(packet)
    time.sleep(5)

def main():
  readthread = threading.Thread(target=read, args=())
  readthread.start()
  write()

main()
