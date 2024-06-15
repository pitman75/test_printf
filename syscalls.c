#include <sys/stat.h>
#include <errno.h>

extern int __io_putchar(int ch);
extern int __io_getchar(void) __attribute__((weak));

int _getpid(void)
{
  return 1;
}

int _close(int file)
{
  return -1;
}

int _isatty(int file)
{
  return 1;
}

int _lseek(int file, int ptr, int dir)
{
  return 0;
}

int _kill(int pid, int sig)
{
  errno = EINVAL;
  return -1;
}

int _fstat(int file, struct stat *st)
{
  st->st_mode = S_IFCHR;
  return 0;
}

int _read(int file, char *ptr, int len)
{
  int i;

  for (i = 0; i < len; i++)
  {
    *ptr++ = __io_getchar();
  }

  return len;
}

int _write(int file, char *ptr, int len)
{
  int i;

  for (i = 0; i < len; i++)
  {
    __io_putchar(*ptr++);
  }

  return len;
}
