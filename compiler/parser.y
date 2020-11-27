%{
#include "parser.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdarg.h>

#define YYDEBUGGING 1
#define EXP_SIZE sizeof(struct exp_t)
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
void freeTable();
enum var_type arrTypeToNormal(enum var_type type);
extern FILE *yyin, *yyout;


%}

%union{
    char* string;
    struct symtab* symp;
    struct exp_t* exp_type;
}

//Token defnitions
%token <string> NAME
%token <string> INTEGER FLOAT
%token <string> QSTRING
%token <string> COMPARATION
%token MAIN 
%token ELSE IF WHILE
%token SYSTEM_TOKEN CONFIG_TOKEN 
%token TYPE_STR TYPE_NUM TYPE_BOOL
%token TRUE_TK FALSE_TK
%token GRAVITY_CONF BOUNCE_CONF TRAIL_CONF GET_HEIGHT GET_WIDTH
%token ADDBODY PRINT READ_STR READ_NUM 
%token <string> OPEQ
%token <string> NUM_FUNCT
//Set precedences
%left OR
%left AND
%left NOT
%left COMPARATION
%left '-' '+'
%left '*' '/' '%'

%nonassoc UMINUS
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%type <exp_type> exp
%type <exp_type> arr_init
%type <exp_type> arr_item
%type <string> statement
%type <string> statement_list
%type <string> print
%type <string> system
%type <string> config
%type <string> if_statement
%type <string> while_statement
%type <string> system_action
%type <string> config_action
%type <string> variable_definitions
%type <string> variable_definition

%%


start:  /* lambda */
    |  variable_definitions MAIN '(' ')' '{' statement_list '}'  {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "main\n" ANSI_COLOR_RESET);

        char * s = malloc(strlen($1) + strlen($6) + 4);
        if(s == NULL) yyerror("no memory left");
        
        sprintf(s,"\n%s\n%s\n",$1, $6);                                
        //free previous allocations
        free($1);
        free($6);
        
        fprintf(yyout,"%s",s);
        free(s);
    }
    ;

variable_definitions: /* lambda */ {
        $$ = strdup("\n");
    }
    | variable_definitions variable_definition{
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "variable_definition\n" ANSI_COLOR_RESET);

        char * s = malloc(strlen($1)+strlen($2)+2);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"%s%s\n",$1,$2);
                                
        //free previous allocations
        free($1);
        free($2);

        $$ = s;
    }
    ;

variable_definition: TYPE_NUM NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_num name\n" ANSI_COLOR_RESET);
        //save symbol
        struct symtab * sym = symSave($2,NUM_TYPE);
        
        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s",sym->name);
        $$ = s;
    }
    | TYPE_STR NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_str name\n" ANSI_COLOR_RESET);

        struct symtab * sym = symSave($2,STR_TYPE);

        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s",sym->name);
        $$ = s;
    }
    | TYPE_BOOL NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_bool name\n" ANSI_COLOR_RESET);

        struct symtab * sym = symSave($2,BOOL_TYPE);
      
        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s",sym->name);
        $$ = s;
    }
    | TYPE_NUM NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_num name\n" ANSI_COLOR_RESET);
        //save symbol
        struct symtab * sym = symSave($2,NUM_ARR_TYPE);
        
        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s = []",sym->name);
        $$ = s;
    }
    | TYPE_STR NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_str name\n" ANSI_COLOR_RESET);

        struct symtab * sym = symSave($2,STR_ARR_TYPE);

        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s = []",sym->name);
        $$ = s;
    }
    | TYPE_BOOL NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_bool name\n" ANSI_COLOR_RESET);

        struct symtab * sym = symSave($2,BOOL_ARR_TYPE);
      
        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror("no memory left");
        
        //save code
        sprintf(s,"let %s = []",sym->name);

        $$ = s;
    }
    ;

