module Intermediate where

import Parser
import Lexer
import           AST
import           IR
import           Data.Map (Map)
import qualified Data.Map as Map
import           Control.Monad.State

type Table = Map Ident String

transVarAccess :: VarAccess -> Ident
transVarAccess (Var x)
  = x

-- translate an expression
transExpr :: Table -> Expr -> Ident -> State Count [Instr]
transExpr tabl (VarAccess x) dest
  = case Map.lookup (transVarAccess x) tabl of
      Just temp -> return [MOVE dest temp]
      Nothing -> error "invalid variable"

transExpr tabl (Num n) dest 
  = return [MOVEI dest n]

transExpr tabl (Str s) dest
  = return [MOVE_STR dest s]

transExpr tabl (Not e) dest
 = do lt <- newLabel
      lf <- newLabel
      lc <- newLabel
      code1 <- transCond tabl e lf lt
      return (code1 ++ [LABEL lt, MOVEI dest 1, JUMP lc] ++ [LABEL lf, MOVEI dest 0, LABEL lc])

transExpr tabl (Neg e) dest
 = do lt <- newLabel
      lf <- newLabel
      lc <- newLabel
      code1 <- transCond tabl e lf lt
      return (code1 ++ [LABEL lt, MOVEI dest 1, JUMP lc] ++ [LABEL lf, MOVEI dest 0, LABEL lc])

transExpr tabl (BinOp e1 op e2) dest
  = do temp1 <- newTemp 
       temp2 <- newTemp 
       code1 <- transExpr tabl e1 temp1 
       code2 <- transExpr tabl e2 temp2
       popTemp 2
       return (code1 ++ code2 ++ [OP op dest temp1 temp2])

transExpr tabl (ValueTrue) dest
  =  do lt <- newLabel
        lf <- newLabel
        lc <- newLabel
        code1 <- transCond tabl (ValueTrue) lt lf
        return (code1 ++ [LABEL lt, MOVEI dest 1, JUMP lc] ++ [LABEL lf, MOVEI dest 0, LABEL lc]) 

transExpr tabl (ValueFalse) dest
  =  do lt <- newLabel
        lf <- newLabel
        lc <- newLabel
        code1 <- transCond tabl (ValueFalse) lt lf
        return (code1 ++ [LABEL lt, MOVEI dest 1, JUMP lc] ++ [LABEL lf, MOVEI dest 0, LABEL lc])  

transExpr tabl (RelOp e1 rel e2) dest
  =  do lt <- newLabel
        lf <- newLabel
        lc <- newLabel
        code1 <- transCond tabl (RelOp e1 rel e2) lt lf
        return (code1 ++ [LABEL lt, MOVEI dest 1, JUMP lc] ++ [LABEL lf, MOVEI dest 0, LABEL lc])

-- transExpr tabl (ReadInt) dest =
--   return([READ_INT])
transExpr tabl (ExprList id []) dest = return([])
transExpr tabl (ExprList id (x:xs)) dest =
  do
    t1 <- newTemp
    expr1 <- transExpr tabl x t1
    popTemp 1
    expr2 <- transExpr tabl (ExprList id xs) dest
    return(expr1 ++ expr2)


transExpr tabl (FunCall f args) dest
 = do (code, temps) <- transArgs tabl args []
      popTemp (length args)
      return (code ++ [FUNC_CALL dest f temps])

transCond :: Table -> Expr -> Label -> Label -> State Count [Instr]
transCond tabl (RelOp e1 rel e2) lt lf
 = do temp1 <- newTemp
      temp2 <- newTemp 
      code1 <- transExpr tabl e1 temp1
      code2 <- transExpr tabl e2 temp2
      popTemp 2
      return ( code1 ++ code2 ++
              [COND temp1 rel temp2 lt lf] )

transCond tabl (ValueTrue) lt lf
  = do return ([JUMP lt])

transCond tabl (ValueFalse) lt lf
  = do return ([JUMP lf])

