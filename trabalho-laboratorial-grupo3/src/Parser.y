{
module Parser where
import Lexer
import AST   
}

%name parse
%tokentype { Token }
%error { parseError }

%token

-- KEYWORDS:

program       { PROGRAM }
function      { FUNCTION }
procedure     { PROCEDURE }
const         { CONST }
var           { VAR }
begin         { BEGIN }
end           { END }
if            { IF }
then          { THEN }
else          { ELSE }
while         { WHILE }
do            { DO }
for           { FOR }
to            { TO }
and           { AND }
or            { OR }
not           { NOT }
true          { TRUE }
false         { FALSE }
integer       { INTEGER }
boolean       { BOOLEAN }
string        { STRING }
array         { ARRAY }
of            { OF }
break         { BREAK }
num           { NUM $$ }
str           { STR $$ }
ident         { ID $$ }
-- readint       { READINT }
-- writeint      { WRITEINT }
-- writestr      { WRITESTR }


-- PUNCTUATION SIGNS:

','       { COMMA }
'.'       { PERIOD }
':'       { COLON }
';'       { SEMICOLON }
'('       { LPAREN }
')'       { RPAREN }
'['       { LBRACK }
']'       { RBRACK }

-- INFLIX OPERATORS: 

'+'       { PLUS }
'-'       { MINUS }
'*'       { MULT }
'='       { EQUAL }
'<>'      { NOTEQUAL }
'<'       { LTHAN }
'<='      { LTHANEQUAL }
'>'       { GTHAN }
'>='      { GTHANEQUAL }
'div'     { DIV }
'mod'     { MOD }
':='      { ATT }

-- OPERATOR PRECEDENCE: 

%nonassoc '=' '<>' '<' '<=' '>' '>='        
%left '+' '-'                                
%left '*' 'div' 'mod'
%left 'not'
-- The further down, the higher is the precedence. Example: '*' 'div' before '+' '-'.
%%

-- Programs

Program : ProgramHeader ProgramBody '.'          { Program $1 $2 }

ProgramHeader : program ident ';'                { ProgramHeader $2 }

ProgramBody : ConstDecls ProcDecls VarDecls CompoundStm     { ProgramBody $1 $2 $3 $4 }

ProcDecls : ProcDeclsSeq                         { ProcDecls $1 }
          | {-empty-}                            { ProcDeclsEmpty }

ProcDeclsSeq : Proc ProcDeclsSeq                 { $1 : $2 }
             | Proc                              { [$1] }

-- Procedures and Functions

Proc : ProcHeader ProcBody ';'                                      { Proc $1 $2 }

ProcHeader : procedure ident '(' ParamList ')' ';'                  { Procedure $2 $4 }
           | function ident '(' ParamList ')' ':' BasicType ';'     { Function $2 $4 $7 }

ProcBody : VarDecls CompoundStm                                     { ProcBody $1 $2 }

ParamList : ParamList1                                              { ParamList $1 }
          | {-empty-}                                               { NoParam }

ParamList1 : Param ';' ParamList1                                   { $1 : $3 }
           | Param                                                  { [$1] }

Param : ident ':' Type                                              { Param $1 $3 }

-- Statements

Stm : AssignStm                     { $1 }
    | if Expr then Stm              { IfThen $2 $4 }
    | if Expr then Stm else Stm     { IfThenElse $2 $4 $6 }
    | WhileStm                      { $1 }
    | ForStm                        { $1 }
    | BreakStm                      { $1 }   
    | ProcStm                       { $1 }
    | CompoundStm                   { $1 }
--     | IOStm                         { IOStm $1 }

AssignStm : VarAccess ':=' Expr                 { AssignStm $1 $3 }

WhileStm : while Expr do Stm                    { WhileStm $2 $4 } 

ForStm : for ident ':=' Expr to Expr do Stm     { ForStm $2 $4 $6 $8}

BreakStm : break                                { BreakStm }

ProcStm : ident '(' ExprList ')'                { ProcStm $1 $3 }

CompoundStm : begin StmList end                 { CompoundStm $2 }

StmList : Stm ';' StmList                       { $1 : $3 }
        | Stm                                   { [$1] }

-- Expressions

Expr : num                        { Num $1 }
     | str                        { Str $1 }
     | true                       { ValueTrue }
     | false                      { ValueFalse }
     | VarAccess                  { VarAccess $1 }
     | Expr BinOp Expr            { BinOp $1 $2 $3 }
     | Expr RelOp Expr            { RelOp $1 $2 $3 }
     | '-' Expr                   { Neg $2 }
     | not Expr                   { Not $2 }
     | '(' Expr ')'               { $2 }
     | ident '(' ExprList ')'     { ExprList $1 $3 }
--      | readint'('')'              { ReadInt } 

VarAccess : ident                 { Var $1 }
         | ident '[' Expr ']'     { Array $1 $3 }

BinOp : '+'                       { Plus }
      | '-'                       { Minus }
      | '*'                       { Mult }
      | 'div'                     { Div }
      | 'mod'                     { Mod }

RelOp : '='                       { Equal }
      | '<>'                      { NotEqual }
      | '<'                       { LThan }
      | '>'                       { GThan }
      | '<='                      { LThanEqual }
      | '>='                      { GThanEqual }
      | and                       { And }
      | or                        { Or }

ExprList : ExprList1              { $1 }
         | {-empty-}              { [] }

ExprList1 : Expr ',' ExprList1    { $1 : $3 }
          | Expr                  { [$1] }

-- Declarations

ConstDecls : const ConstDefSeq     { ConstDecls $2 }
           | {-empty-}             { NoConstDecl }

VarDecls : var VarDefSeq           { VarDecls $2 }
         | {- empty-}              { NoVarDecl }

ConstDef : ident '=' num ';'       { ConstDef $1 $3 }

ConstDefSeq : ConstDef ConstDefSeq     { $1 : $2 }
            | ConstDef                 { [$1] }

VarDefSeq : VarDef VarDefSeq     { $1 : $2 }
          | VarDef               { [$1] }

Type : BasicType                 { $1 }
     | ArrayType                 { $1 }

VarDef : ident ':' Type ';'      { VarDef $1 $3 }

BasicType : integer              { TypeInteger } 
          | boolean              { TypeBoolean } 
          | string               { TypeString  }

ArrayType : array '['Constant '.''.' Constant']' of BasicType { TypeArray $3 $6 $9 }

Constant : num                   { Numeral $1 }
         | ident                 { Identifier $1 }

-- -- I/O Library

-- IOStm : writeint'('Expr')'       { WriteInt $3 }
--       | writestr'('str')'        { WriteStr $3 } 

{

parseError :: [Token] -> a
parseError toks = error ("parse error at" ++ show toks)

}
