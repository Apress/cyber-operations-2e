#!/usr/bin/python

# This is a script that looks for s file (stars.csv) with content like
#
#  sirius,10.0.2.10
#  canopus,10.0.2.11
#  siriusb,10.0.2.12
#  canopusb,10.0.2.13
#  arcturus,10.0.2.14
#
# It then builds a portion of a BIND forward zone and a BIND reverse zone from this data.


import csv

input_file_name = "stars.csv"
forward_file_name = "forward.txt"
reverse_file_name = "reverse.txt"
domain_name = ".stars.example."

input_file = open(input_file_name,'r')
forward_file = open(forward_file_name,'w')
reverse_file = open(reverse_file_name,'w')

input_reader = csv.reader(input_file)
for line in input_reader:
   host = line[0]
   ip = line[1]

   fqdn = host +  domain_name
   padding = ' ' * (30 - len(fqdn))
   forward_file.write(fqdn + padding + 'IN A     ' + ip + '\n')  
   
   [i1,i2,i3,i4] = ip.split('.')
   revaddr = i4 + '.' + i3 + '.' + i2 + '.' + i1 + '.in-addr.arpa.'
   padding = ' ' * (30 - len(revaddr))
   reverse_file.write(revaddr + padding + 'IN PTR   ' + fqdn + '\n')