statement_list: /* lambda */ {
        $$ = strdup("\n");
    }
    |  statement_list statement   {
        if(DEBUGGING) {
            yydebug(ANSI_COLOR_GREEN"statement list:"ANSI_COLOR_RESET "%s\n",$1);
            yydebug(ANSI_COLOR_GREEN"statement 2:"ANSI_COLOR_RESET "%s\n",$2);
        }

        char * s = malloc(strlen($1)+strlen($2)+2);
        sprintf(s,"%s%s\n",$1,$2);
                
        //free previous allocations

        free($1);
        free($2);
           
        $$ = s;
    }
    ;

statement: 
    system {
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
    | if_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "if\n");
        $$ = $1;
    }
    | while_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "while\n");
        $$ = $1;
    }
    | NAME '[' exp ']'  '=' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement: "ANSI_COLOR_RESET "NAME[exp] = exp\n");
        
         //type verification 
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror("Variable not declared");
        if(arrTypeToNormal(sym->type) != $6->type) yyerror("Invalid assignment value type");  
        
        char *s = malloc(strlen(sym->name) + strlen($3->sval) + strlen($6->sval) +6);
        if(s == NULL){

            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",sym->name,$3->sval,$6->sval);
                                                                           
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
        free($6->sval);
        free($6);
            
        $$ = s;
    }
    | NAME '=' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement: "ANSI_COLOR_RESET "NAME = exp\n");
        
        //type verification  
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror("Variable not declared");
        if(sym->type != $3->type) yyerror("Type conflict: Assigning variable with incorrect value type");
    
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +4);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"%s = %s",sym->name,$3->sval);
                                                                                   
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
            
        $$ = s;
    }
    | NAME OPEQ exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement: "ANSI_COLOR_RESET "NAME = exp\n");
        
        //type verification  
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror("Variable not declared");
        if( strcmp($2,"+=") == 0){
            if( !(sym->type == NUM_TYPE && $3->type == NUM_TYPE) && !(sym->type == STR_TYPE && $3->type == STR_TYPE)) yyerror("Type conflict: increment value is not a valid type!");
        }else{
            if(!(sym->type == NUM_TYPE && $3->type == NUM_TYPE)) yyerror("Type conflict: increment value is not a valid type!");
        }
        
    
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +5);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"%s %s %s",sym->name,$2,$3->sval);
                                                                                   
        //free previous allocations
        free($1);
        free($2);
        free($3->sval);
        free($3);
            
        $$ = s;
    }
    | NAME '=' arr_init { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if(exp){statement_list}\n");
        
        //type verification  
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror("Variable not declared");
        if(arrTypeToNormal(sym->type) != $3->type) yyerror("Type conflict: Invalid array initialization type");  
    
        //line building
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +4);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"%s = %s",sym->name,$3->sval);
                                                                                           
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
            
        $$ = s;
    }
    ;

if_statement: IF '(' exp ')' '{' statement_list '}' %prec LOWER_THAN_ELSE {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if(exp){statement_list}\n");

        //type verification
        if($3->type != BOOL_TYPE ) yyerror("Type conflict: if condition must be boolean!");

        char * s  = malloc( strlen("if(  ) {\n}") + strlen($3->sval) + strlen($6) +1);
        if(s == NULL) yyerror("no memory left");
        
        sprintf(s,"if( %s ) {\n%s}",$3->sval,$6);
                                                                                                   
        //free previous allocations
        free($3->sval);
        free($3);
        free($6);

        $$ = s;
    }
    | IF '(' exp ')' '{' statement_list '}' ELSE '{' statement_list '}' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if(exp){ statement_list}else{ statement_list}\n");
        
        //type verification
        if($3->type != BOOL_TYPE ) yyerror("Type conflict: if condition must be boolean!");
        
        char * s  = malloc(strlen("if(  ) {\n}else{\n}") + strlen($3->sval) + strlen($6) + strlen($10) + 1);
        if(s == NULL) yyerror("no memory left");
        
        sprintf(s,"if( %s ) {\n%s}else{\n%s}",$3->sval,$6,$10);
                                                                                                           
        //free previous allocations
        free($3->sval);
        free($3);
        free($6);
        free($10);

        $$ = s;
    }
    ;

