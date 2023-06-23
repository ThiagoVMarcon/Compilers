

calc : parser.y lexer.x main.c
	bison -d parser.y
	flex lexer.x
	gcc -o calc parser.tab.c lex.yy.c main.c -lm
