%{
#include <stdio.h>
#include <stdlib.h>
int yylex (void);
void yyerror (char const *);
%}

%define api.value.type {int}
%token TOK_NUM

%%

top : exp           { printf("%d\n", $1); }
    ;

exp : term          { $$ = $1; }
    | exp '+' term  { $$ = $1 + $3; }
    ;


term : TOK_NUM      { $$ = $1; }
     | '(' exp ')'  { $$ = $2; }
     ;



%%

void yyerror (char const *msg) {
  printf("parse error: %s\n", msg);
  exit(-1);
}