while_statement: WHILE '(' exp ')' '{' statement_list '}' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"while_statement: "ANSI_COLOR_RESET "while(exp){ statement_list}\n");

        //type verification
        if($3->type != BOOL_TYPE ) yyerror("Type conflict: expression between () must be boolean!");
        
        char * s  = malloc(strlen($3->sval) + strlen($6) + 14);
        if(s == NULL) yyerror("no memory left");
        
        sprintf(s,"while( %s ) {\n%s}",$3->sval,$6);
                                                                                                                   
        //free previous allocations
        free($3->sval);
        free($3);
        free($6);

        $$ = s;
    }
    ;

exp: exp '+' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp + exp\n");

        //type verification
        if($1->type == BOOL_TYPE || $3->type == BOOL_TYPE ) yyerror("Type conflict: in sum expression!");

        struct exp_t* aux = malloc(EXP_SIZE);
        char * s = expOp($1->sval,"+",$3->sval);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        aux->sval = s;
        if($1->type == NUM_TYPE && $3->type == NUM_TYPE ){
            aux->type = NUM_TYPE;   
        }else{
            aux->type = STR_TYPE; 
        }
                
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
           
        $$ = aux;
    }
    | exp '-' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp - exp\n");

        //type verification
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror("Type conflict: in sustraction expression!");

        struct exp_t* aux = malloc(EXP_SIZE);
        char * s = expOp($1->sval,"-",$3->sval);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        aux->sval = s;
        aux->type = $1->type;  
        
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
           
        $$ = aux;
        
    }
    | exp '/' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp / exp\n");

        //type verification
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror("Type conflict: in division expression!");
        
        struct exp_t* aux = malloc(EXP_SIZE);
        char *s = expOp($1->sval,"/",$3->sval);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        aux->sval = s;
        aux->type = $1->type;
                
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | exp '*' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp * exp\n");
        
        //type verification
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror("Type conflict: in product expression!");

        struct exp_t* aux = malloc(EXP_SIZE);
        char *s = expOp($1->sval,"*",$3->sval);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        aux->sval = s;
        aux->type = $1->type;
                
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | exp '%' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp % exp\n");
        
        //type verification
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror("Type conflict: in product expression!");

        struct exp_t* aux = malloc(EXP_SIZE);
        char *s = expOp($1->sval,"%",$3->sval);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        aux->sval = s;
        aux->type = $1->type;
                
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | '-' exp %prec UMINUS {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "-exp\n");
        
        //type verification
        if($2->type != NUM_TYPE)  yyerror("Type conflict: in minus assignment expression!");
        
        struct exp_t* aux = malloc(EXP_SIZE);
        char *s = malloc(strlen($2->sval) +2);
        if(s == NULL  || aux == NULL) yyerror("no memory left");
        sprintf(s,"-%s",$2->sval);

        aux->sval = s;
        aux->type = $2->type;   
                
        //free previous allocations
        free($2->sval);
        free($2);
       
        $$ = aux;
    }
    | '(' exp ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "(exp)\n");

        char *s = malloc(strlen($2->sval) +3);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("no memory left");
        sprintf(s,"(%s)",$2->sval);

        aux->sval = s;
        aux->type = $2->type;
            
        //free previous allocations
        free($2->sval);
        free($2);
                
        $$ = aux;
    }
    |   exp AND exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp AND exp\n");

        //type verification
        if($1->type != BOOL_TYPE || $3->type != BOOL_TYPE) yyerror("invalid types in and clause");
    
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 5);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("No memory left");
        sprintf(s,"%s && %s",$1->sval,$3->sval);

        aux->sval = s;
        aux->type = BOOL_TYPE;
                        
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    |   exp OR exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp OR exp\n");

        //type verification
        if($1->type != BOOL_TYPE || $3->type != BOOL_TYPE) yyerror("invalid types in or clause");
        
      
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 5);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("No memory left");
        sprintf(s,"%s || %s",$1->sval,$3->sval);
        
        aux->sval = s;
        aux->type = BOOL_TYPE;
                        
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    |   NOT exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NOT exp: %s\n",$2->sval);
        
        //type verification
        if($2->type != BOOL_TYPE) yyerror("Type conflict: expression must be bool!");
        
      
        char * s = malloc(strlen($2->sval) +2);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("No memory left");
        
        sprintf(s,"!%s",$2->sval);
        aux->sval = s;
        aux->type = BOOL_TYPE;
                    
        //free previous allocations
        free($2->sval);
        free($2);
                
        $$ = aux;
    }
    |   exp COMPARATION exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp %s exp\n",$2);
        
        //type verification
        if(!($1->type == NUM_TYPE && $3->type == NUM_TYPE) && !($1->type == STR_TYPE && $3->type == STR_TYPE)  ) yyerror("Type conflict: both expressions must be numbers!");

     
        char *s = malloc(strlen($1->sval) + strlen($3->sval) + strlen($2) + 3);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("No memory left");

        sprintf(s,"%s %s %s",$1->sval, $2, $3->sval);
        
        aux->sval = s;
        aux->type = BOOL_TYPE;
                        
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
        free($2);
     
        $$ = aux;
    }
    | NAME '[' exp ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NAME[exp]: %s\n",$1);
        
        //type verification
        if($3->type != NUM_TYPE) yyerror("Type conflict: array index must be a number!");
        
        struct symtab * sym = symLook($1);

        if(sym == NULL) yyerror("Variable not declared");
      
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +3);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("no memory left");
        sprintf(s,"%s[%s]",sym->name,$3->sval); 

        aux->sval = s;
        aux->type = arrTypeToNormal(sym->type);
        
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NAME: %s\n",$1);
        
        struct symtab * sym = symLook($1);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(sym == NULL || aux == NULL) yyerror("Variable not declared");
        
       
        aux->sval = strdup(sym->name);
        aux->type = sym->type;
        $$ = aux;
    }
    | NUM_FUNCT '(' exp ')' {
         if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NUM_FUNCT(exp): %s\n",$1);
        
        //type verification
        if($3->type != NUM_TYPE) yyerror("Type conflict: array index must be a number!");
        
        char *s = malloc(strlen($1) + strlen($3->sval) +8);
        struct exp_t* aux = malloc(EXP_SIZE);
        if(s == NULL || aux == NULL) yyerror("no memory left");
       
        sprintf(s,"Math.%s(%s)",$1,$3->sval); 

        aux->sval = s;
        aux->type = $3->type;
        
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | INTEGER {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "INTEGER: %s\n",$1);
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = NUM_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | FLOAT {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "FLOAT: %s\n",$1);
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = NUM_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | QSTRING {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "QSTRING: %s\n",$1);
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = STR_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | TRUE_TK { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "TRUE_TK\n");

        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = BOOL_TYPE;
        aux->sval = strdup("true");
        $$ = aux;
    }
    | FALSE_TK{ 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "FALSE_TK\n");

        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = BOOL_TYPE;
        aux->sval = strdup("false");
        $$ = aux;
    }
    | READ_STR '(' exp ')' { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "READ\n");
        
        //type verification
        if($3->type != STR_TYPE) yyerror("Type conflict: read message must be a string!");

        struct exp_t* aux = malloc(EXP_SIZE);   
        char *s = malloc(strlen($3->sval) + strlen("window.prompt()") + 1);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"window.prompt(%s)",$3->sval); 

        aux->type = STR_TYPE;
        aux->sval = s;
                                         
        //free previous allocations
        free($3->sval);
        free($3);
     
        $$ = aux; 
    }
    | READ_NUM '(' exp ')' { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "READ\n");
        
        //type verification
        if($3->type != STR_TYPE) yyerror("Type conflict: read message must be a string!");

        struct exp_t* aux = malloc(EXP_SIZE);   
        char *s = malloc(strlen($3->sval) + strlen("window.prompt()") + 1);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"window.prompt(%s)",$3->sval); 

        aux->type = NUM_TYPE;
        aux->sval = s;
                                                 
        //free previous allocations
        free($3->sval);
        free($3);
     
        $$ = aux; 
    }
    | GET_HEIGHT '(' ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "GET_HEIGHT\n");    
        
        struct exp_t* aux = malloc(EXP_SIZE);   
        char *s = malloc(strlen("window.innerHeight")+1);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"window.innerHeight");

        aux->type = NUM_TYPE;
        aux->sval = s;
        $$ = aux;
    }
    | GET_WIDTH '(' ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "GET_WIDTH\n");    
        
        struct exp_t* aux = malloc(EXP_SIZE);   
        char *s = malloc(strlen("window.innerWidth")+1);
        if(s == NULL) yyerror("no memory left");
        sprintf(s,"window.innerWidth");

        aux->type = NUM_TYPE;
        aux->sval = s;
        $$ = aux;
    }
    ;


