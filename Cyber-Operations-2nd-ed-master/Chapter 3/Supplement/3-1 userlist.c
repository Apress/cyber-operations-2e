/* userlist.c 
*
* Sample program to query data from /var/run/utmp
* Compile: gcc userlist.c -o userlist
* Run: ./userlist
*/

#include<fcntl.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<utmp.h>

void print_record_type(short type){
   if(type == EMPTY)         printf("  Invalid Record\n");
   if(type == RUN_LVL)       printf("  Change in run level\n");
   if(type == BOOT_TIME)     printf("  System boot time\n");
   if(type == NEW_TIME)      printf("  Time after system clock change\n");
   if(type == OLD_TIME)      printf("  Time before system clock change\n");
   if(type == INIT_PROCESS)  printf("  Process spawned by init\n");
   if(type == LOGIN_PROCESS) printf("  Session for user login\n");
   if(type == USER_PROCESS)  printf("  Normal process\n");
   if(type == DEAD_PROCESS)  printf("  Terminated process\n");
}

int main(int agrc, char* argv[]) {

   struct utmp utmp_entry;
   int utmp_fd;

   utmp_fd = open(UTMP_FILE, O_RDONLY);
   if(utmp_fd < 0) {
      perror("Error opening utmp file");
      exit(1);
   }

   while( read(utmp_fd, &utmp_entry, sizeof(utmp_entry))){
      printf("Log name: %s\n", utmp_entry.ut_name);
      print_record_type(utmp_entry.ut_type);
      printf("  PID: %i\n", utmp_entry.ut_pid);
      printf("  TTY: %s\n", utmp_entry.ut_line);
      printf("  User: %s\n", utmp_entry.ut_user);
      printf("  Host: %s\n", utmp_entry.ut_host);
}  

   exit(0);
}
