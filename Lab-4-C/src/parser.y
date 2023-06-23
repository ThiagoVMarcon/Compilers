%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex (void);
void yyerror (char const *);
%}
%define api.value.type {float}

/* completar: declarações de tokens */


%%

top : expr                    { printf("%f\n", $1); }
    ;


/* completar: regras de gramática para expr */

%%

void yyerror(char const *msg) {
   printf("parse error: %s\n", msg);
   exit(-1);
}

