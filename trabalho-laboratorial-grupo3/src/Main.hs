module Main where

import Lexer
import Parser
import Intermediate
import AST
import MIPSGen
import Control.Exception
import Control.Monad.State 
import Data.Map (Map)


ln :: [String] -> [String]
ln [] = ["\n"]
ln (x:xs) = x : "\n" : ln xs

main :: IO ()
main = do
  txt <- getContents
  let ast = parse (alexScanTokens txt)
  writeFile "ast.txt" $ show ast ++ "\n"
  let intermed = evalState (transProgram ast) (0, 0)
  writeFile "intermed.txt" $ show intermed ++ "\n"
  let assMIPS = myPrint $ begin intermed
  writeFile "mips.asm" assMIPS
