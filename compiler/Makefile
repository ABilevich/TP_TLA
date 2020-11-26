DEBUG=FALSE
DEBUG_FLAGS = -fsanitize=address -g -DDEBUG_TRUE
CFLAGS = -Wall -Wextra

all: parser lexer link

parser: parser2.y
	yacc -d -v parser2.y

lexer: lexer2.l
	lex lexer2.l

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