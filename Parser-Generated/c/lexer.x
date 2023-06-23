%{
#include <stdlib.h>
#include "parser.tab.h"

/* variáveis de estado (globais)
   yylval : valor de um token (int)
*/

%}
%option noyywrap

alpha        [_a-zA-Z]
digit        [0-9]

%%

[ \t\n\r]+                     /* skip whitespace */
{digit}+                       { yylval = atoi(yytext); return TOK_NUM; }
"+"                            { return '+'; }
"("                            { return '('; }
")"                            { return ')'; }
<<EOF>>                        { return EOF; }

%%

