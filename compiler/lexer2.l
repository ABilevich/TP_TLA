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


^[ \t]*"/*".*"*/"[ \t]*\n { printf("coment"); return COMMENT;}

([0-9]+) {
    yylval.string = strdup(yytext);
    return INTEGER;
}
([0-9]*\.[0-9]+)([eE][+-]?[0-9]+)? {
    yylval.string = strdup(yytext);
    return FLOAT;
}

if      {return IF;} 
else    {return ELSE;}
while   {return WHILE;}
System  {return SYSTEM_TOKEN;}
Config  {return CONFIG_TOKEN;}
num     {return TYPE_NUM;}
str     {return TYPE_STR;}
bool    {return TYPE_BOOL;}
true    {return TRUE_TK;}
false   {return FALSE_TK;}
addBody {return ADDBODY;}
print   {return PRINT;}
readStr {return READ_STR;}
readNum {return READ_NUM;}
gravityConstant     {return GRAVITY_CONF;}
worldBorderBounce   {return BOUNCE_CONF;}
enableBodyTrail     {return TRAIL_CONF;}
getHeigth           {return GET_HEIGHT;}
getWidth            {return GET_WIDTH;}
main    {return MAIN;}



[A-Za-z][A-Za-z0-9_]* {
    yylval.string = strdup(yytext);
    return NAME;
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


