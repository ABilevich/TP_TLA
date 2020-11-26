%{
#include "parser.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdarg.h>

#define YYDEBUGGING 1

#define HEADER_FILE "header.aux"
#define DEFAULT_OUTFILE "index.html"
#define FOOTER_FILE "footer.aux"
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"
#ifdef DEBUG_TRUE
  #define DEBUGGING 1
#else
  #define DEBUGGING 0
#endif
void appendFiles(char source[], FILE * fd2);
int yylex();
void yyerror(const char *s);
void yydebug(const char * format,...);
void printTable();
extern FILE *yyin, *yyout;


%}

%union{
    char* string;
    struct symtab* symp;
    struct exp_t* exp_type;
}

//Token defnitions
%token <symp> NAME NUM_NAME STR_NAME BOOL_NAME NUM_ARR_NAME STR_ARR_NAME BOOL_ARR_NAME
%token <string> INTEGER FLOAT
%token <string> QSTRING
%token <string> COMPARATION
%token MAIN NEW_LINE TAB 
%token IF ELSE WHILE
%token SYSTEM_TOKEN CONFIG_TOKEN 
%token TYPE_STR TYPE_NUM TYPE_BOOL
%token TRUE_TK FALSE_TK
%token GRAVITY_CONF BOUNCE_CONF
%token ADDBODY PRINT READ_STR READ_NUM

//Set precedences
%left OR
%left AND
%left NOT
%left COMPARATION
%left '-' '+'
%left '*' '/'

%nonassoc UMINUS
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%type <exp_type> exp
%type <string> num_exp
%type <string> str_exp
%type <string> bool_exp
%type <exp_type> arr_init
%type <exp_type> arr_item
%type <exp_type> data_type
%type <string> statement
%type <string> statement_list
%type <string> print
%type <string> read_str
%type <string> read_num
%type <string> system
%type <string> config
%type <string> if_statement
%type <string> while_statement
%type <string> system_action
%type <string> config_action
//%type <string> print_func
%%


start:  /* lambda */
    |  MAIN '(' ')' '{' statement_list '}'  {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "main\n" ANSI_COLOR_RESET);
        char * s = malloc(strlen($5)+1);
          if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"\n%s\n",$5);
        fprintf(yyout,"%s",s);
    }
    ;

statement_list: statement {
    if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement 1:"ANSI_COLOR_RESET "%s\n",$1);
        char * s = malloc(strlen($1)+2);
        sprintf(s,"%s\n",$1);
        $$ = s;
    }
    |  statement_list statement   {
        if(DEBUGGING) {yydebug(ANSI_COLOR_GREEN"statement list:"ANSI_COLOR_RESET "%s\n",$1);
        yydebug(ANSI_COLOR_GREEN"statement 2:"ANSI_COLOR_RESET "%s\n",$2);}

        // char *s = malloc(strlen($$) +strlen($2) +3);
        // sprintf(s,"%s\t%s\n",$$,$2);  

        char * s = malloc(strlen($1)+strlen($2)+2);
        sprintf(s,"%s%s\n",$1,$2);
        $$ = s;

        // // char *s = strdup($1);
        // // strcat(s,$2);
        // // strcat(s,"\n");
        // $$ =s;
    }
    ;

