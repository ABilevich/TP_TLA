DEBUG=FALSE

all: parser lexer link

parser: parser2.y
	yacc -d  -v parser2.y

lexer: lexer.l
	lex lexer.l

link: lex.yy.c y.tab.c
	gcc -DDEBUG_$(DEBUG) -Wall -c lex.yy.c y.tab.c -lm
	gcc  -Wall -o compile lex.yy.o y.tab.o -ll -lm
	
clean:
	find . -type f | xargs touch
	rm -rf lex.yy.c y.tab.c y.tab.o lex.yy.o y.tab.h script.js index.html compile y.output

.PHONY: all clean