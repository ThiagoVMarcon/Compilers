/*
  Exercício 3:

  Considere a gramática para expressões aritméticas:

  E -> T  E' 
  E' -> + T E' 
  E' -> - T E'
  E' -> 

  T  -> F T'
  T' -> * F T'
  T' -> / F T'
  T' -> 

  F -> num
  F -> ( E ) 

 Implemente um *parser* para esta gramática usando descida recursiva.
*/
#include <stdlib.h>
#include <stdio.h>
#include "tokens.h"

Token next;    /* token de "look-ahead" (global) */

/* funcão auxiliar para ler um novo token
 */
void advance(void) {
  next = yylex();   /* invocar analisador lexical */
}

/* função auxiliar para terminar com erro
 */
void error(void) {
  printf("Syntax error\n");
  exit(0);
}

/* função auxiliar para consumir um próximo token específico
   ou terminar com erro
 */
void consume(Token tok) {
  if(next == tok)
    advance();
  else
    error();
}



void parseE(void) {
  /* completar esta definição
   */
  /* Deve ainda definir funções recursivas para os outros não-terminais
   da gramática, i.e. parseE1, parseT, parseT1, parseF,
  */
}

