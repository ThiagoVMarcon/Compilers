
SRC = ast.c table.c interpret.c tests.c ast.h table.h interpret.h

OBJS= ast.o table.o interpret.o tests.o 

%.o : %.c %.h
	gcc -c -g $< 

runtests : $(OBJS) $(SRC)
	gcc -g -o runtests $(OBJS)
