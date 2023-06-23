{
-- Analisador lexical para a calculador simples
module Lexer where
}
%wrapper "basic"

$white =  [\ \t\n\r]
$digit =  [0-9]

tokens :-

$white+    ;   -- ignorar carateres "brancos"

"+"       { \_ -> PLUS }
"-"       { \_ -> MINUS }
"*"       { \_ -> MULT }
"/"       { \_ -> DIV }
"("       { \_ -> LPAREN }
")"       { \_ -> RPAREN }
"sqrt"    { \_ -> SQRT }
"exp"     { \_ -> EXP }
"log"     { \_ -> LOG }

$digit+"."$digit+|$digit+ { \s -> NUM (read s) }

{

data Token 
  = PLUS
  | MINUS
  | MULT
  | DIV
  | LPAREN
  | RPAREN
  | SQRT
  | EXP
  | LOG
  | NUM Float
  deriving (Eq, Show)
  
}
