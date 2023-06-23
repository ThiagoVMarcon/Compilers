{- Example Happy parser for simple arithmetic expressions.
   Semantic actions compute the value of the expressions.
   Pedro Vasconcelos, 2021
-}

{
module Parser where
import Lexer
}

%name parser
%tokentype { Token }
%error { parseError }

%token

num      { TOK_NUM $$ }
'+'      { TOK_PLUS }
'('      { TOK_LPAREN }
')'      { TOK_RPAREN }

%%

Exp : Term             { $1 }
     | Exp '+' Term    { $1 + $3 }


Term : num             { $1 }
     | '(' Exp ')'     { $2 }

{
parseError :: [Token] -> a
parseError toks = error "parse error"
}  
