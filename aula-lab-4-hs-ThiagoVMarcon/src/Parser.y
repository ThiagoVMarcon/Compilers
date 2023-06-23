{
-- Analisador sintático para a calculadora simples
module Parser where
import Lexer  
}

%name parse
%tokentype { Token }
%error { parseError }

%token

'+'       { PLUS }
'-'       { MINUS }
'*'       { MULT }
'/'       { DIV }
'('       { LPAREN }
')'       { RPAREN }
sqrt      { SQRT }
exp       { EXP }
log       { LOG }
num       { NUM $$}

%left '+' '-'              -- Precedência de operadores '+' '-' à esquerda 
%left '*' '/'              -- Precedência de operadores '*' '/' à esquerda 
                           -- Quanto mais abaixo, maior a precedência. Então: '*' '/' antes de '+' '-'
%%

Exp : Exp '+' Exp           { $1 + $3} 
    | Exp '-' Exp           { $1 - $3}
    | Exp '*' Exp           { $1 * $3}
    | Exp '/' Exp           { $1 + $3}
    | '(' Exp ')'           {   $2   }
    | F '(' Exp ')'         { $1  $3 }
    | num                   {   $1   }

F : sqrt { sqrt }
  | exp  { exp  }
  | log  { log  }

{
parseError :: [Token] -> a
parseError toks = error "parse error"  
}

