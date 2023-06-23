{
-- Example lexer for a simple expression language.
-- Pedro Vasconcelos, 2021.
module Lexer where 
}

%wrapper "basic"
-- interface básica
-- alexScanTokens :: String -> [Token]

-- regexp definitions
$white = [\ \t\n\r]
$digit = [0-9]

tokens :-  
  
$white+                    ;  -- skip whitespace
$digit+                    { \s -> TOK_NUM (read s) }
"+"                        { \s -> TOK_PLUS }
"("                        { \s -> TOK_LPAREN }
")"                        { \s -> TOK_RPAREN }

{
 -- the token type
data Token = TOK_NUM Int 
           | TOK_PLUS
           | TOK_LPAREN
           | TOK_RPAREN
           deriving (Eq, Show)
  
}
