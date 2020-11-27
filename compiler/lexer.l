%{
#include "y.tab.h"
#include <math.h>
#include <stdio.h>
%}

ws [ \t]+
nl (\n|\r\n|\r)
qstring \"[^\"\n]*[\"\n"]

%%

 /*  ------------------ REGEX PARA NUMEROS -------------------  */
([0-9]+) {
    yylval.string = strdup(yytext);
    return INTEGER;
}
 ([0-9]*\.[0-9]+)([eE][+-]?[0-9]+)? {
    yylval.string = strdup(yytext);
    return FLOAT;
} 

 /*  ------------- TOKENS Y PALABRAS RESEVADAS ---------------  */
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


 /*  --------- FUNCIONES Y TOKENS DE NUESTRO LENGUAJE --------  */
main        {return MAIN;}
print       {return PRINT;}
readStr     {return READ_STR;}
readNum     {return READ_NUM;}
getHeigth   {return GET_HEIGHT;}
getWidth    {return GET_WIDTH;}


 /*  ----------------------- SYSTEM --------------------------  */
addBody     {return ADDBODY;}


 /*  ----------------------- CONFIG --------------------------  */
gravityConstant     {return GRAVITY_CONF;}
worldBorderBounce   {return BOUNCE_CONF;}
enableBodyTrail     {return TRAIL_CONF;}


 /*  ---------------- FUNCIONES MATEMATICAS ------------------  */
floor |
ceil  |
sqrt  { yylval.string = strdup(yytext);
        return NUM_FUNCT;
}


 /*  ---------------- VARIABLES DEL USUARIO ------------------  */
[A-Za-z][A-Za-z0-9_]* {
    yylval.string = strdup(yytext);
    return NAME;
}   


 /*  ----------------- CARACTERES IGNORADOS -----------------  */
{nl} ;
{ws} ;  /* ignore whitespace */


 /*  --------------------- END OF FILE ----------------------  */
"$" return 0;  /* EOF when running in command line */


 /*  ----------------------- STRINGS ------------------------  */
{qstring} {yylval.string = strdup(yytext);
            if(yylval.string[yyleng-1] != '"'){
                fprintf(stderr,"Unterminated character string\n");
            }else{
                return QSTRING;
            }
}

 /*  -------------- COMPARACIONES MATEMATICAS ---------------  */
"=="    |
"!="    |
"<"     |
">"     |
"<="    |
">="    { 
    yylval.string = strdup(yytext);
  
    return COMPARATION;
}   

 /*  --------------------- INCREMETALES ----------------------  */
"+=" |
"-=" |   
"*=" |
"/=" { yylval.string = strdup(yytext);
       return OPEQ;
    }


 /*  ---------------- COMPARACIONES LOGICAS -----------------  */
"&&" {return AND;}
"||"  {return OR;}
"!" {return NOT;}


 /*  ----------------- DEVOLVEMOS LO MISMO ------------------  */
[:(){},.;%\+/-] {return yytext[0];}
.   return yytext[0];

%%


