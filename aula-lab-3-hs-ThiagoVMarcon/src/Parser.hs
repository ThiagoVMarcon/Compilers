{-
  Exercício 3:

  Considere a gramática para expressões aritméticas:

  E -> T  E' 
  E' -> + T E' 
  E' -> - T E'
  E' -> 

  T  -> F T'
  T' -> * F T'
  T' -> / F T'
  T' -> 

  F -> num
  F -> ( E ) 

 Implemente um *parser* para esta gramática usando descida recursiva.
-}

module Parser where

import Lexer

--
-- | parser de expressões; corresponde ao não-terminal E
-- 1) consumir *tokens* 
-- 2) retornar os *tokens* que sobram
-- 3) em caso de erro: invocar parseError
--
-- completar esta definição inicial (que termina imediatamente sem consumir nada)
-- necessita ainda de funções extra parseE', parseT, etc.
-- para para cada um dos não-terminais
--
parseE :: [Token] -> [Token]                        -- E -> T  E' 
parseE toks
  = let toks1 = parseT toks
    in          parseE' toks1

parseE' :: [Token] -> [Token] 
parseE' []           = []                           -- E' ->
parseE' (first:toks) = case first of
  PLUS  -> let toks1 = consume PLUS (first:toks)    -- E' -> + T E'
               toks2 = parseT toks1
           in  parseE' toks2
  MINUS -> let toks1 = consume MINUS (first:toks)   -- E' -> - T E'
               toks2 = parseT toks1
           in  parseE' toks2
  _     -> (first:toks)  
                                 
parseT :: [Token] -> [Token]                        -- T  -> F T'
parseT toks
  = let toks1 = parseF toks
    in          parseT' toks1

parseT' :: [Token] -> [Token]  
parseT' []           = []                           -- T' -> 
parseT' (first:toks) = case first of
  MULT  -> let toks1 = consume MULT (first:toks)    -- T' -> * F T'
               toks2 = parseF toks1
           in          parseT' toks2
  DIV   -> let toks1 = consume DIV (first:toks)     -- T' -> / F T'
               toks2 = parseF toks1
           in          parseT' toks2
  _     -> (first:toks) 
                        
parseF :: [Token] -> [Token]     
parseF (first:toks) = case first of
  NUM -> consume NUM (first:toks)                   -- F -> num
  LPAREN -> let toks1 = consume LPAREN (first:toks) -- F -> ( E ) 
                toks2 = parseE toks1
            in consume RPAREN toks2

-- função auxiliar para consumir um token específico ou terminar com erro
consume :: Token -> [Token] -> [Token]
consume tok (t:ts) | tok == t = ts
consume tok ts                = parseError ts
  
parseError :: [Token] -> a
parseError toks = error ("parse error at " ++ show toks)
