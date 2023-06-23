/*
 * Um analisador lexical simples em C
 * Pedro Vasconcelos, 2022
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/* Enumeração para tipos de tokens;
   alguns dos tokens não estão ainda implementados
*/
typedef enum
  { ID, NUM, REAL, SEMICOLON, COMMA,
    LPAREN, RPAREN, LBRACE, RBRACE, 
    IF, INT, FLOAT, WHILE, FOR, END_OF_FILE
  } TokenType;


/* União para os valores dos tokens ;
   alguns dos valores ainda não são usados
*/
typedef union {
  int   ival;        // valor inteiro (NUM)
  float fval;        // valor vírgula flutuante (REAL)
  char  text[255];   // texto (ID)
} TokenValue;

/* obter o próximo token
 */
TokenType getToken(TokenValue *token_value) {
  int c = getchar();

  while(isspace(c))  // consumir carateres brancos
    c = getchar();

  switch(c) {
  case '(':
    return LPAREN;

  case ')':
    return RPAREN;

  case ',':
    return COMMA;

  case EOF:
    return END_OF_FILE;

  default:
    if(isdigit(c)) {
      int val = 0;       // acumulador do valor decimal
      while(isdigit(c)) {
	val = 10*val + c - '0';
	c = getchar();
      }
      ungetc(c,stdin);   // devolver o último carater
                         // que foi consumido a mais
      token_value->ival = val; // valor do token
      return NUM;
    }
    else if(isalpha(c)) {
      int k = 0;
      while(isalpha(c) || isdigit(c)) {
	token_value->text[k++] = c;  // acumular texto 
	c = getchar();
      }
      ungetc(c,stdin);
      token_value->text[k++] = '\0';  // terminar a string
      if (strcmp(token_value->text, "if") == 0) 
	return IF; // palavra reservada
      else 
	return ID; // caso contrário: identificador
    }
    else {
      fprintf(stderr,"unexpected character: %c\n", c);
      exit(-1);
    }  
  }
}


/* função auxiliar para imprimir um token 
 */
void printToken(TokenType token_type, TokenValue *token_value) {
    switch(token_type) {
    case NUM:
      printf("NUM(%d) ", token_value->ival);
      break;
      
    case REAL:
      printf("REAL(%f) ", token_value->fval);
      break;
      
    case ID:
      printf ("ID(%s) ", token_value->text);
      break;
      
    case IF:
      printf("IF ");
      break;

    case FOR:
      printf("FOR ");
      break;

    case WHILE:
      printf("WHILE ");
      break;

    case INT:
      printf("INT ");
      break;

    case FLOAT:
      printf("FLOAT ");
      break;

    case SEMICOLON:
      printf("SEMICOLON ");
      break;
      
    case COMMA:
      printf("COMMA ");
      break;
     
    case LPAREN:
      printf ("LPAREN ");
      break;

    case RPAREN:
      printf ("RPAREN ");
      break;

    case LBRACE:
      printf("LBRACE ");
      break;

    case RBRACE:
      printf("RBRACE ");
      break;

    case END_OF_FILE:
      printf ("END_OF_FILE ");
      break;
    }  
}


/* ler toda a entrada e imprimir a lista de tokens
 */
int main(void) {
  TokenValue tok_val;
  TokenType next =  getToken(&tok_val);  // obter o primeiro token
  
  while(next != END_OF_FILE) { // enquanto não chegou ao fim
    printToken(next, &tok_val);  // imprimir e obter o próximo
    next = getToken(&tok_val);
  }
  printf("\n");
}
