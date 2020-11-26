%{
#include "y.tab.h"
#include "parser.h"
#include <math.h>
#include <stdio.h>

%}
ws [ \t]+
nl (\n|\r\n|\r)
qstring \"[^\"\n]*[\"\n"]
%%
([0-9]+) {
    
    yylval.string = strdup(yytext);
  
    return INTEGER;
}
([0-9]*\.[0-9]+)([eE][+-]?[0-9]+)? {
    yylval.string = strdup(yytext);
  
    return FLOAT;
}


if return IF;

[A-Za-z][A-Za-z0-9]*    { /* return symbol pointer */
    if(!strcmp(yytext,"if")){
        printf("LEXER: IF\n");
        return IF;
    }else if(!strcmp(yytext,"else")){
        printf("LEXER: ELSE\n");
        return ELSE;
    }else if(!strcmp(yytext,"while")){
        printf("LEXER: WHILE\n");
        return WHILE;
    }else if(!strcmp(yytext,"System")){
        printf("LEXER: SYSTEM_TOKEN\n");
        return SYSTEM_TOKEN;
    }else if(!strcmp(yytext,"Config")){
        printf("LEXER: CONFIG_TOKEN\n");
        return CONFIG_TOKEN;
    }else if(!strcmp(yytext,"num")){
        printf("LEXER: TYPE_NUM\n");
        return TYPE_NUM;
    }else if(!strcmp(yytext,"str")){
        printf("LEXER: TYPE_STR\n");
        return TYPE_STR;
    }else if(!strcmp(yytext,"bool")){
        printf("LEXER: TYPE_BOOL\n");
        return TYPE_BOOL;
    }else if(!strcmp(yytext,"true")){
        printf("LEXER: TRUE_TK\n");
        return TRUE_TK;
    }else if(!strcmp(yytext,"false")){
        printf("LEXER: FALSE_TK\n");
        return FALSE_TK;
    }else if(!strcmp(yytext,"addBody")){
        printf("LEXER: addBody\n");
        return ADDBODY;
    }else if(!strcmp(yytext,"print")){
        printf("LEXER: print\n");
        return PRINT;
    }else if(!strcmp(yytext,"gravityConstant")){
        printf("LEXER: gravityConstant\n");
        return GRAVITY_CONF;
    }else if(!strcmp(yytext,"worldBorderBounce")){
        printf("LEXER: worldBorderBounce\n");
        return BOUNCE_CONF;
    }else if(!strcmp(yytext,"main")){
        printf("LEXER: main\n");
        return MAIN;
    }else if(!strcmp(yytext,"readNum")){
        printf("LEXER: readNum\n");
        return READ_NUM;
    }else if(!strcmp(yytext,"readStr")){
        printf("LEXER: readStr\n");
        return READ_STR;
    }
    
    struct symtab* sym = symLook(yytext);
    yylval.symp = sym;
    printf("symlook: %s , %d\n",sym->name,sym->type);
    switch(sym->type){
        case NUM_TYPE:
            printf("LEXER: NUM_NAME\n");
            return NUM_NAME;
            break;
        case STR_TYPE:
            printf("LEXER: STR_NAME\n"); 
            return STR_NAME;
            break;
        case BOOL_TYPE:
            printf("LEXER: BOOL_NAME\n"); 
            return BOOL_NAME;
            break;
        case NUM_ARR_TYPE:
            printf("LEXER: NUM_ARR_NAME\n"); 
            return NUM_ARR_NAME;
            break;
        case STR_ARR_TYPE:
            printf("LEXER: STR_ARR_NAME\n");
            return STR_ARR_NAME;
            break;
        case BOOL_ARR_TYPE:
            printf("LEXER: BOOL_ARR_NAME\n");
            return BOOL_ARR_NAME;
            break;
        case NOT_DEFINED:
            printf("LEXER: NOT_DEFINED\n");
            return NAME;
        break;
        default:
            printf("LEXER: defaultn");
            break;
    }
 
     
}

{nl} ;
{ws} ; /* ignore whitespace */
"$" return 0; /* EOF when running in command line */


{qstring} {yylval.string = strdup(yytext);
         
            if(yylval.string[yyleng-1] != '"'){
                fprintf(stderr,"Unterminated character string\n");
            }else{
               
                return QSTRING;
            }
}

"=="    |
"!="    |
"<"     |
">"     |
"<="    |
">="    { 
    yylval.string = strdup(yytext);
  
    return COMPARATION;
}   


"&&" {return AND;}
"||"  {return OR;}
"!" {return NOT;}

[:(){},.;] {return yytext[0];}

.   return yytext[0];
%%