statement: 

    data_type NAME '=' exp {
    
       if($1->type != $4->type){
              yyerror("invalid type assignment.");
       }
       printf("before datatype= %d\nname type= %d\n",$1->type,$2->type);
     
        $2->type = $1->type;
        printf("after datatype= %d\nname type= %d\n",$1->type,$2->type);
        char *s = malloc(strlen($2->name) + strlen($4->sval) + 8);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"let %s = %s",$2->name,$4->sval);
        $$ = s;
    }
    | data_type NAME '[' ']' '=' arr_init {
         if($1->type != $6->type){
              yyerror("invalid type assignment.");
              exit(1);
        }
        enum var_type type;

        switch($1->type){
            case NUM_TYPE:
                type = NUM_ARR_TYPE;
            break;
            case STR_TYPE:
                type = STR_ARR_TYPE;
            break;
            case BOOL_TYPE:
                type = BOOL_ARR_TYPE;
            break;
            default:
            break;
        }
        
        $2->type = type;
         
        char *s = malloc(strlen($2->name) + strlen($6->sval) +8);
     
        if(s == NULL){
            yyerror("no memory left");
        }
  
        sprintf(s,"let %s = [%s]",$2->name,$6->sval);
        $$ = s;
    }
    | system {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET"system %s\n",$1);
        $$ = $1;
    }
    | config {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "config %s\n",$1);
        $$ = $1;
    }
    | print {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "print\n");
        $$ = $1;
    }
    | read_str {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "read\n");
        $$ = $1;
    }
    | read_num {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "read\n");
        $$ = $1;
    }
    | if_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "if\n");
        $$ = $1;
    }
    | while_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "while\n");
        $$ = $1;
    }
    | NUM_ARR_NAME '[' INTEGER ']'  '=' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "num array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | STR_ARR_NAME '[' INTEGER ']'  '=' str_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "str array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +8);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | BOOL_ARR_NAME '[' INTEGER ']' '=' bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "bool array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | NUM_NAME '=' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "num eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
          printf("%s = %s\n",$1->name,$3);
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }
    | STR_NAME '=' str_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "str eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        printf("%s = %s\n",$1->name,$3);
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }
    | BOOL_NAME '=' bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "bool eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }

    ;

data_type: TYPE_STR {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_STR\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = STR_TYPE;
        aux->sval = "str";
        $$ = aux; 
 
    }
    | TYPE_NUM { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_NUM\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = NUM_TYPE;
         aux->sval = "num";
        $$ = aux; 
    }
    | TYPE_BOOL { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_BOOL\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = BOOL_TYPE;
        aux->sval = "bool";
        $$ = aux; 
    }
    ;

if_statement: IF '(' bool_exp ')' '{' statement_list '}' %prec LOWER_THAN_ELSE {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if\n");
        char * s  = malloc( strlen("if(  ) {\n}") + strlen($3) + strlen($6) +1);
        if(s == NULL){
            yyerror("no memory left");
        }    
        sprintf(s,"if( %s ) {\n%s}",$3,$6);
        //    free($3);
        //    free($6);
        $$ = s;
    }
    | IF '(' bool_exp ')' '{' statement_list '}' ELSE '{' statement_list '}' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if else\n");
        char * s  = malloc(strlen("if(  ) {\n}else{\n}") + strlen($3) + strlen($6) + strlen($10) + 1);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"if( %s ) {\n%s}else{\n%s}",$3,$6,$10);
        //    free($3);
        //    free($6);
        //    free($10);
        $$ = s;
    }
    ;

while_statement: WHILE '(' bool_exp ')' '{' statement_list '}' {
    if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"while_statement: "ANSI_COLOR_RESET "while\n");
    char * s  = malloc(17+strlen($3)+strlen($6));
    if(s == NULL){
        yyerror("no memory left");
    }
        sprintf(s,"while( %s ) {\n%s}",$3,$6);
        $$ = s;
    }
    ;

exp: num_exp { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "num exp\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = NUM_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | str_exp { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "str exp\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = STR_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "bool exp\n"); 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = BOOL_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    ;

    
num_exp: num_exp '+' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "sum\n");
        $$ = expOp($1,"+",$3);
    }
    | num_exp '-' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "subs\n");
        $$ = expOp($1,"-",$3);
    }
    | num_exp '/' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "div\n");
        if(!strcmp($3,"0")){
            yyerror("division by zero.");
        }
        $$ = expOp($1,"/",$3);
    }
    | num_exp '*' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "mult\n");
        $$ = expOp($1,"*",$3);
    }
    | '-' num_exp %prec UMINUS {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "negation\n");
        char *s = malloc(strlen($2) +2);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"-%s",$2);
                
        $$ = s;
    }
    | '(' num_exp ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "parenthesis\n");
        char *s = malloc(strlen($2) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"(%s)",$2);
                
        $$ = s;
    }
    | NUM_ARR_NAME '[' num_exp ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    | NUM_NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "variable\n");
        $$ = strdup($1->name);
    }
    | INTEGER {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "integer: %s\n",$1);
    }
    | FLOAT {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "float: %s\n",$1);
    }
    | read_num {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "read_num\n");
        $$ = strdup($1);
    }
    ;
    
