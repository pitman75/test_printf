#include <stdio.h>

extern int puts(const char * data);

char test_string[] = "OK";
char test_char = 'G';
int  test_pint = 12414;
int  test_nint = -25721;
float test_float = 3.14;

void main(void)
{
  printf("Hello RISC-V!\r\n\r\n");
  printf("--------------------------------------\r\n");
  printf("\tTest printf string: %s\r\n", test_string);
  printf("\tTest printf char  : %c\r\n", test_char);
  printf("\tTest positive int : %d\r\n", test_pint);
  printf("\tTest negative int : %d\r\n", test_nint);
  printf("\tTest printf float : %f\r\n", test_float);

  while(1){}
}