transArg :: Table -> Expr -> State Count ([Instr], Temp)
transArg tabl expr =
  do t <- newTemp 
     c <- transExpr tabl expr t
     return (c, t) 

transArgs :: Table -> [Expr] -> [Temp] -> State Count ([Instr], [Temp])
transArgs tabl [] xs = return ([], xs)
transArgs tabl (x:xs) ys =
  do
    (c1, t1) <- transArg tabl x
    (c2, t2) <- transArgs tabl xs (t1:ys)
    return (c1 ++ c2, t2)

transStm :: Table -> Stm -> State Count [Instr]
transStm tabl (AssignStm var expr) 
  = case Map.lookup (transVarAccess var) tabl of
      Nothing -> error "undefined variable"
      Just dest -> do temp <- newTemp 
                      code <- transExpr tabl expr temp 
                      return (code ++ [MOVE dest temp])
                      
transStm tabl (IfThen cond stm1) 
  = do lt  <- newLabel 
       lf <- newLabel 
       code0  <- transCond tabl cond lt lf 
       code1  <- transStm tabl stm1
       return (code0 ++ [LABEL lt] ++
               code1 ++ [LABEL lf])

transStm tabl (IfThenElse cond stm1 stm2) 
  = do lt <- newLabel 
       lf <- newLabel 
       lend <- newLabel 
       code0 <- transCond tabl cond lt lf 
       code1 <- transStm tabl stm1 
       code2 <- transStm tabl stm2 
       return (code0 ++ [LABEL lt] ++ code1 ++
               [JUMP lend, LABEL lf] ++ code2 ++ [LABEL lend])

transStm tabl (WhileStm cond stm) =
  do lbody <- newLabel
     lend <- newLabel
     lcond <- newLabel
     code1 <- transStm tabl stm
     code2 <- transCond tabl cond lbody lend
     return ([JUMP lcond, LABEL lbody] ++ code1 ++
              [LABEL lcond] ++ code2 ++ [LABEL lend])

transStm tabl (ProcStm id args) =
  do (c1, ts) <- transArgs tabl args []
     popTemp (length args)
     return(c1 ++ [PROC_CALL id ts])


transStm tabl (CompoundStm []) = return([])
transStm tabl (CompoundStm (x:xs)) =
  do
    c1 <- transStm tabl x
    c2 <- transStm tabl (CompoundStm xs)
    return(c1 ++ c2)

-- transStm tabl (IOStm fun) =
--   do
--     t1 <- transIOLibrary tabl fun
--     return(t1)

-- transIOLibrary :: Table -> IOLibrary -> State Count [Instr]
-- transIOLibrary tabl (WriteInt e) =
--   do expr <- transExpr tabl e "a0"
--      return(expr ++ [WRITE_INT])

-- transIOLibrary tabl (WriteStr s) =
--   do expr <- transExpr tabl (Str s) "a0"
--      return(expr ++ [WRITE_STR])

-- Constants and Variables

transConstDef :: Table -> ConstDef -> State Count ([Instr], Table)

transConstDef tabl (ConstDef id i) =
 do t1 <- newTemp
    code <- transExpr tabl (Num i) t1
    return((code ++ [MOVEI t1 i], Map.insert id t1 tabl))

transConstDecls :: Table -> ConstDecls -> State Count ([Instr], Table)
transConstDecls tabl (NoConstDecl) = return([], tabl)
transConstDecls tabl (ConstDecls []) = return([], tabl)
transConstDecls tabl (ConstDecls (x:xs))
 = do (c1, t1) <- transConstDef tabl x
      (c2, t2) <- transConstDecls t1 (ConstDecls xs)
      return (c1 ++ c2, t2)

transVarDef :: Table -> VarDef -> State Count ([Instr], Table)
-- sem verif de tipos
transVarDef tabl (VarDef id t) = 
  do t1 <- newTemp
     return(([], Map.insert id t1 tabl))

