module AST where

-- Programs

data Program = Program ProgramHeader ProgramBody --done
             deriving Show

data ProgramHeader = ProgramHeader Ident --done
                   deriving Show

data ProgramBody = ProgramBody ConstDecls ProcDecls VarDecls Stm --done
                 deriving Show

data ProcDecls = ProcDecls [Proc] --done
               | ProcDeclsEmpty   --done
               deriving Show

-- Procedures and Functions

data Proc = Proc ProcHeader ProcBody --done
          deriving Show

data ProcHeader = Procedure Ident ParamList --done
                | Function Ident ParamList Type --done
                deriving Show

data ProcBody = ProcBody VarDecls Stm --done
              deriving Show

data ParamList = ParamList [Param] --done
               | NoParam            --done
               deriving Show

data Param = Param Ident Type       --done
           deriving Show

-- Statements 

data Stm = AssignStm VarAccess Expr         --done
         | IfThenElse Expr Stm Stm          --done   
         | IfThen Expr Stm                  --done
         | WhileStm Expr Stm                --done
         | ForStm Ident Expr Expr Stm       --
         | BreakStm
         | ProcStm Ident [Expr]             --done
         | CompoundStm [Stm]                --done
        --  | IOStm IOLibrary                  --done
         deriving Show

-- Expressions

type Ident = String

data Expr = VarAccess VarAccess     --done            
          | Num Int                       --done           
          | Str String              --done
          | ValueTrue               --done         
          | ValueFalse              --done   
          | FunCall Ident [Expr]    --done     
          | BinOp Expr BinOp Expr   --done
          | RelOp Expr RelOp Expr   --done
          | Not Expr                -- done
          | Neg Expr                --done
          | ExprList Ident [Expr]   --
        --   | ReadInt                 --done
          deriving (Eq, Show)

data VarAccess = Array Ident Expr
               | Var Ident
               deriving (Eq, Show)

data BinOp = Plus                --done       
           | Minus               --done       
           | Mult                --done       
           | Div                 --done       
           | Mod                 --done                       
           deriving (Eq, Show)

data RelOp = Equal               --done       
           | NotEqual            --done       
           | LThan               --done       
           | GThan               --done       
           | LThanEqual          --done       
           | GThanEqual          --done
           | And                 --done
           | Or                  --done
           deriving (Eq, Show)

-- Declarations --done

data ConstDecls = ConstDecls [ConstDef] --done
                | NoConstDecl           --done
                deriving Show

data VarDecls = VarDecls [VarDef]       --done
              | NoVarDecl               --done
              deriving Show

data ConstDef = ConstDef Ident Int      --done
              deriving (Eq, Show) 

data Type = TypeInteger                
          | TypeBoolean
          | TypeString                
          | TypeFun [Type] Type 
          | TypeArray Const Const Type       
          deriving (Eq, Show)

data VarDef = VarDef Ident Type         --done
            deriving Show

data Const = Numeral Int                --idk?
           | Identifier Ident           --idk?  
           deriving (Eq, Show)

-- I/O Library

-- data IOLibrary = WriteInt Expr
--                | WriteStr String
--                deriving (Eq, Show)