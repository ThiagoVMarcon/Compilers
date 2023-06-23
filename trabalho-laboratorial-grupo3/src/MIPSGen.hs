module MIPSGen where

--import Intermediate
import IR
import Parser
import AST

intermedToMips :: Instr -> [String]
intermedToMips instr = case instr of
   MOVE t1 t2 -> ["\tmove $" ++ t1 ++ " , $" ++ t2]
   MOVEI t1 int -> ["\tli $" ++ t1 ++ " , " ++ show int]
   OP binop t1 t2 t3 -> case binop of
    Plus -> ["\tadd $" ++ t1 ++ " , $" ++ t2 ++ " , $" ++ t3]
    Minus -> ["\tsub $" ++ t1 ++ " , $" ++ t2 ++ " , $" ++ t3]
    Mult -> ["\tmult $" ++ t2 ++ " , $" ++ t3, "\tmflo $" ++ t1]
    Div -> ["\tdiv $" ++ t2 ++ " , $" ++ t3, "\tmflo $" ++ t1]
    Mod -> ["\tdiv $" ++ t2 ++ " , $" ++ t3, "\tmfhi $" ++ t1]
   OPI binop t1 t2 int -> case binop of
    Plus -> ["\taddi $" ++ t1 ++ " , $" ++ t2 ++ " , $" ++ show int]
    Minus -> ["\tsub $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ show int]
    Mult -> ["\tmult $" ++ t2 ++ " , $" ++ show int , "\tmflo $" ++ t1]
    Div -> ["\tdiv $" ++ t2 ++ " , " ++ show int, "\tmflo $" ++ t1]
    Mod -> ["\tdiv $" ++ t2 ++ " , " ++ show int, "\tmfhi $" ++ t1]
   LABEL l1 -> [l1 ++ ": "]
   JUMP l1 -> ["\tj " ++ l1]
   COND t1 relop t2 l1 l2 -> case relop of
    Equal -> ["\tbne $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l2, "\tj " ++ l1]
    NotEqual -> ["\tbeq $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l2, "\tj " ++ l1]
    LThan -> ["\tblt $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l1, "\tj " ++ l2]
    GThan -> ["\tbgt $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l1, "\tj " ++ l2] 
    LThanEqual -> ["\tbgt $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l2, "\tj " ++ l1]
    GThanEqual -> ["\tblt $" ++ t1 ++ " , $" ++ t2 ++ " , " ++ l2, "\tj " ++ l1]
   FUNC_CALL t name args -> callFun name args 0 ++ intermedToMips (MOVE t "$v0")
   PROC_CALL name args -> callFun name args 0
   PROC name code -> intermedToMips (LABEL name) ++ ["sw $fp, -4($sp)", "sw $ra, -8($sp)", "la $fp, 0($sp)"] ++ begin' code
   -- READ_INT -> ["\tli $v0, 5", "\tsyscall", "\tjr $ra"]
   -- WRITE_INT -> ["\tli $v0, 1", "\tsyscall", "\tjr $ra"]
   -- WRITE_STR -> ["\tli $v0, 4", "\tsyscall", "\tjr $ra"]
   
iO :: String -> [String]
iO instr = case instr of
    "readint" -> intermedToMips (LABEL "\nreadint") ++ ["\tli $v0, 5", "\tsyscall", "\tjr $ra"]
    "writeint" -> intermedToMips (LABEL "\nwriteint") ++ ["\tli $v0, 1", "\tlw $a0, 0($sp)", "\tsyscall", "\tjr $ra"]
    "writestr" -> intermedToMips (LABEL "\nwritestr") ++ ["\tli $v0, 4", "\tlw $a0, 0($sp)", "\tsyscall", "\tjr $ra"]

myPrint :: [String] -> String
myPrint [] = "\n"
myPrint (x:xs) = x ++ "\n" ++ myPrint xs

begin :: [Instr] -> [String]
begin instr = [".text"] ++ begin' instr ++ iO "readint" ++ iO "writeint" ++ iO "writestr"

begin' :: [Instr] -> [String]
begin' [] = []
begin' (x:xs) =
  let code1 = intermedToMips x
      code2 = begin' xs
   in code1 ++ code2

callFun :: Label -> [Temp] -> Int -> [String]
callFun name [] offset =
  ["la " ++ "$sp, " ++ show offset ++ "($sp)", "jal " ++ name, "la $sp, " ++ show (offset * (-1)) ++ "($sp)"]
callFun name (a : args) oldOffset =
  let newOffset = oldOffset - 4
      storeArg1 = ["sw " ++ "$" ++ a ++ " , " ++ show newOffset ++ "($sp)"]
      restArgs = callFun name args newOffset
   in storeArg1 ++ restArgs
