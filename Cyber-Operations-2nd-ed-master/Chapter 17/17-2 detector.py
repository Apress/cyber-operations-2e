#!/usr/bin/python

# Python script to detect TCP packets sent from 10.0.2.3.

from scapy.all import sniff,TCP,IP

sniff(iface="eth0",
      prn = lambda x: "IP:{} TCP:{}".format(x[IP].src,x[TCP].dport),
      filter = "tcp and dst 10.0.2.3")
