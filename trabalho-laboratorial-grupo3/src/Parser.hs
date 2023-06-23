{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import AST
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38 t39
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34
	| HappyAbsSyn35 t35
	| HappyAbsSyn36 t36
	| HappyAbsSyn37 t37
	| HappyAbsSyn38 t38
	| HappyAbsSyn39 t39

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,390) ([0,0,128,0,0,0,0,0,4,0,0,0,0,0,1,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,512,0,0,0,96,0,0,0,0,0,0,1024,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,1,0,0,0,0,0,0,4,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,2,0,0,0,0,2048,0,0,0,512,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,330,1680,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,16,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,64,0,0,0,0,0,16,0,0,0,49152,3,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,32768,3843,132,0,0,0,7168,8312,4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,16384,1,0,0,0,0,512,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,30748,1056,0,0,0,57344,960,33,0,0,0,1792,2078,1,0,0,0,0,0,32,0,0,12800,0,65504,0,0,0,0,0,0,0,0,0,57456,4225,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,1,0,0,0,0,512,0,0,0,0,15374,528,0,0,0,28672,33248,16,0,0,32768,96,49152,511,0,0,0,30748,1056,0,0,0,0,0,0,0,0,40960,20,105,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,2,0,0,0,49152,3,0,0,0,0,0,2,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,384,0,2047,0,0,0,57456,4225,0,0,0,32768,3843,132,0,0,32768,82,420,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,48,0,0,24576,0,65480,1,0,0,0,16384,0,0,0,0,49376,8451,0,0,0,0,0,0,0,0,0,165,840,0,0,0,0,33216,16903,0,0,0,32768,1,65408,7,0,0,3072,2048,16376,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,6144,0,32754,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,57456,4225,0,0,0,0,0,0,0,0,0,896,0,4094,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,512,0,0,0,18944,36865,6,0,0,0,0,0,0,0,0,0,7168,8312,4,0,0,0,0,0,0,0,0,51200,0,65408,3,0,0,0,0,0,0,0,0,32768,2,0,0,0,0,0,128,0,0,0,330,1680,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,7,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","ProgramHeader","ProgramBody","ProcDecls","ProcDeclsSeq","Proc","ProcHeader","ProcBody","ParamList","ParamList1","Param","Stm","AssignStm","WhileStm","ForStm","BreakStm","ProcStm","CompoundStm","StmList","Expr","VarAccess","BinOp","RelOp","ExprList","ExprList1","ConstDecls","VarDecls","ConstDef","ConstDefSeq","VarDefSeq","Type","VarDef","BasicType","ArrayType","Constant","IOStm","program","function","procedure","const","var","begin","end","if","then","else","while","do","for","to","and","or","not","true","false","integer","boolean","string","array","of","break","num","str","ident","readint","writeint","writestr","','","'.'","':'","';'","'('","')'","'['","']'","'+'","'-'","'*'","'='","'<>'","'<'","'<='","'>'","'>='","'div'","'mod'","':='","%eof"]
        bit_start = st Prelude.* 91
        bit_end = (st Prelude.+ 1) Prelude.* 91
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..90]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (40) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_2
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (40) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (43) = happyShift action_8
action_2 (6) = happyGoto action_6
action_2 (29) = happyGoto action_7
action_2 _ = happyReduce_66

action_3 (67) = happyShift action_5
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (91) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (74) = happyShift action_19
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (72) = happyShift action_18
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (41) = happyShift action_16
action_7 (42) = happyShift action_17
action_7 (7) = happyGoto action_12
action_7 (8) = happyGoto action_13
action_7 (9) = happyGoto action_14
action_7 (10) = happyGoto action_15
action_7 _ = happyReduce_5

action_8 (67) = happyShift action_11
action_8 (31) = happyGoto action_9
action_8 (32) = happyGoto action_10
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (67) = happyShift action_11
action_9 (31) = happyGoto action_9
action_9 (32) = happyGoto action_28
action_9 _ = happyReduce_71

action_10 _ = happyReduce_65

action_11 (82) = happyShift action_27
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (44) = happyShift action_24
action_12 (30) = happyGoto action_26
action_12 _ = happyReduce_68

action_13 _ = happyReduce_4

action_14 (41) = happyShift action_16
action_14 (42) = happyShift action_17
action_14 (8) = happyGoto action_25
action_14 (9) = happyGoto action_14
action_14 (10) = happyGoto action_15
action_14 _ = happyReduce_7

action_15 (44) = happyShift action_24
action_15 (11) = happyGoto action_22
action_15 (30) = happyGoto action_23
action_15 _ = happyReduce_68

action_16 (67) = happyShift action_21
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (67) = happyShift action_20
action_17 _ = happyFail (happyExpListPerState 17)

action_18 _ = happyReduce_1

action_19 _ = happyReduce_2

action_20 (75) = happyShift action_38
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (75) = happyShift action_37
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (74) = happyShift action_36
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (45) = happyShift action_31
action_23 (21) = happyGoto action_35
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (67) = happyShift action_34
action_24 (33) = happyGoto action_32
action_24 (35) = happyGoto action_33
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_6

action_26 (45) = happyShift action_31
action_26 (21) = happyGoto action_30
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (65) = happyShift action_29
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_70

action_29 (74) = happyShift action_63
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_3

action_31 (45) = happyShift action_31
action_31 (47) = happyShift action_56
action_31 (50) = happyShift action_57
action_31 (52) = happyShift action_58
action_31 (64) = happyShift action_59
action_31 (67) = happyShift action_60
action_31 (69) = happyShift action_61
action_31 (70) = happyShift action_62
action_31 (15) = happyGoto action_46
action_31 (16) = happyGoto action_47
action_31 (17) = happyGoto action_48
action_31 (18) = happyGoto action_49
action_31 (19) = happyGoto action_50
action_31 (20) = happyGoto action_51
action_31 (21) = happyGoto action_52
action_31 (22) = happyGoto action_53
action_31 (24) = happyGoto action_54
action_31 (39) = happyGoto action_55
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_67

action_33 (67) = happyShift action_34
action_33 (33) = happyGoto action_45
action_33 (35) = happyGoto action_33
action_33 _ = happyReduce_73

action_34 (73) = happyShift action_44
action_34 _ = happyFail (happyExpListPerState 34)

action_35 _ = happyReduce_11

action_36 _ = happyReduce_8

action_37 (67) = happyShift action_42
action_37 (12) = happyGoto action_43
action_37 (13) = happyGoto action_40
action_37 (14) = happyGoto action_41
action_37 _ = happyReduce_13

action_38 (67) = happyShift action_42
action_38 (12) = happyGoto action_39
action_38 (13) = happyGoto action_40
action_38 (14) = happyGoto action_41
action_38 _ = happyReduce_13

action_39 (76) = happyShift action_94
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_12

action_41 (74) = happyShift action_93
action_41 _ = happyReduce_15

action_42 (73) = happyShift action_92
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (76) = happyShift action_91
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (59) = happyShift action_87
action_44 (60) = happyShift action_88
action_44 (61) = happyShift action_89
action_44 (62) = happyShift action_90
action_44 (34) = happyGoto action_84
action_44 (36) = happyGoto action_85
action_44 (37) = happyGoto action_86
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_72

action_46 (74) = happyShift action_83
action_46 _ = happyReduce_33

action_47 _ = happyReduce_17

action_48 _ = happyReduce_20

action_49 _ = happyReduce_21

action_50 _ = happyReduce_22

action_51 _ = happyReduce_23

action_52 _ = happyReduce_24

action_53 (46) = happyShift action_82
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (90) = happyShift action_81
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_25

action_56 (56) = happyShift action_71
action_56 (57) = happyShift action_72
action_56 (58) = happyShift action_73
action_56 (65) = happyShift action_74
action_56 (66) = happyShift action_75
action_56 (67) = happyShift action_76
action_56 (68) = happyShift action_77
action_56 (75) = happyShift action_78
action_56 (80) = happyShift action_79
action_56 (23) = happyGoto action_80
action_56 (24) = happyGoto action_70
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (56) = happyShift action_71
action_57 (57) = happyShift action_72
action_57 (58) = happyShift action_73
action_57 (65) = happyShift action_74
action_57 (66) = happyShift action_75
action_57 (67) = happyShift action_76
action_57 (68) = happyShift action_77
action_57 (75) = happyShift action_78
action_57 (80) = happyShift action_79
action_57 (23) = happyGoto action_69
action_57 (24) = happyGoto action_70
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (67) = happyShift action_68
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_29

action_60 (75) = happyShift action_66
action_60 (77) = happyShift action_67
action_60 _ = happyReduce_46

action_61 (75) = happyShift action_65
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (75) = happyShift action_64
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_69

action_64 (66) = happyShift action_131
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (56) = happyShift action_71
action_65 (57) = happyShift action_72
action_65 (58) = happyShift action_73
action_65 (65) = happyShift action_74
action_65 (66) = happyShift action_75
action_65 (67) = happyShift action_76
action_65 (68) = happyShift action_77
action_65 (75) = happyShift action_78
action_65 (80) = happyShift action_79
action_65 (23) = happyGoto action_130
action_65 (24) = happyGoto action_70
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (56) = happyShift action_71
action_66 (57) = happyShift action_72
action_66 (58) = happyShift action_73
action_66 (65) = happyShift action_74
action_66 (66) = happyShift action_75
action_66 (67) = happyShift action_76
action_66 (68) = happyShift action_77
action_66 (75) = happyShift action_78
action_66 (80) = happyShift action_79
action_66 (23) = happyGoto action_127
action_66 (24) = happyGoto action_70
action_66 (27) = happyGoto action_128
action_66 (28) = happyGoto action_129
action_66 _ = happyReduce_62

action_67 (56) = happyShift action_71
action_67 (57) = happyShift action_72
action_67 (58) = happyShift action_73
action_67 (65) = happyShift action_74
action_67 (66) = happyShift action_75
action_67 (67) = happyShift action_76
action_67 (68) = happyShift action_77
action_67 (75) = happyShift action_78
action_67 (80) = happyShift action_79
action_67 (23) = happyGoto action_126
action_67 (24) = happyGoto action_70
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (90) = happyShift action_125
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (51) = happyShift action_124
action_69 (54) = happyShift action_106
action_69 (55) = happyShift action_107
action_69 (79) = happyShift action_108
action_69 (80) = happyShift action_109
action_69 (81) = happyShift action_110
action_69 (82) = happyShift action_111
action_69 (83) = happyShift action_112
action_69 (84) = happyShift action_113
action_69 (85) = happyShift action_114
action_69 (86) = happyShift action_115
action_69 (87) = happyShift action_116
action_69 (88) = happyShift action_117
action_69 (89) = happyShift action_118
action_69 (25) = happyGoto action_103
action_69 (26) = happyGoto action_104
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_38

action_71 (56) = happyShift action_71
action_71 (57) = happyShift action_72
action_71 (58) = happyShift action_73
action_71 (65) = happyShift action_74
action_71 (66) = happyShift action_75
action_71 (67) = happyShift action_76
action_71 (68) = happyShift action_77
action_71 (75) = happyShift action_78
action_71 (80) = happyShift action_79
action_71 (23) = happyGoto action_123
action_71 (24) = happyGoto action_70
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_36

action_73 _ = happyReduce_37

action_74 _ = happyReduce_34

action_75 _ = happyReduce_35

action_76 (75) = happyShift action_122
action_76 (77) = happyShift action_67
action_76 _ = happyReduce_46

action_77 (75) = happyShift action_121
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (56) = happyShift action_71
action_78 (57) = happyShift action_72
action_78 (58) = happyShift action_73
action_78 (65) = happyShift action_74
action_78 (66) = happyShift action_75
action_78 (67) = happyShift action_76
action_78 (68) = happyShift action_77
action_78 (75) = happyShift action_78
action_78 (80) = happyShift action_79
action_78 (23) = happyGoto action_120
action_78 (24) = happyGoto action_70
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (56) = happyShift action_71
action_79 (57) = happyShift action_72
action_79 (58) = happyShift action_73
action_79 (65) = happyShift action_74
action_79 (66) = happyShift action_75
action_79 (67) = happyShift action_76
action_79 (68) = happyShift action_77
action_79 (75) = happyShift action_78
action_79 (80) = happyShift action_79
action_79 (23) = happyGoto action_119
action_79 (24) = happyGoto action_70
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (48) = happyShift action_105
action_80 (54) = happyShift action_106
action_80 (55) = happyShift action_107
action_80 (79) = happyShift action_108
action_80 (80) = happyShift action_109
action_80 (81) = happyShift action_110
action_80 (82) = happyShift action_111
action_80 (83) = happyShift action_112
action_80 (84) = happyShift action_113
action_80 (85) = happyShift action_114
action_80 (86) = happyShift action_115
action_80 (87) = happyShift action_116
action_80 (88) = happyShift action_117
action_80 (89) = happyShift action_118
action_80 (25) = happyGoto action_103
action_80 (26) = happyGoto action_104
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (56) = happyShift action_71
action_81 (57) = happyShift action_72
action_81 (58) = happyShift action_73
action_81 (65) = happyShift action_74
action_81 (66) = happyShift action_75
action_81 (67) = happyShift action_76
action_81 (68) = happyShift action_77
action_81 (75) = happyShift action_78
action_81 (80) = happyShift action_79
action_81 (23) = happyGoto action_102
action_81 (24) = happyGoto action_70
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_31

action_83 (45) = happyShift action_31
action_83 (47) = happyShift action_56
action_83 (50) = happyShift action_57
action_83 (52) = happyShift action_58
action_83 (64) = happyShift action_59
action_83 (67) = happyShift action_60
action_83 (69) = happyShift action_61
action_83 (70) = happyShift action_62
action_83 (15) = happyGoto action_46
action_83 (16) = happyGoto action_47
action_83 (17) = happyGoto action_48
action_83 (18) = happyGoto action_49
action_83 (19) = happyGoto action_50
action_83 (20) = happyGoto action_51
action_83 (21) = happyGoto action_52
action_83 (22) = happyGoto action_101
action_83 (24) = happyGoto action_54
action_83 (39) = happyGoto action_55
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (74) = happyShift action_100
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_74

action_86 _ = happyReduce_75

action_87 _ = happyReduce_77

action_88 _ = happyReduce_78

action_89 _ = happyReduce_79

action_90 (77) = happyShift action_99
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (73) = happyShift action_98
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (59) = happyShift action_87
action_92 (60) = happyShift action_88
action_92 (61) = happyShift action_89
action_92 (62) = happyShift action_90
action_92 (34) = happyGoto action_97
action_92 (36) = happyGoto action_85
action_92 (37) = happyGoto action_86
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (67) = happyShift action_42
action_93 (13) = happyGoto action_96
action_93 (14) = happyGoto action_41
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (74) = happyShift action_95
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_9

action_96 _ = happyReduce_14

action_97 _ = happyReduce_16

action_98 (59) = happyShift action_87
action_98 (60) = happyShift action_88
action_98 (61) = happyShift action_89
action_98 (36) = happyGoto action_148
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (65) = happyShift action_146
action_99 (67) = happyShift action_147
action_99 (38) = happyGoto action_145
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_76

action_101 _ = happyReduce_32

action_102 (54) = happyShift action_106
action_102 (55) = happyShift action_107
action_102 (79) = happyShift action_108
action_102 (80) = happyShift action_109
action_102 (81) = happyShift action_110
action_102 (82) = happyShift action_111
action_102 (83) = happyShift action_112
action_102 (84) = happyShift action_113
action_102 (85) = happyShift action_114
action_102 (86) = happyShift action_115
action_102 (87) = happyShift action_116
action_102 (88) = happyShift action_117
action_102 (89) = happyShift action_118
action_102 (25) = happyGoto action_103
action_102 (26) = happyGoto action_104
action_102 _ = happyReduce_26

action_103 (56) = happyShift action_71
action_103 (57) = happyShift action_72
action_103 (58) = happyShift action_73
action_103 (65) = happyShift action_74
action_103 (66) = happyShift action_75
action_103 (67) = happyShift action_76
action_103 (68) = happyShift action_77
action_103 (75) = happyShift action_78
action_103 (80) = happyShift action_79
action_103 (23) = happyGoto action_144
action_103 (24) = happyGoto action_70
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (56) = happyShift action_71
action_104 (57) = happyShift action_72
action_104 (58) = happyShift action_73
action_104 (65) = happyShift action_74
action_104 (66) = happyShift action_75
action_104 (67) = happyShift action_76
action_104 (68) = happyShift action_77
action_104 (75) = happyShift action_78
action_104 (80) = happyShift action_79
action_104 (23) = happyGoto action_143
action_104 (24) = happyGoto action_70
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (45) = happyShift action_31
action_105 (47) = happyShift action_56
action_105 (50) = happyShift action_57
action_105 (52) = happyShift action_58
action_105 (64) = happyShift action_59
action_105 (67) = happyShift action_60
action_105 (69) = happyShift action_61
action_105 (70) = happyShift action_62
action_105 (15) = happyGoto action_142
action_105 (16) = happyGoto action_47
action_105 (17) = happyGoto action_48
action_105 (18) = happyGoto action_49
action_105 (19) = happyGoto action_50
action_105 (20) = happyGoto action_51
action_105 (21) = happyGoto action_52
action_105 (24) = happyGoto action_54
action_105 (39) = happyGoto action_55
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_59

action_107 _ = happyReduce_60

action_108 _ = happyReduce_48

action_109 _ = happyReduce_49

action_110 _ = happyReduce_50

action_111 _ = happyReduce_53

action_112 _ = happyReduce_54

action_113 _ = happyReduce_55

action_114 _ = happyReduce_57

action_115 _ = happyReduce_56

action_116 _ = happyReduce_58

action_117 _ = happyReduce_51

action_118 _ = happyReduce_52

action_119 (54) = happyShift action_106
action_119 (55) = happyShift action_107
action_119 (81) = happyShift action_110
action_119 (88) = happyShift action_117
action_119 (89) = happyShift action_118
action_119 (25) = happyGoto action_103
action_119 (26) = happyGoto action_104
action_119 _ = happyReduce_41

action_120 (54) = happyShift action_106
action_120 (55) = happyShift action_107
action_120 (76) = happyShift action_141
action_120 (79) = happyShift action_108
action_120 (80) = happyShift action_109
action_120 (81) = happyShift action_110
action_120 (82) = happyShift action_111
action_120 (83) = happyShift action_112
action_120 (84) = happyShift action_113
action_120 (85) = happyShift action_114
action_120 (86) = happyShift action_115
action_120 (87) = happyShift action_116
action_120 (88) = happyShift action_117
action_120 (89) = happyShift action_118
action_120 (25) = happyGoto action_103
action_120 (26) = happyGoto action_104
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (76) = happyShift action_140
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (56) = happyShift action_71
action_122 (57) = happyShift action_72
action_122 (58) = happyShift action_73
action_122 (65) = happyShift action_74
action_122 (66) = happyShift action_75
action_122 (67) = happyShift action_76
action_122 (68) = happyShift action_77
action_122 (75) = happyShift action_78
action_122 (80) = happyShift action_79
action_122 (23) = happyGoto action_127
action_122 (24) = happyGoto action_70
action_122 (27) = happyGoto action_139
action_122 (28) = happyGoto action_129
action_122 _ = happyReduce_62

action_123 (54) = happyShift action_106
action_123 (55) = happyShift action_107
action_123 (79) = happyShift action_108
action_123 (80) = happyShift action_109
action_123 (81) = happyShift action_110
action_123 (82) = happyShift action_111
action_123 (83) = happyShift action_112
action_123 (84) = happyShift action_113
action_123 (85) = happyShift action_114
action_123 (86) = happyShift action_115
action_123 (87) = happyShift action_116
action_123 (88) = happyShift action_117
action_123 (89) = happyShift action_118
action_123 (25) = happyGoto action_103
action_123 (26) = happyGoto action_104
action_123 _ = happyReduce_42

action_124 (45) = happyShift action_31
action_124 (47) = happyShift action_56
action_124 (50) = happyShift action_57
action_124 (52) = happyShift action_58
action_124 (64) = happyShift action_59
action_124 (67) = happyShift action_60
action_124 (69) = happyShift action_61
action_124 (70) = happyShift action_62
action_124 (15) = happyGoto action_138
action_124 (16) = happyGoto action_47
action_124 (17) = happyGoto action_48
action_124 (18) = happyGoto action_49
action_124 (19) = happyGoto action_50
action_124 (20) = happyGoto action_51
action_124 (21) = happyGoto action_52
action_124 (24) = happyGoto action_54
action_124 (39) = happyGoto action_55
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (56) = happyShift action_71
action_125 (57) = happyShift action_72
action_125 (58) = happyShift action_73
action_125 (65) = happyShift action_74
action_125 (66) = happyShift action_75
action_125 (67) = happyShift action_76
action_125 (68) = happyShift action_77
action_125 (75) = happyShift action_78
action_125 (80) = happyShift action_79
action_125 (23) = happyGoto action_137
action_125 (24) = happyGoto action_70
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (54) = happyShift action_106
action_126 (55) = happyShift action_107
action_126 (78) = happyShift action_136
action_126 (79) = happyShift action_108
action_126 (80) = happyShift action_109
action_126 (81) = happyShift action_110
action_126 (82) = happyShift action_111
action_126 (83) = happyShift action_112
action_126 (84) = happyShift action_113
action_126 (85) = happyShift action_114
action_126 (86) = happyShift action_115
action_126 (87) = happyShift action_116
action_126 (88) = happyShift action_117
action_126 (89) = happyShift action_118
action_126 (25) = happyGoto action_103
action_126 (26) = happyGoto action_104
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (54) = happyShift action_106
action_127 (55) = happyShift action_107
action_127 (71) = happyShift action_135
action_127 (79) = happyShift action_108
action_127 (80) = happyShift action_109
action_127 (81) = happyShift action_110
action_127 (82) = happyShift action_111
action_127 (83) = happyShift action_112
action_127 (84) = happyShift action_113
action_127 (85) = happyShift action_114
action_127 (86) = happyShift action_115
action_127 (87) = happyShift action_116
action_127 (88) = happyShift action_117
action_127 (89) = happyShift action_118
action_127 (25) = happyGoto action_103
action_127 (26) = happyGoto action_104
action_127 _ = happyReduce_64

action_128 (76) = happyShift action_134
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_61

action_130 (54) = happyShift action_106
action_130 (55) = happyShift action_107
action_130 (76) = happyShift action_133
action_130 (79) = happyShift action_108
action_130 (80) = happyShift action_109
action_130 (81) = happyShift action_110
action_130 (82) = happyShift action_111
action_130 (83) = happyShift action_112
action_130 (84) = happyShift action_113
action_130 (85) = happyShift action_114
action_130 (86) = happyShift action_115
action_130 (87) = happyShift action_116
action_130 (88) = happyShift action_117
action_130 (89) = happyShift action_118
action_130 (25) = happyGoto action_103
action_130 (26) = happyGoto action_104
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (76) = happyShift action_132
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_84

action_133 _ = happyReduce_83

action_134 _ = happyReduce_30

action_135 (56) = happyShift action_71
action_135 (57) = happyShift action_72
action_135 (58) = happyShift action_73
action_135 (65) = happyShift action_74
action_135 (66) = happyShift action_75
action_135 (67) = happyShift action_76
action_135 (68) = happyShift action_77
action_135 (75) = happyShift action_78
action_135 (80) = happyShift action_79
action_135 (23) = happyGoto action_127
action_135 (24) = happyGoto action_70
action_135 (28) = happyGoto action_154
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_47

action_137 (53) = happyShift action_153
action_137 (54) = happyShift action_106
action_137 (55) = happyShift action_107
action_137 (79) = happyShift action_108
action_137 (80) = happyShift action_109
action_137 (81) = happyShift action_110
action_137 (82) = happyShift action_111
action_137 (83) = happyShift action_112
action_137 (84) = happyShift action_113
action_137 (85) = happyShift action_114
action_137 (86) = happyShift action_115
action_137 (87) = happyShift action_116
action_137 (88) = happyShift action_117
action_137 (89) = happyShift action_118
action_137 (25) = happyGoto action_103
action_137 (26) = happyGoto action_104
action_137 _ = happyFail (happyExpListPerState 137)

action_138 _ = happyReduce_27

action_139 (76) = happyShift action_152
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_45

action_141 _ = happyReduce_43

action_142 (49) = happyShift action_151
action_142 _ = happyReduce_18

action_143 (54) = happyShift action_106
action_143 (55) = happyShift action_107
action_143 (79) = happyShift action_108
action_143 (80) = happyShift action_109
action_143 (81) = happyShift action_110
action_143 (82) = happyShift action_111
action_143 (83) = happyShift action_112
action_143 (84) = happyShift action_113
action_143 (85) = happyShift action_114
action_143 (86) = happyShift action_115
action_143 (87) = happyShift action_116
action_143 (88) = happyShift action_117
action_143 (89) = happyShift action_118
action_143 (25) = happyGoto action_103
action_143 (26) = happyGoto action_104
action_143 _ = happyReduce_40

action_144 (54) = happyShift action_106
action_144 (55) = happyShift action_107
action_144 (79) = happyShift action_108
action_144 (80) = happyShift action_109
action_144 (81) = happyShift action_110
action_144 (82) = happyShift action_111
action_144 (83) = happyShift action_112
action_144 (84) = happyShift action_113
action_144 (85) = happyShift action_114
action_144 (86) = happyShift action_115
action_144 (87) = happyShift action_116
action_144 (88) = happyShift action_117
action_144 (89) = happyShift action_118
action_144 (25) = happyGoto action_103
action_144 (26) = happyGoto action_104
action_144 _ = happyReduce_39

action_145 (72) = happyShift action_150
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_81

action_147 _ = happyReduce_82

action_148 (74) = happyShift action_149
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_10

action_150 (72) = happyShift action_157
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (45) = happyShift action_31
action_151 (47) = happyShift action_56
action_151 (50) = happyShift action_57
action_151 (52) = happyShift action_58
action_151 (64) = happyShift action_59
action_151 (67) = happyShift action_60
action_151 (69) = happyShift action_61
action_151 (70) = happyShift action_62
action_151 (15) = happyGoto action_156
action_151 (16) = happyGoto action_47
action_151 (17) = happyGoto action_48
action_151 (18) = happyGoto action_49
action_151 (19) = happyGoto action_50
action_151 (20) = happyGoto action_51
action_151 (21) = happyGoto action_52
action_151 (24) = happyGoto action_54
action_151 (39) = happyGoto action_55
action_151 _ = happyFail (happyExpListPerState 151)

action_152 _ = happyReduce_44

action_153 (56) = happyShift action_71
action_153 (57) = happyShift action_72
action_153 (58) = happyShift action_73
action_153 (65) = happyShift action_74
action_153 (66) = happyShift action_75
action_153 (67) = happyShift action_76
action_153 (68) = happyShift action_77
action_153 (75) = happyShift action_78
action_153 (80) = happyShift action_79
action_153 (23) = happyGoto action_155
action_153 (24) = happyGoto action_70
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_63

action_155 (51) = happyShift action_159
action_155 (54) = happyShift action_106
action_155 (55) = happyShift action_107
action_155 (79) = happyShift action_108
action_155 (80) = happyShift action_109
action_155 (81) = happyShift action_110
action_155 (82) = happyShift action_111
action_155 (83) = happyShift action_112
action_155 (84) = happyShift action_113
action_155 (85) = happyShift action_114
action_155 (86) = happyShift action_115
action_155 (87) = happyShift action_116
action_155 (88) = happyShift action_117
action_155 (89) = happyShift action_118
action_155 (25) = happyGoto action_103
action_155 (26) = happyGoto action_104
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_19

action_157 (65) = happyShift action_146
action_157 (67) = happyShift action_147
action_157 (38) = happyGoto action_158
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (78) = happyShift action_161
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (45) = happyShift action_31
action_159 (47) = happyShift action_56
action_159 (50) = happyShift action_57
action_159 (52) = happyShift action_58
action_159 (64) = happyShift action_59
action_159 (67) = happyShift action_60
action_159 (69) = happyShift action_61
action_159 (70) = happyShift action_62
action_159 (15) = happyGoto action_160
action_159 (16) = happyGoto action_47
action_159 (17) = happyGoto action_48
action_159 (18) = happyGoto action_49
action_159 (19) = happyGoto action_50
action_159 (20) = happyGoto action_51
action_159 (21) = happyGoto action_52
action_159 (24) = happyGoto action_54
action_159 (39) = happyGoto action_55
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_28

action_161 (63) = happyShift action_162
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (59) = happyShift action_87
action_162 (60) = happyShift action_88
action_162 (61) = happyShift action_89
action_162 (36) = happyGoto action_163
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_80

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Program happy_var_1 happy_var_2
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  5 happyReduction_2
happyReduction_2 _
	(HappyTerminal (ID happy_var_2))
	_
	 =  HappyAbsSyn5
		 (ProgramHeader happy_var_2
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 4 6 happyReduction_3
happyReduction_3 ((HappyAbsSyn21  happy_var_4) `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyAbsSyn29  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ProgramBody happy_var_1 happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (ProcDecls happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_0  7 happyReduction_5
happyReduction_5  =  HappyAbsSyn7
		 (ProcDeclsEmpty
	)

happyReduce_6 = happySpecReduce_2  8 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  8 happyReduction_7
happyReduction_7 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  9 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (Proc happy_var_1 happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happyReduce 6 10 happyReduction_9
happyReduction_9 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Procedure happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 8 10 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn36  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Function happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_2  11 happyReduction_11
happyReduction_11 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn11
		 (ProcBody happy_var_1 happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  12 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (ParamList happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  12 happyReduction_13
happyReduction_13  =  HappyAbsSyn12
		 (NoParam
	)

happyReduce_14 = happySpecReduce_3  13 happyReduction_14
happyReduction_14 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  13 happyReduction_15
happyReduction_15 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  14 happyReduction_16
happyReduction_16 (HappyAbsSyn34  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn14
		 (Param happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  15 happyReduction_17
happyReduction_17 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 4 15 happyReduction_18
happyReduction_18 ((HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (IfThen happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 6 15 happyReduction_19
happyReduction_19 ((HappyAbsSyn15  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (IfThenElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_1  15 happyReduction_20
happyReduction_20 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  15 happyReduction_21
happyReduction_21 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  15 happyReduction_22
happyReduction_22 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  15 happyReduction_23
happyReduction_23 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  15 happyReduction_24
happyReduction_24 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn39  happy_var_1)
	 =  HappyAbsSyn15
		 (IOStm happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  16 happyReduction_26
happyReduction_26 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn16
		 (AssignStm happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 4 17 happyReduction_27
happyReduction_27 ((HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (WhileStm happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 8 18 happyReduction_28
happyReduction_28 ((HappyAbsSyn15  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (ForStm happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_1  19 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn19
		 (BreakStm
	)

happyReduce_30 = happyReduce 4 20 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (ProcStm happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_3  21 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (CompoundStm happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  22 happyReduction_32
happyReduction_32 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 : happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  22 happyReduction_33
happyReduction_33 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn22
		 ([happy_var_1]
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  23 happyReduction_34
happyReduction_34 (HappyTerminal (NUM happy_var_1))
	 =  HappyAbsSyn23
		 (Num happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  23 happyReduction_35
happyReduction_35 (HappyTerminal (STR happy_var_1))
	 =  HappyAbsSyn23
		 (Str happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  23 happyReduction_36
happyReduction_36 _
	 =  HappyAbsSyn23
		 (ValueTrue
	)

happyReduce_37 = happySpecReduce_1  23 happyReduction_37
happyReduction_37 _
	 =  HappyAbsSyn23
		 (ValueFalse
	)

happyReduce_38 = happySpecReduce_1  23 happyReduction_38
happyReduction_38 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (VarAccess happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  23 happyReduction_39
happyReduction_39 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (BinOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  23 happyReduction_40
happyReduction_40 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (RelOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  23 happyReduction_41
happyReduction_41 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Neg happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  23 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Not happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  23 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 23 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (ExprList happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_3  23 happyReduction_45
happyReduction_45 _
	_
	_
	 =  HappyAbsSyn23
		 (ReadInt
	)

happyReduce_46 = happySpecReduce_1  24 happyReduction_46
happyReduction_46 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn24
		 (Var happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happyReduce 4 24 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Array happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_48 = happySpecReduce_1  25 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn25
		 (Plus
	)

happyReduce_49 = happySpecReduce_1  25 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn25
		 (Minus
	)

happyReduce_50 = happySpecReduce_1  25 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn25
		 (Mult
	)

happyReduce_51 = happySpecReduce_1  25 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn25
		 (Div
	)

happyReduce_52 = happySpecReduce_1  25 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn25
		 (Mod
	)

happyReduce_53 = happySpecReduce_1  26 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn26
		 (Equal
	)

happyReduce_54 = happySpecReduce_1  26 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn26
		 (NotEqual
	)

happyReduce_55 = happySpecReduce_1  26 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn26
		 (LThan
	)

happyReduce_56 = happySpecReduce_1  26 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn26
		 (GThan
	)

happyReduce_57 = happySpecReduce_1  26 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn26
		 (LThanEqual
	)

happyReduce_58 = happySpecReduce_1  26 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn26
		 (GThanEqual
	)

happyReduce_59 = happySpecReduce_1  26 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn26
		 (And
	)

happyReduce_60 = happySpecReduce_1  26 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn26
		 (Or
	)

happyReduce_61 = happySpecReduce_1  27 happyReduction_61
happyReduction_61 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_0  27 happyReduction_62
happyReduction_62  =  HappyAbsSyn27
		 ([]
	)

happyReduce_63 = happySpecReduce_3  28 happyReduction_63
happyReduction_63 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1 : happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  28 happyReduction_64
happyReduction_64 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn28
		 ([happy_var_1]
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  29 happyReduction_65
happyReduction_65 (HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (ConstDecls happy_var_2
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_0  29 happyReduction_66
happyReduction_66  =  HappyAbsSyn29
		 (NoConstDecl
	)

happyReduce_67 = happySpecReduce_2  30 happyReduction_67
happyReduction_67 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (VarDecls happy_var_2
	)
happyReduction_67 _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_0  30 happyReduction_68
happyReduction_68  =  HappyAbsSyn30
		 (NoVarDecl
	)

happyReduce_69 = happyReduce 4 31 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyTerminal (NUM happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn31
		 (ConstDef happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_2  32 happyReduction_70
happyReduction_70 (HappyAbsSyn32  happy_var_2)
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 : happy_var_2
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  32 happyReduction_71
happyReduction_71 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ([happy_var_1]
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_2  33 happyReduction_72
happyReduction_72 (HappyAbsSyn33  happy_var_2)
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1 : happy_var_2
	)
happyReduction_72 _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  33 happyReduction_73
happyReduction_73 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn33
		 ([happy_var_1]
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  34 happyReduction_74
happyReduction_74 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  34 happyReduction_75
happyReduction_75 (HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happyReduce 4 35 happyReduction_76
happyReduction_76 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (VarDef happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_77 = happySpecReduce_1  36 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn36
		 (TypeInteger
	)

happyReduce_78 = happySpecReduce_1  36 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn36
		 (TypeBoolean
	)

happyReduce_79 = happySpecReduce_1  36 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn36
		 (TypeString
	)

happyReduce_80 = happyReduce 9 37 happyReduction_80
happyReduction_80 ((HappyAbsSyn36  happy_var_9) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn37
		 (TypeArray happy_var_3 happy_var_6 happy_var_9
	) `HappyStk` happyRest

happyReduce_81 = happySpecReduce_1  38 happyReduction_81
happyReduction_81 (HappyTerminal (NUM happy_var_1))
	 =  HappyAbsSyn38
		 (Numeral happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  38 happyReduction_82
happyReduction_82 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn38
		 (Identifier happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happyReduce 4 39 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (WriteInt happy_var_3
	) `HappyStk` happyRest

happyReduce_84 = happyReduce 4 39 happyReduction_84
happyReduction_84 (_ `HappyStk`
	(HappyTerminal (STR happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn39
		 (WriteStr happy_var_3
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 91 91 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PROGRAM -> cont 40;
	FUNCTION -> cont 41;
	PROCEDURE -> cont 42;
	CONST -> cont 43;
	VAR -> cont 44;
	BEGIN -> cont 45;
	END -> cont 46;
	IF -> cont 47;
	THEN -> cont 48;
	ELSE -> cont 49;
	WHILE -> cont 50;
	DO -> cont 51;
	FOR -> cont 52;
	TO -> cont 53;
	AND -> cont 54;
	OR -> cont 55;
	NOT -> cont 56;
	TRUE -> cont 57;
	FALSE -> cont 58;
	INTEGER -> cont 59;
	BOOLEAN -> cont 60;
	STRING -> cont 61;
	ARRAY -> cont 62;
	OF -> cont 63;
	BREAK -> cont 64;
	NUM happy_dollar_dollar -> cont 65;
	STR happy_dollar_dollar -> cont 66;
	ID happy_dollar_dollar -> cont 67;
	READINT -> cont 68;
	WRITEINT -> cont 69;
	WRITESTR -> cont 70;
	COMMA -> cont 71;
	PERIOD -> cont 72;
	COLON -> cont 73;
	SEMICOLON -> cont 74;
	LPAREN -> cont 75;
	RPAREN -> cont 76;
	LBRACK -> cont 77;
	RBRACK -> cont 78;
	PLUS -> cont 79;
	MINUS -> cont 80;
	MULT -> cont 81;
	EQUAL -> cont 82;
	NOTEQUAL -> cont 83;
	LTHAN -> cont 84;
	LTHANEQUAL -> cont 85;
	GTHAN -> cont 86;
	GTHANEQUAL -> cont 87;
	DIV -> cont 88;
	MOD -> cont 89;
	ATT -> cont 90;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 91 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError toks = error ("parse error at" ++ show toks)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
