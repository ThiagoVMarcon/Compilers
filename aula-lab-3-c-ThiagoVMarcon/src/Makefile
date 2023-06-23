
parser : lexer.x parser.c main.c
	flex lexer.x
	gcc -o parser parser.c lex.yy.c main.c
