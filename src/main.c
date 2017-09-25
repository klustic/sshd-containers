#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>

int _daemon(int argc, char *argv[], char *envp[])
{
  pid_t pid1, pid2;
  switch ((pid1 = fork()))
  {
  case -1:
    perror("fork1");
    break;
  case 0:
    printf("[child0]: ppid=%d, pid=%d\n", getppid(), getpid());
    chdir("/");
    setsid();
    umask(0);
    switch((pid2 = fork()))
    {
    case -1:
      perror("fork2");
      break;
    case 0:
      printf("[child1]: ppid=%d, pid=%d\n", getppid(), getpid());
      execv(argv[0], &argv[1]);
      break;
    default:
      _exit(0);
      break;
    }
    break;
  default:
    _exit(0);
  }
  return 0;
}
void do_struff(int argc, char *argv[])
{
      execv(argv[0], &argv[1]);
}

int main(int argc, char *argv[], char *envp[])
{
  if (argc < 3)
  {
    printf("Usage: %s <false name> <exe [argv1[,...]]>\n", argv[0]);
    return 1;
  }
  char *tmp = argv[1];
  argv[1] = argv[2];
  argv[2] = tmp;
  do_struff(argc-1, &argv[1]);
  //return _daemon(argc-1, &argv[1], envp);
  return 0;
}
