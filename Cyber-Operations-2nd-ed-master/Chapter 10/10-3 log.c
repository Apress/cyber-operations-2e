/* log.c, a program write an entry to the system log */

#include<syslog.h>

int main(int argc, char* argv[])
{
   const char log_ident[] = "named [31337]";
   const int log_option = LOG_NDELAY ;
   const int log_facility = LOG_SYSLOG;
   openlog(log_ident, log_option, log_facility);
   
   syslog(LOG_CRIT, "I just experienced a critical error!");

   closelog();
   return(0);
}