arr_init: '[' arr_item ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_init: "ANSI_COLOR_RESET "arr_item\n");
        
        struct exp_t* aux = malloc(EXP_SIZE);
        if(aux == NULL) yyerror("no memory left");
        char  *s = malloc(strlen($2->sval) + 3);
        sprintf(s,"[%s]",$2->sval);
        
        aux->type = $2->type;
        aux->sval = s;
                                                 
        //free previous allocations
        free($2->sval);
        free($2);
     
        $$ = aux;
    }
    ; 

arr_item: exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "exp\n");
        
        struct exp_t* aux = malloc(EXP_SIZE);
        if(aux == NULL) yyerror("no memory left");

        aux->type = $1->type;
        aux->sval = $1->sval;
        $$ = aux;
    } 
    |  exp ',' arr_item {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "exp, arr_item\n");
        
        //type verification
        if($1->type != $3->type) yyerror("Type conflict: invalid type for array item");
        
        struct exp_t* aux = malloc(EXP_SIZE);
        if(aux == NULL) yyerror("no memory left");
        
        aux->type = $1->type;
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 3);
        if(s == NULL) yyerror("no memory left");
        
        sprintf(s,"%s, %s",$1->sval,$3->sval);
        aux->sval = s;
                                                         
        //free previous allocations
        free($1->sval);
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    ;


