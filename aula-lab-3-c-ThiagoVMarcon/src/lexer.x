%{
/* Um analisador lexical para expressões aritméticas simples */

#include "tokens.h"
#define YY_DECL Token yylex(void)
%}
%option noyywrap

white  [\ \t\n\r]
digit  [0-9]
 
%%

{white}+  /* ignorar carateres brancos */

"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return MULT; }
"/"       { return DIV; }
"("       { return LPAREN; }
")"       { return RPAREN; }

{digit}+   { return NUM; }
<<EOF>>    { return END_OF_FILE; }
 
