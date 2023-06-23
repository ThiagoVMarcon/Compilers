
module Main where

import Lexer
import Parser

main = do
  txt <- getContents
  print (parser $ alexScanTokens txt)
  
 
