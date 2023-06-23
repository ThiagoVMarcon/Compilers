{-
  Um analisador lexical simples em Haskell
  Pedro Vasconcelos, 2022
-}
module Main where

import Data.Char (isDigit, isSpace, isAlpha, isAlphaNum)

-- Tipo algébrico para tokens;
-- alguns dos casos ainda não estão implementados
data Token = ID String       -- e.g. xy123
           | NUM Int         -- e.g. 123
           | REAL Float      -- e.g. 123.45
           | LPAREN          -- (
           | RPAREN          -- )
           | LBRACE          -- {
           | RBRACE          -- }
           | COMMA           -- ,
           | SEMICOLON       -- ;
           | IF              -- if
           | WHILE           -- while
           | FOR             -- for
           | INT             -- int
           | FLOAT           -- float
           deriving (Eq,Show)

--
-- transformar lista de carateres numa lista de tokens
--
lexer :: [Char] -> [Token]
lexer [] = []
lexer (',':xs) = COMMA : lexer xs
lexer ('(':xs) = LPAREN : lexer xs
lexer (')':xs) = RPAREN  : lexer xs
lexer ('{':xs) = LBRACE  : lexer xs
lexer ('}':xs) = RBRACE  : lexer xs
lexer (';':xs) = SEMICOLON  : lexer xs
lexer ('/':'/':xs ) = lexer ys      -- tratamento de comentários
  where zs = takeWhile (/='\n') xs
        (y:ys) = dropWhile (/='\n') xs
lexer ('/':'*':xs) = lexer (myComment xs)     -- tratamento de comentários multi-linha
lexer (x:xs)
  | isSpace x = lexer xs        -- consumir carateres brancos
lexer (x:xs)                    
  | isDigit x = if head ys == '.' then REAL (read ((x:xs') ++ ('.':zs))) : lexer ys'      -- reconhecer números com vírgula-flutuante
                else NUM (read (x:xs')) : lexer ys  
  where xs' = takeWhile isDigit xs
        ys = dropWhile isDigit xs
        zs =  takeWhile isDigit (tail ys)
        ys'= dropWhile isDigit (tail ys)
lexer (x:xs)          
  | isAlpha x || x == '_' = lexerText (x:xs') : lexer xs''      -- reconhecer '_' como se fosse uma letra
  where xs' = takeWhile myAlphaNum xs
        xs''= dropWhile myAlphaNum xs
lexer (x:_)       -- outros carateres: erro
  = error ("invalid character: " ++ show x)

-- -- função auxiliar para reconhecer o final de comentários multi-linha
myComment :: [Char] -> [Char]
myComment ('*':'/':xs) = xs
myComment (x:xs) = myComment xs

-- função auxiliar para aceitar '_' como se fosse uma letra
myAlphaNum :: Char -> Bool
myAlphaNum '_' = True
myAlphaNum x = isAlphaNum x

-- função auxiliar para distinguir palavras reservadas de identificadores
lexerText :: String -> Token
lexerText "if" = IF
lexerText "while" = WHILE
lexerText "for" = FOR
lexerText "int" = INT
lexerText "float" = FLOAT
lexerText xs = ID xs


-- ler toda a entrada e imprimir a lista de tokens
main :: IO ()
main = do
  txt <- getContents
  print (lexer txt)

  
