{-
  Exercícios para a Aula Laboratorial 1

  Escrever um interpretador em Haskell da sintaxe abstrata de
  programas sequenciais.

  Pedro Vasconcelos, 2022.

  Baseado num exercício do livro "Modern Compiler Implementation in
  ML", A. Appel.
-}

module Interpreter where
import Data.Maybe (fromJust)

--
-- sintaxe abstrata de programas sequenciais
--
type Ident = String  -- identificadores (nomes de variaveis)

data BinOp = Plus | Minus | Times | Div -- operações binárias
           deriving (Eq, Show)

data Stm = AssignStm Ident Exp   -- ident = exp
         | IncrStm Ident         -- ident++
         | CompoundStm Stm Stm   -- stm1; stm2
         deriving (Eq, Show)

data Exp = IdExp Ident           -- x, y, z ..
         | NumExp Int            -- 123
         | OpExp Exp BinOp Exp   -- e1+e2, e1*e2, ...
         deriving (Eq, Show)


{- Exercício 1.

Escrever duas funções recursivas para listar todos os identificadores
em comandos e expressões.

NOTA: escreva uma equação para cada construtor da sintaxe abstrata
acima. A função idsStm deve chamar idsExp os comandos contêm sub-expressões.
-}

idsStm :: Stm -> [Ident]
idsStm (AssignStm letter exp) = [letter] ++ (idsExp exp)
idsStm (IncrStm letterIncr) = [letterIncr]
idsStm (CompoundStm stm1 stm2) = (idsStm stm1) ++ (idsStm stm2)


idsExp :: Exp -> [Ident]
idsExp (IdExp letter) = [letter]
idsExp (NumExp number) = []
idsExp (OpExp e1 op e2) = idsExp e1 ++ idsExp e2

-- NB: o que acontece se um identificador ocorrer mais do que uma vez?


{- Exercício 2: um interpretador funcional 

Escreva duas funções mutuamente recursivas para interpretar comandos
e expressões.

Represente tabelas associações de valores (inteiros) aos
identificadores como listas de pares.
Por exemplo, a lista [("x", 2), ("y", 0)] associa x -> 2, y -> 0.

Sugestões: use a função do prelúdio

lookup :: Eq a => a -> [(a,b)] -> Maybe b

para procurar o valor (se existir) associado a um identificador.
-}

type Table = [(Ident, Int)]    

        
interpStm :: Stm -> Table -> Table
interpStm (AssignStm letter exp) table
                                 | lookup letter table == Nothing = case1
                                 | otherwise = case2
                                 where case1 = table ++ [(letter, interpExp exp table)]
                                       case2 = filter (/= (letter, fromJust (lookup letter table))) table ++ [(letter, interpExp exp table)]
interpStm (IncrStm letterIncr) table = filter (/= (letterIncr, (fromJust (lookup letterIncr table)))) table ++ [(letterIncr, (fromJust (lookup letterIncr table)) + 1)]
interpStm (CompoundStm stm1 stm2) table = interpStm stm2 (interpStm stm1 table)
                                        

interpExp :: Exp -> Table -> Int 
interpExp (IdExp letter) table = fromJust (lookup letter table)
interpExp (NumExp number) table = number
interpExp (OpExp e1 op e2) table = case op of 
                                   Plus -> (interpExp e1 table) + (interpExp e2 table)
                                   Minus -> (interpExp e1 table) - (interpExp e2 table)
                                   Times -> (interpExp e1 table) * (interpExp e2 table)
                                   Div -> (interpExp e1 table) `div` (interpExp e2 table)


  
