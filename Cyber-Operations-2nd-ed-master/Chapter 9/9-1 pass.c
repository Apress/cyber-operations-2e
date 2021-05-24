/* pass.c, a program to determine a password hash using 3DES. */

#define _XOPEN_SOURCE
#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  const char *salt = "42";
  const char *password ="";
  char* hash;

  hash = crypt(password, salt);

  printf("Hash is %s\n",hash);

  return 0;
}