system:
        SYSTEM_TOKEN '.' system_action {
           if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system\n"ANSI_COLOR_RESET);
           $$ = $3;
        }
    ;

system_action: ADDBODY '(' exp ',' exp ',' exp ',' exp ',' exp ',' exp ',' exp ')' { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system_action: "ANSI_COLOR_RESET "ADDBODY\n");

            //printf("%d, %d, %d, %d, %d, %d, %d", $3->type, $5->type, $7->type, $9->type, $11->type, $13->type,$15->type);

            //type verification
            if($3->type != NUM_TYPE || $5->type != NUM_TYPE || $7->type != NUM_TYPE || $9->type != NUM_TYPE || $11->type != NUM_TYPE || $13->type != NUM_TYPE || $15->type != STR_TYPE) yyerror("Type conflict: addBody(num,num,num,num,num,num,str)");
            char *s = malloc(strlen($3->sval) + strlen($5->sval) + strlen($7->sval) + strlen($9->sval) + strlen($11->sval) + strlen($13->sval) + strlen($15->sval) + strlen("bodies.push(new Body(,,,,,,))")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"bodies.push(new Body(%s,%s,%s,%s,%s,%s,%s))",$3->sval,$5->sval,$7->sval,$9->sval,$11->sval,$13->sval,$15->sval);
                                                                     
            //free previous allocations
            free($3->sval);
            free($3);
            free($5->sval);
            free($5);
            free($7->sval);
            free($7);
            free($9->sval);
            free($9);
            free($11->sval);
            free($11);
            free($13->sval);
            free($13);
            free($15->sval);
            free($15);
            
            $$ = s; 
        }
    ;
    
