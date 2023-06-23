
#include <stdio.h>
#include "tokens.h"

extern void parseE(void);

int main(void) {
  advance();
  parseE();
  consume(END_OF_FILE);
  printf("Syntax OK\n");
}
