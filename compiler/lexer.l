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

[A-Za-z][A-Za-z0-9]*    { /* return symbol pointer */
    if(!strcmp(yytext,"if")){
        return IF;
    }else if(!strcmp(yytext,"else")){
        return ELSE;
    }else if(!strcmp(yytext,"while")){
        return WHILE;
    }else if(!strcmp(yytext,"System")){
        return SYSTEM_TOKEN;
    }else if(!strcmp(yytext,"Config")){
        return CONFIG_TOKEN;
    }else if(!strcmp(yytext,"num")){
        return TYPE_NUM;
    }else if(!strcmp(yytext,"str")){
        return TYPE_STR;
    }else if(!strcmp(yytext,"bool")){
        return TYPE_BOOL;
    }else if(!strcmp(yytext,"true")){
        return TRUE_TK;
    }else if(!strcmp(yytext,"false")){
        return FALSE_TK;
    }else if(!strcmp(yytext,"addBody")){
        return ADDBODY;
    }else if(!strcmp(yytext,"print")){
        return PRINT;
    }else if(!strcmp(yytext,"gravityConstant")){
        return GRAVITY_CONF;
    }else if(!strcmp(yytext,"worldBorderBounce")){
        return BOUNCE_CONF;
    }else if(!strcmp(yytext,"main")){
        return MAIN;
    }else if(!strcmp(yytext,"readNum")){
        return READ_NUM;
    }else if(!strcmp(yytext,"readStr")){
        return READ_STR;
    }
    struct symtab* sym = symLook(yytext);
    yylval.symp = sym;
    switch(sym->type){
        case NUM_TYPE:
            return NUM_NAME;
        break;
        case STR_TYPE:
            return STR_NAME;
        break;
        case BOOL_TYPE:
            return BOOL_NAME;
        break;
        case NUM_ARR_TYPE:
            return NUM_ARR_NAME;
        break;
        case STR_ARR_TYPE:
            return STR_ARR_NAME;
        break;
        case BOOL_ARR_TYPE:
            return BOOL_ARR_NAME;
        break;
        case NOT_DEFINED:
            return NAME;
        break;
        default:
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


