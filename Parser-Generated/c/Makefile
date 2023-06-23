#
# Example Makefile to compile a Bison & Flex executable
# Pedro Vasconcelos, 2021
#
# Usage:
#   "make" to build
#   "make clean" to clean intermediate files
#

all: example

parser.tab.c parser.tab.h:	parser.y
	bison -t -v -d parser.y

lex.yy.c: lexer.x parser.tab.h
	flex lexer.x

example: main.c lex.yy.c parser.tab.c parser.tab.h
	gcc -o example main.c parser.tab.c lex.yy.c

clean:
	rm -f example parser.tab.c lex.yy.c parser.tab.h parser.output
