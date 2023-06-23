module IR (Instr(..), BinOp(..), Temp, Label) where

import AST (BinOp(..), RelOp(..), Ident)

type Temp  = String
type Label = String

data Instr = MOVE Temp Temp 
           | MOVEI Temp Int
           | MOVE_STR Temp String
           | OP BinOp Temp Temp Temp
           | OPI BinOp Temp Temp Int
           | LABEL Label
           | JUMP Label
           | COND Temp RelOp Temp Label Label
           | FUNC_CALL Temp Label [Temp]         
           | PROC_CALL Label [Temp]              
           | PROC Ident [Instr] 
           deriving (Eq, Show)
        --    | WRITE_INT
        --    | WRITE_STR
        --    | READ_INT
           