transVarDecls :: Table -> VarDecls -> State Count ([Instr], Table)
transVarDecls tabl (NoVarDecl) = return([], tabl)
transVarDecls tabl (VarDecls []) = return([], tabl)
transVarDecls tabl (VarDecls (x:xs))
 = do (c1, t1) <- transVarDef tabl x
      (c2, t2) <- transVarDecls t1 (VarDecls xs)
      return (c1 ++ c2, t2)

--Procedures

transParam :: Table -> Param -> State Count ([Instr], Table)
transParam tabl (Param id t) =
  do t1 <- newTemp
     return(([], Map.insert id t1 tabl))

transParamList :: Table -> ParamList -> State Count ([Instr], Table)
transParamList tabl (NoParam) = return([], tabl)
transParamList tabl (ParamList []) = return([], tabl)
transParamList tabl (ParamList (x:xs)) =
  do (c1, t1) <- transParam tabl x
     (c2, t2) <- transParamList t1 (ParamList xs)
     return(c2, t2)

transProcHeader :: Table -> ProcHeader -> State Count ([Instr], Table)
transProcHeader tabl (Procedure id pList) =
  do (c1, t2) <- transParamList tabl pList
     return(c1, t2)

transProcHeader tabl (Function id pList t) =
  do (c1, t2) <- transParamList tabl pList
     return(c1, t2)

transProcBody :: Table -> ProcBody -> State Count ([Instr], Table)
transProcBody tabl (ProcBody varDecls stm)
  = do (c1, t1) <- transVarDecls tabl varDecls
       c2 <- transStm t1 stm
       return(c1 ++ c2, t1)

insertIdIntoTable :: Table -> ProcHeader -> State Count ([Instr], Table)
insertIdIntoTable t (Procedure id pList) =
  do t1 <- newTemp
     return(([], Map.insert id t1 t))

insertIdIntoTable t (Function id pList tp) =
  do t1 <- newTemp
     return(([], Map.insert id t1 t))

transProc :: Table -> Proc -> State Count ([Instr], Table)
transProc tabl (Proc pHeader pBody) =
  do 
    (gb, t1) <- insertIdIntoTable tabl pHeader
    (c1, t2) <- transProcHeader t1 pHeader
    (c2, t3) <- transProcBody t2 pBody
    popTemp ((Map.size t3) - (Map.size t1))
    return(c1 ++ c2, t3)

-- Program

transProcDecls :: Table -> ProcDecls -> State Count ([Instr], Table)
transProcDecls tabl (ProcDeclsEmpty) = return([], tabl)
transProcDecls tabl (ProcDecls []) = return([], tabl)
transProcDecls tabl (ProcDecls (x:xs)) =
  do (c1, t1) <- transProc tabl x
     (c2, t2) <- transProcDecls t1 (ProcDecls xs)
     return(c1 ++ c2, t2)

transProgramBody :: ProgramBody -> State Count [Instr]
transProgramBody (ProgramBody constDecls procDecls varDecls stm) =
  do (c1, tb1) <- transConstDecls Map.empty constDecls
     (c2, tb2) <- transProcDecls tb1 procDecls
     (c3, tb3) <- transVarDecls tb2 varDecls
     c4  <- transStm tb3 stm
     return(c1 ++ c2 ++ c3 ++ c4)

transProgram :: Program -> State Count [Instr]
transProgram (Program pHeader pBody) =
  do c2 <- transProgramBody pBody
     return (c2)

---------------------------------------------------------------------------

type Count = (Int,Int)

newTemp :: State Count Temp
newTemp = do (t,l)<-get; put (t+1,l); return ("t"++show t)

popTemp :: Int -> State Count ()
popTemp k =  modify (\(t,l) -> (t-k,l))

newLabel :: State Count Label 
newLabel = do (t,l)<-get; put (t,l+1); return ("L"++show l)
---------------------------------------------------------------------------