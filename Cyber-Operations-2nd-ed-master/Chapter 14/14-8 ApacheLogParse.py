#!/usr/bin/python
#
# Parse Apache Logs with the format
#
# LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" 
#                                      \"%{User-Agent}i\"" combined
#

log_file_name = "/var/log/apache2/access_log"
log_data = []

log_file = open(log_file_name,'r')
for line in log_file:
   # Host is the beginning of the line, up to the first space.
   host = line.split(' ',1)[0]	
   remainder = line.split(' ',1)[1]

   # Next is the remote system, ending with a space
   remote_log_name = remainder.split(' ',1)[0]	
   remainder = remainder.split(' ',1)[1]

   # Next is the user name, ending with a space
   remote_user_name = remainder.split(' ',1)[0]
   remainder = remainder.split(' ',1)[1]

   # Next is the time. If starts with a bracket [
   # Then comes the (text) date
   # Then a space and the time zone
   # Then the closing bracket
   remainder = remainder.split('[',1)[1]  
   time = remainder.split(' ')[0]      
   
   # Next comes the request, which begins and ends with quotes
   remainder = remainder.split('"',1)[1] 
   request = remainder.split('"',1)[0]	           
   
   # Next is the return code, which starts and ends with a space
   remainder = remainder.split('"',1)[1].lstrip()  
   return_code = remainder.split(' ',1)[0]	
   remainder = remainder.split(' ',1)[1]

   # Next is the size of the response in bytes, separated by spaces
   response_size = remainder.split('"')[0].strip()
   
   # Next is the referer, in quotes
   remainder = remainder.split('"',1)[1]	
   referer = remainder.split('"')[0]
   
   # Last is the user agent, enclosed in quotes
   user_agent = remainder. split('"')[2]

   log_data.append({'host':host,
                    'remote_log_name':remote_log_name,
                    'remote_user_name':remote_user_name,
                    'text_time': time,
                    'request':request,
                    'return_code':return_code,
                    'response_size':response_size,
                    'referer':referer,
                    'user_agent':user_agent})
