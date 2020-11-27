DEBUG=FALSE
DEBUG_FLAGS = -fsanitize=address -g -DDEBUG_TRUE 
CFLAGS = -Wall -pedantic -std=c99 -Wextra -D_POSIX_C_SOURCE=200809L -std=c99 -Wno-unused-function


all: parser lexer link

parser: parser.y
	yacc -d -v parser.y

lexer: lexer.l
	lex lexer.l

link: lex.yy.c y.tab.c
ifeq ($(DEBUG),TRUE)
	gcc $(DEBUG_FLAGS) $(CFLAGS) -c lex.yy.c y.tab.c -lm
	gcc $(DEBUG_FLAGS) $(CFLAGS) -o compile lex.yy.o y.tab.o -ll -lm
else
	gcc $(CFLAGS) -c lex.yy.c y.tab.c -lm
	gcc $(CFLAGS) -o compile lex.yy.o y.tab.o -ll -lm
endif
	
clean:
	find . -type f | xargs touch
	rm -rf lex.yy.c y.tab.c y.tab.o lex.yy.o y.tab.h script.js index.html compile y.output

.PHONY: all clean