config: CONFIG_TOKEN '.' config_action { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config\n"ANSI_COLOR_RESET );
        $$ = $3;
    }
    ;

config_action: GRAVITY_CONF '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "GRAVITY_CONF\n");    
        
            //type verification 
            if($3->type != NUM_TYPE) yyerror("Type conflict: gravityConstant(num)");
            
            char *s = malloc(strlen($3->sval) + strlen("Gc = ")+1);
            if(s == NULL) yyerror("no memory left");
            sprintf(s,"Gc = %s",$3->sval);
                                                                                 
            //free previous allocations
            free($3->sval);
            free($3);

            $$ = s;
        }
        | BOUNCE_CONF '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "BOUNCE_CONF\n");  
            
            //type verification
            if($3->type != BOOL_TYPE) yyerror("Type conflict: worldBorderBounce(boolean)");
            char *s = malloc(strlen($3->sval) + strlen("worldBorderBounce = ") + 1);
            if(s == NULL) yyerror("no memory left");
            
            sprintf(s,"worldBorderBounce = %s",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
            
            $$ = s;
        }
        | TRAIL_CONF '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "TRAIL_CONF\n");  
            
            //type verification
            if($3->type != BOOL_TYPE) yyerror("Type conflict: enableBodyTrail(boolean)");
            char *s = malloc(strlen($3->sval) + strlen("bodyTrail = ") + 1);
            if(s == NULL) yyerror("no memory left");
            
            sprintf(s,"bodyTrail = %s",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
            
            $$ = s;
        }
    ;

print: PRINT '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"print: "ANSI_COLOR_RESET "PRINT\n");  

            char *s = malloc(strlen($3->sval) + strlen("alert()") + 1);
            if(s == NULL) yyerror("no memory left");
            sprintf(s,"alert(%s)",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
             
            $$ = s; 
        }
    ;
   
%%


struct symtab * symLook(char* s){
   struct symtab * sym;
    for(int i = 0; i < MAX_SYMBOLS; i++){
        sym = &symtab[i];
        if(sym->name && !strcmp((sym->name)+2,s)){
            return sym;
        }else if(!sym->name){
            return NULL;
        }       
    }
    return NULL;
}
struct symtab * symSave(char* s,enum var_type type){
    struct symtab * sp;

    for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){

        if(!sp->name) {
            char * snew = malloc(strlen(s)+3);
            sprintf(snew, "u_%s", s);
            sp->name = snew;
            sp->type = type;
         
            return sp;
   
    }
}

    yyerror("Variable creation error: Too many symbols");

    return NULL;
}

char * expOp(char * exp1,char * op,char * exp2){
    char *s = malloc(strlen(exp1) + strlen(op) + strlen(exp2)+4);
    if(s == NULL){
        yyerror("no memory left");
    }
    if(exp1 != NULL && op != NULL && exp2 != NULL){
        sprintf(s,"%s %s %s",exp1,op,exp2);
        return s;            
    } 
    return NULL;
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
    freeTable();
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

void freeTable(){
    for(int i = 0; i < MAX_SYMBOLS; i++){
        struct symtab * sym = &symtab[i];
        if(sym->name){
            free(sym->name);
        }else{
            return;
        }

    }
}
enum var_type arrTypeToNormal(enum var_type type){
    switch(type){
        case NUM_ARR_TYPE:
            return NUM_TYPE;
        break;
        case BOOL_ARR_TYPE:
            return BOOL_TYPE;
        break;
        case STR_ARR_TYPE:
            return STR_TYPE;
        break;
        default:
            yyerror("Type doesn't exist");
        break;
    }
    return 0;
}

void yyerror(const char *s)
{
    fprintf (stderr,ANSI_COLOR_RED "%s\n" ANSI_COLOR_RESET, s);
    exit(1);
}

void yydebug(const char * format,...){
    va_list argptr;
    va_start(argptr, format);
    vfprintf (stderr,format, argptr);
    va_end(argptr);
   
}

