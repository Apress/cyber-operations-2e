#include<stdio.h>

# CGI program that prints the environment variables from the server.

int main(int argc, char* argv[], char* env[])
{
   char** env_entry;
   printf("Content-type: text/html\n\n");
   printf("<!DOCTYPE html>\n");
   printf("<html>\n");
   printf(" <title>Sample C CGI</title>\n");
   printf(" <body>\n");
   printf("  <ul>\n");
   for(env_entry = env; *env_entry != 0; env_entry++) {
      printf("   <li>%s</li>\n",*env_entry);
   }
   printf("  </ul>\n");
   printf(" </body>\n");
   printf("</html>\n");
   return 0;
}
