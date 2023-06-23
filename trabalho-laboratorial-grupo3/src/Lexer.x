{
module Lexer where
import Data.Char
import Data.List
}

%wrapper "basic"

$white =  [\ \t\n\r]
$digit =  [0-9]
$alpha = [_a-zA-Z]
@comment = ( [^\*] | \*[^\)] | \*\n | \n )*

tokens :-

$white+            ;   -- ignore "white" characters
"(*"@comment"*)"   ;   -- ignore comments

"'"$printable*"'"        { \s -> STR (removeQuotes s)}
$alpha($alpha|$digit)*  { \s -> stringToToken s }
$digit+                 { \s -> NUM (read s) }

-- PUNCTUATION SIGNS:

","       { \_ -> COMMA }
"."       { \_ -> PERIOD }
":"       { \_ -> COLON }
";"       { \_ -> SEMICOLON }
"("       { \_ -> LPAREN }
")"       { \_ -> RPAREN }
"["       { \_ -> LBRACK }
"]"       { \_ -> RBRACK }

-- INFLIX OPERATORS: 

"+"       { \_ -> PLUS }
"-"       { \_ -> MINUS }
"*"       { \_ -> MULT }
"="       { \_ -> EQUAL }
"<>"      { \_ -> NOTEQUAL }
"<"       { \_ -> LTHAN }
"<="      { \_ -> LTHANEQUAL }
">"       { \_ -> GTHAN }
">="      { \_ -> GTHANEQUAL }
"/"       { \_ -> DIV }
":="      { \_ -> ATT }

{

data Token 
  = PROGRAM       
  | FUNCTION        
  | PROCEDURE
  | CONST               
  | VAR         
  | BEGIN         
  | END         
  | IF        
  | THEN          
  | ELSE          
  | WHILE  
  | DO  
  | FOR
  | TO
  | AND
  | OR 
  | NEG
  | NOT          
  | TRUE        
  | FALSE         
  | INTEGER      
  | BOOLEAN
  | STRING   
  | STR String
  | NUM Int  
  | ID String 
  | ARRAY
  | OF  
  | BREAK
  | COMMA
  | PERIOD
  | COLON
  | SEMICOLON
  | LPAREN 
  | RPAREN 
  | LBRACK 
  | RBRACK 
  | PLUS                       
  | MINUS                      
  | MULT                                              
  | EQUAL                      
  | NOTEQUAL                   
  | LTHAN
  | LTHANEQUAL                      
  | GTHAN                            
  | GTHANEQUAL 
  | DIV  
  | MOD 
  | ATT       
  -- | READINT
  -- | WRITEINT
  -- | WRITESTR       
  deriving (Eq, Show)

--  KEYWORDS: 

stringToToken :: String -> Token
stringToToken s = case (toLowerCase s) of
  "program"      ->       PROGRAM      
  "function"     ->       FUNCTION     
  "procedure"    ->       PROCEDURE   
  "const"        ->       CONST
  "var"          ->       VAR            
  "begin"        ->       BEGIN       
  "end"          ->       END         
  "if"           ->       IF          
  "then"         ->       THEN        
  "else"         ->       ELSE        
  "while"        ->       WHILE        
  "do"           ->       DO
  "for"          ->       FOR               
  "to"           ->       TO 
  "mod"          ->       MOD 
  "and"          ->       AND
  "or"           ->       OR
  "not"          ->       NOT
  "true"         ->       TRUE 
  "false"        ->       FALSE                    
  "integer"      ->       INTEGER     
  "boolean"      ->       BOOLEAN
  "string"       ->       STRING
  "array"        ->       ARRAY
  "of"           ->       OF
  "break"        ->       BREAK
  otherwise      ->       ID (toLowerCase s)
  -- "readint"      ->       READINT
  -- "writeint"     ->       WRITEINT
  -- "writestr"     ->       WRITESTR
  

toLowerCase :: String -> String
toLowerCase s = map toLower s

removeQuotes :: String -> String
removeQuotes s = init(tail s)

}