str_exp: QSTRING {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "qstring\n");
    }

    | str_exp '+' str_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition str str\n");
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }

    | num_exp '+' str_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition num str\n");
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }
                    
    | str_exp '+' num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition str num\n");
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }

    | STR_ARR_NAME '[' num_exp ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    | STR_NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "variable\n");
        printf("string name = %s\n",$1->name);
        $$ = strdup($1->name);
    }
    | read_str {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "read_str\n");
        $$ = strdup($1);
    }
    ;

bool_exp: bool_exp AND bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "and\n");
        char * str = malloc(strlen($1) + strlen($3) + strlen("&&") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s && %s",$1,$3);
        $$ = str;
    }
    |   bool_exp OR bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "or\n");
        char * str = malloc(strlen($1) + strlen($3) + strlen("||") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s || %s",$1,$3);
        $$ = str;
    }
    |   NOT bool_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "not\n");
        char * str = malloc(strlen($2) + strlen("!") + 1);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"!%s",$2);
        $$ = str;
    }
    |   num_exp COMPARATION num_exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "comparation\n");
        char *str = malloc(strlen($1) + strlen($3) + strlen($2) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s %s %s",$1, $2, $3);
        $$ = str;
    }
    |   '(' bool_exp ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "parenthesis\n");
        char *str = malloc(strlen($2) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"(%s)",$2);
        $$ = str;
    }
    |   BOOL_ARR_NAME '[' num_exp ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    |   BOOL_NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "variable\n");
            $$ = strdup($1->name);
    }
    |   TRUE_TK { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "true\n");
        $$ = strdup("true");
    }
    |   FALSE_TK{
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "false\n");
         $$ = strdup("false");
    }
    ;


arr_init: '[' arr_item ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_init: "ANSI_COLOR_RESET "new arr\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
       
        aux->type = $2->type;
        aux->sval = $2->sval;
        $$ = aux;
    }
    ; 

arr_item: exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "last arr item\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
         if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = $1->type;
        aux->sval = $1->sval;
        $$ = aux;
    } 
    |  exp ',' arr_item {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "new arr item\n");
            if($1->type != $3->type){
                yyerror("invalid type for array item");
            }
            struct exp_t* aux = malloc(sizeof(struct exp_t));
            if(aux == NULL){
                yyerror("no memory left");
            }
            aux->type = $1->type;
            char * s = malloc(strlen($1->sval) + strlen($3->sval) + 2);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"%s, %s",$1->sval,$3->sval);
            aux->sval = s;
            $$ = aux;
        }
    ;


system:
        SYSTEM_TOKEN '.' system_action {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system: "ANSI_COLOR_RESET "token.action\n");
            $$ = $3;
        }
    ;

system_action: ADDBODY '(' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' str_exp ')' { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system_action: "ANSI_COLOR_RESET "addbody\n");
            char *s = malloc(strlen($3) + strlen($5) + strlen($7) + strlen($9) + strlen($11) + strlen($13) + strlen($15) + strlen("bodies.push(new Body(,,,,,,))")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"bodies.push(new Body(%s,%s,%s,%s,%s,%s,%s))",$3,$5,$7,$9,$11,$13,$15); 
            $$ = s; 
        }
    ;
    
config: CONFIG_TOKEN '.' config_action { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config: "ANSI_COLOR_RESET "token.action\n");
        $$ = $3;
    }
    ;

config_action: GRAVITY_CONF '(' num_exp ')' { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "gravity\n");
            char *s = malloc(strlen($3) + strlen("Gc = ")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"Gc = %s",$3);
            $$ = s;
        }
        | BOUNCE_CONF '(' bool_exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "bounce\n");
            char *s = malloc(strlen($3) + strlen("worldBorderBounce = ") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"worldBorderBounce = %s",$3);
            $$ = s;
        }
    ;

