/*
  Uma calculadora simples em Haskell
  ----------------------------------

  Completar:
  - o analisador lexical no ficheiro lexer.x;
  - o analisador sintático no ficheiro parser.y

  O analisador sintático devolve diretamente o valor da expressão
  (float) sem construir uma árvore sintática.

  Este módulo apenas lê uma linha de input e invoca
  o analisador lexical e sintático em sequência.

  Pedro Vasconcelos, 2022
*/

#include <stdio.h>
#include "parser.tab.h"

int main(void) {
  yyparse();
}