print: PRINT '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"print: "ANSI_COLOR_RESET "print exp\n");
            char *s = malloc(strlen($3->sval) + strlen("console.log()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"console.log(%s)",$3->sval); 
            printf("print: %s, %s\n", $$, s);
            $$ = s; 
        }
    ;

read_str:  READ_STR '(' str_exp ')' {  
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"read_str: "ANSI_COLOR_RESET "read exp\n");   
            char *s = malloc(strlen($3) + strlen("window.prompt()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"window.prompt(%s)",$3); 
            printf("read_str: %s, %s\n", $$, s);
            $$ = s; 
        }
    ;

read_num:  READ_NUM '(' str_exp ')' { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"read_num: "ANSI_COLOR_RESET "read exp\n");   
            char *s = malloc(strlen($3) + strlen("window.prompt()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"window.prompt(%s)",$3); 
            printf("read_num: %s, %s\n", $$, s);
            $$ = s; 
        }
    ;
%%


struct symtab * symLook(char* s){
    struct symtab * sp;

    printf("searching for: %s\n", s);

    for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){
        /* is it alredy here? */

        if (sp->name && !strcmp((sp->name)+2, s) ){
            
            printf("comparing: %s\n", (sp->name)+2);
            printTable();
            return sp;
        }
      
        /* is it free */
        if(!sp->name) {
            char * snew = malloc(sizeof(s)+3);
            sprintf(snew, "u_%s", s);
            sp->name = snew;
            // sp->name = strdup(s);
            sp->type = NOT_DEFINED;
            return sp;
        }else{
            printTable();
        }
        /* otherwise continue to next */
    }
     yyerror("Too many symbols");
     exit(1);
    
}

char * expOp(char * exp1,char * op,char * exp2){
    if(!strcmp("/",op) && atof(exp2) == 0.0){
        yyerror("divide by zero");
    }else{
        char *s = malloc(strlen(exp1) + strlen(op) + strlen(exp2)+4);
        if(s == NULL){
            yyerror("no memory left");
        }
        if(exp1 != NULL && op != NULL && exp2 != NULL){
            sprintf(s,"%s %s %s",exp1,op,exp2);
             return s;            
        } 
    }
    return NULL;
}

void addFunc(char *name,double(*func)()){
    struct symtab *sp = symLook(name);
    sp->funcptr = func;
}

int main(int argc, char* argv[]){

    extern double sqrt(),exp(),log();
   
    // addFunc("sqrt",sqrt);
    // addFunc("exp",exp);
    // addFunc("log",log);
    char * infile;

    char * progname = argv[0];
    if(argc == 1){
        yyparse();
    }else if(argc > 1){
        infile = argv[1];
        yyin = fopen(infile,"r");
        if(yyin == NULL){
            fprintf(stderr,"%s: cannot open %s\n",progname,infile);
            exit(1);
        }
      
    }

    

    yyout = fopen(DEFAULT_OUTFILE,"w");
    if(yyout == NULL){
        fprintf(stderr,"%s: cannot open %s\n",progname,DEFAULT_OUTFILE);
        exit(1);
    }

    appendFiles(HEADER_FILE, yyout);

    yyparse();

    appendFiles(FOOTER_FILE, yyout);
  
    fclose(yyin);
    fclose(yyout);
    exit(0);
    // while(!feof(yyin)){
    //     yyparse();
    // }
  
    return 0;
}

void appendFiles(char source[], FILE * fp2)
{
    // declaring file pointers
    FILE *fp1;
 
    // opening files
    fp1 = fopen(source, "a+");
 
    // If file is not found then return.
    if (!fp1 && !fp2) {
        printf("Unable to open/"
               "detect file(s)\n");
        return;
    }
 
    char buf[100];
 
    // explicitly writing "\n"
    // to the destination file
    // so to enhance readability.
    fprintf(fp2, "\n");
 
    // writing the contents of
    // source file to destination file.
    while (!feof(fp1)) {
        fgets(buf, sizeof(buf), fp1);
        fprintf(fp2, "%s", buf);
    }

}
 
void printTable(){
    printf("########################\n");
    for(int i = 0; i< MAX_SYMBOLS;i++){
        if(symtab[i].name == NULL){
            break;
        }
        printf("symb[%d].name = %s\nsymb[%d].type = %d\n",i,symtab[i].name,i,symtab[i].type);
    }
      printf("########################\n");
}
void yyerror(const char *s)
{
    fprintf (stderr,ANSI_COLOR_RED "Error: %s\n" ANSI_COLOR_RESET, s);
    exit(1);
}

void yydebug(const char * format,...){
    va_list argptr;
    va_start(argptr, format);
    vfprintf (stderr,format, argptr);
    va_end(argptr);
   
}

