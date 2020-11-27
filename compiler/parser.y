%{
#include "parser.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
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
#define ERROR_STR(str) ANSI_COLOR_RED str ANSI_COLOR_RESET

#define MAX_SYMBOLS 50 // Maximum number of symbols

enum var_type
{
    NUM_TYPE,
    STR_TYPE,
    BOOL_TYPE,
    NUM_ARR_TYPE,
    STR_ARR_TYPE,
    BOOL_ARR_TYPE,

};

struct symtab
{
    char *name;
    enum var_type type;

} symtab[MAX_SYMBOLS];

struct exp_t
{
    char *sval;
    enum var_type type;
};

struct symtab *symLook(char *s);

struct symtab *symSave(char *s, enum var_type type);
char *expOp(char *exp1, char *op, char *exp2);

void appendFiles(char source[], FILE * fd2);
int yylex();
void yyerror(const char *format,...);
void yydebug(const char * format,...);
void printTable();
void freeTable();
void yylex_destroy();
enum var_type arrTypeToNormal(enum var_type type);
char*typeToPrintableType(enum var_type type);


extern FILE *yyin, *yyout;


%}

%union{
    char* string;
    struct symtab* symp;
    struct exp_t* exp_type;
}

/* ------------------------------ TOKEN DEFINITIONS ---------------------------------- */
%token <string> NAME
%token <string> INTEGER FLOAT
%token <string> QSTRING
%token <string> COMPARATION
%token MAIN 
%token ELSE IF WHILE FOR
%token SYSTEM_TOKEN CONFIG_TOKEN 
%token TYPE_STR TYPE_NUM TYPE_BOOL
%token TRUE_TK FALSE_TK
%token GRAVITY_CONF BOUNCE_CONF TRAIL_CONF GET_HEIGHT GET_WIDTH
%token ADDBODY PRINT READ_STR READ_NUM 
%token <string> OPEQ
%token <string> NUM_FUNCT_1 NUM_FUNCT_2

/* ---------------------------------- PRECEDENCE ------------------------------------ */
%left OR
%left AND
%left NOT
%left COMPARATION
%left '-' '+'
%left '*' '/' '%'

%nonassoc UMINUS
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

/* ---------------------------------- NON TERMINALS ---------------------------------- */
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
%type <string> for_statement
%type <string> system_action
%type <string> config_action
%type <string> variable_definitions
%type <string> variable_definition
%type <string> block_statement
%type <string> expression_statement
%%

/* ---------------------------------- PRODUCTIONS ------------------------------------ */

start:  /* lambda */
    |  variable_definitions MAIN '(' ')' '{' statement_list '}'  {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "main\n" ANSI_COLOR_RESET);

        //build js answer
        char * s = malloc(strlen($1) + strlen($6) + 4);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"\n%s\n%s\n",$1, $6);   
                                     
        //free previous allocations
        free($1);
        free($6);
        
        //priting code on index.html
        fprintf(yyout,"%s",s);
        free(s);
    }
    ;

variable_definitions: /* lambda */ {
        $$ = strdup("\n");
    }
    | variable_definitions variable_definition{
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "variable_definition\n" ANSI_COLOR_RESET);

        //build js answer
        char * s = malloc(strlen($1)+strlen($2)+2);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
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
        
        //build js answer
        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s",sym->name);
        
        //free previous allocations
        free($2);


        $$ = s;
    }
    | TYPE_STR NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_str name\n" ANSI_COLOR_RESET);

        //save symbol
        struct symtab * sym = symSave($2,STR_TYPE);

        //build js answer
        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s",sym->name);
        
        //free previous allocations
        free($2);

        $$ = s;
    }
    | TYPE_BOOL NAME {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_bool name\n" ANSI_COLOR_RESET);

        //save symbol
        struct symtab * sym = symSave($2,BOOL_TYPE);
      
        //build js answer
        char * s = malloc(strlen(sym->name)+5);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s",sym->name);
        
        //free previous allocations
        free($2);
        
        $$ = s;
    }
    | TYPE_NUM NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_num name\n" ANSI_COLOR_RESET);
        
        //save symbol
        struct symtab * sym = symSave($2,NUM_ARR_TYPE);
        
        //build js answer
        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s = []",sym->name);

        //free previous allocations
        free($2);

        $$ = s;
    }
    | TYPE_STR NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_str name\n" ANSI_COLOR_RESET);
        
        //get variable info
        struct symtab * sym = symSave($2,STR_ARR_TYPE);

        //build js answer
        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s = []",sym->name);

        //free previous allocations
        free($2); 

        $$ = s;
    }
    | TYPE_BOOL NAME '[' ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "type_bool name\n" ANSI_COLOR_RESET);

        //get variable info
        struct symtab * sym = symSave($2,BOOL_ARR_TYPE);
      
        //build js answer
        char * s = malloc(strlen(sym->name)+10);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"let %s = []",sym->name);

        //free previous allocations
        free($2);

        $$ = s;
    }
    ;

statement_list:     /* lambda */ {
        $$ = strdup("\n");
    }
    |  statement_list statement   {
        if(DEBUGGING) {
            yydebug(ANSI_COLOR_GREEN"statement list:"ANSI_COLOR_RESET "%s\n",$1);
            yydebug(ANSI_COLOR_GREEN"statement 2:"ANSI_COLOR_RESET "%s\n",$2);
        }

        //build js answer
        char * s = malloc(strlen($1)+strlen($2)+2);
        sprintf(s,"%s%s\n",$1,$2);
                
        //free previous allocations
        free($1);
        free($2);
           
        $$ = s;
    }
    ;

statement:
    block_statement{
   
        $$ = $1;
    }
    |
    expression_statement{
      
        $$ = $1;
    }
    ;

block_statement: if_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"block_statement "ANSI_COLOR_RESET "if\n");
        $$ = $1;
    }
    | while_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"block_statement "ANSI_COLOR_RESET "while\n");
        $$ = $1;
    }
    | for_statement {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"block_statement "ANSI_COLOR_RESET "for\n");
        $$ = $1;
    }
    ;

expression_statement: 
    system {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement "ANSI_COLOR_RESET"system %s\n",$1);
        $$ = $1;
    }
    | config {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement "ANSI_COLOR_RESET "config %s\n",$1);
        $$ = $1;
    }
    | print {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement "ANSI_COLOR_RESET "print\n");
        $$ = $1;
    }
    | NAME '[' exp ']' OPEQ exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement: "ANSI_COLOR_RESET "NAME = exp\n");
        
        //get variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);
        
        //type verification  
        if(arrTypeToNormal(sym->type) != $6->type) yyerror(ERROR_STR("Type conflict: Assigning %s type for array %s of type %s\n"),typeToPrintableType($6->type),$1,typeToPrintableType(sym->type));  
        if($3->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: array index must be of type num for array %s\n"),$1);  
        if( strcmp($5,"+=") == 0){
            if( !(arrTypeToNormal(sym->type) == NUM_TYPE && $6->type == NUM_TYPE) && !(arrTypeToNormal(sym->type) == STR_TYPE && $6->type == STR_TYPE)) yyerror(ERROR_STR("Type conflict: increment value is not a valid type!"));
        }else{
            if(!(arrTypeToNormal(sym->type) == NUM_TYPE && $6->type == NUM_TYPE)) yyerror(ERROR_STR("Type conflict: increment value is not a valid type!"));
        }
        
        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) + strlen($6->sval) +7);
        if(s == NULL) yyerror(ERROR_STR("no memory left"));
        sprintf(s,"%s[%s] %s %s",sym->name, $3->sval, $5, $6->sval);
                                                                                   
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
        free($5);
        free($6->sval);
        free($6);


        $$ = s;
    }
    | NAME '[' exp ']'  '=' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement: "ANSI_COLOR_RESET "NAME[exp] = exp\n");
        
        //get variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);
        
        //type verification  
        if(arrTypeToNormal(sym->type) != $6->type) yyerror(ERROR_STR("Type conflict: Assigning %s type for array %s of type %s\n"),typeToPrintableType($6->type),$1,typeToPrintableType(sym->type));  
        if($3->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: Invalid array index for array %s, index must be of type num\n"),$1);  
        
        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) + strlen($6->sval) +6);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
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
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement: "ANSI_COLOR_RESET "NAME = exp\n");
        
        //get variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);

        //type verification  
        if(sym->type != $3->type) yyerror(ERROR_STR("Type conflict: Assigning variable %s of type %s with type %s\n"),$1,typeToPrintableType(sym->type),typeToPrintableType($3->type));
    
        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +4);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s = %s",sym->name,$3->sval);
                                                                                   
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
  
            
        $$ = s;
    }
    | NAME OPEQ exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement: "ANSI_COLOR_RESET "NAME = exp\n");
        
        //get variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);
        
        //type verification  
        if( strcmp($2,"+=") == 0){
            if( !(sym->type == NUM_TYPE && $3->type == NUM_TYPE) && !(sym->type == STR_TYPE && $3->type == STR_TYPE)) yyerror(ERROR_STR("Type conflict: increment value is not a valid type\n"));
        }else{
            if(!(sym->type == NUM_TYPE && $3->type == NUM_TYPE)) yyerror(ERROR_STR("Type conflict: increment value is not a valid type\n"));
        }
        
        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +5);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s %s %s",sym->name,$2,$3->sval);
                                                                                   
        //free previous allocations
        free($1);
        free($2);
        free($3->sval);
        free($3);
            
        $$ = s;
    }
    | NAME '=' arr_init { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"expression_statement: "ANSI_COLOR_RESET "NAME = arr_init\n");
        
        //get variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);

        //type verification  
        if(arrTypeToNormal(sym->type) != $3->type) yyerror(ERROR_STR("Type conflict: Invalid array initialization type for array %s, must be of type %s\n"),$1,typeToPrintableType(sym->type));  
    
        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +4);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
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
        if($3->type != BOOL_TYPE ) yyerror(ERROR_STR("Type conflict: if condition must be boolean\n"));
    
        //build js answer
        char * s  = malloc( strlen("if(  ) {\n}") + strlen($3->sval) + strlen($6) +1);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
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
        if($3->type != BOOL_TYPE ) yyerror(ERROR_STR("Type conflict: if condition must of type bool\n"));
        
        //build js answer
        char * s  = malloc(strlen("if(  ) {\n}else{\n}") + strlen($3->sval) + strlen($6) + strlen($10) + 1);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
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
        // if($3->type != BOOL_TYPE ) yyerror(ANSI_COLOR_RED"Type conflict: while condition must be boolean\n"ANSI_COLOR_RESET);
        if($3->type != BOOL_TYPE ) yyerror(ERROR_STR("Type conflict: while condition must of type bool\n"));

        //build js answer
        char * s  = malloc(strlen($3->sval) + strlen($6) + 14);
        if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"while( %s ) {\n%s}",$3->sval,$6);
                                                                                                                   
        //free previous allocations
        free($3->sval);
        free($3);
        free($6);

        $$ = s;
    }
    ;

for_statement: FOR  '(' expression_statement ';' exp ';' expression_statement')' '{' statement_list '}' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"for_statement: "ANSI_COLOR_RESET "for(statement;exp;statement){ statement_list}\n");

        //type verification
        if($5->type != BOOL_TYPE ) yyerror(ERROR_STR("Type conflict: missing boolean exit condition in for\n"));
        
        //build js answer
        char * s  = malloc(strlen($3) + strlen($5->sval)+strlen($7)+strlen($10)+ 14);
        if(s == NULL) yyerror(ERROR_STR("no memory left\n"));
        sprintf(s,"for(%s; %s; %s) {\n%s}",$3,$5->sval,$7, $10);
                                                                                                                   
        //free previous allocations
        free($3);
        free($5->sval);
        free($5);
        free($7);
        free($10);


        $$ = s;   
    }
    ;

exp: exp '+' exp {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "exp + exp\n");

        //type verification
        if($1->type == BOOL_TYPE || $3->type == BOOL_TYPE ) yyerror(ERROR_STR("Type conflict: in sum expression, operands must be of type num or str\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char * s = expOp($1->sval,"+",$3->sval);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
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
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror(ERROR_STR("Type conflict: in sustraction expression, operands must be of type num\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char * s = expOp($1->sval,"-",$3->sval);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
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
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror(ERROR_STR("Type conflict: in division expression, operands must be of type num\n"));
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = expOp($1->sval,"/",$3->sval);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        
        //fill expression struct
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
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror(ERROR_STR("Type conflict: in product expression, operands must be of type num\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = expOp($1->sval,"*",$3->sval);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
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
        if($1->type != NUM_TYPE || $3->type != NUM_TYPE ) yyerror(ERROR_STR("Type conflict: in module expression, operands must be of type num\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = expOp($1->sval,"%",$3->sval);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
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
        if($2->type != NUM_TYPE)  yyerror(ERROR_STR("Type conflict: in minus assignment expression, operand must be of type num\n"));
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        
        //build js answer
        char *s = malloc(strlen($2->sval) +2);
        if(s == NULL  || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"-%s",$2->sval);

        //fill expression struct
        aux->sval = s;
        aux->type = $2->type;   
                
        //free previous allocations
        free($2->sval);
        free($2);
       
        $$ = aux;
    }
    | '(' exp ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "(exp)\n");

        
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = malloc(strlen($2->sval) +3);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"(%s)",$2->sval);

        //fill expression struct
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
        if($1->type != BOOL_TYPE || $3->type != BOOL_TYPE) yyerror(ERROR_STR("Type conflict: Operands must be of type bool in AND clause\n"));
    
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        
        //build js answer
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 5);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s && %s",$1->sval,$3->sval);

        //fill expression struct
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
        if($1->type != BOOL_TYPE || $3->type != BOOL_TYPE) yyerror(ERROR_STR("Type conflict: Operands must be of type bool in OR clause\n"));
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        
        //build js answer
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 5);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s || %s",$1->sval,$3->sval);
        
        //fill expression struct
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
        if($2->type != BOOL_TYPE) yyerror(ERROR_STR("Type conflict: Operand must be of type bool in NOT expression\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char * s = malloc(strlen($2->sval) +2);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"!%s",$2->sval);

        //fill expression struct
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
        if(!($1->type == NUM_TYPE && $3->type == NUM_TYPE) && !($1->type == STR_TYPE && $3->type == STR_TYPE)  ) yyerror(ERROR_STR("Type conflict: both expressions must be numbers or both strings in comparation\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = malloc(strlen($1->sval) + strlen($3->sval) + strlen($2) + 3);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s %s %s",$1->sval, $2, $3->sval);
        
        //fill expression struct
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
        if($3->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: array index must be of type num for array %s\n"),$1);
        
        //fetching variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"),$1);

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = malloc(strlen(sym->name) + strlen($3->sval) +3);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s[%s]",sym->name,$3->sval); 

        //fill expression struct
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
        
        //fetching variable info
        struct symtab * sym = symLook($1);
        if(sym == NULL) yyerror(ERROR_STR("Variable %s not declared\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        if(aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
        aux->sval = strdup(sym->name);
        aux->type = sym->type;

        //free previous allocations
        free($1);

        $$ = aux;
    }
    | NUM_FUNCT_1 '(' exp ')' {
         if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NUM_FUNCT(exp): %s\n",$1);
        
        //type verification
        if($3->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: %s(num)\n"),$1);
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = malloc(strlen($1) + strlen($3->sval) +8);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"Math.%s(%s)",$1,$3->sval); 

        //fill expression struct
        aux->sval = s;
        aux->type = NUM_TYPE;
        
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
     
        $$ = aux;
    }
    | NUM_FUNCT_2 '(' exp ',' exp ')' {
         if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "NUM_FUNCT(exp, exp): %s\n",$1);
        
        //type verification
        if($3->type != NUM_TYPE || $5->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: %s(num,num)\n"),$1);
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char *s = malloc(strlen($1) + strlen($3->sval) + strlen($5->sval) +9);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"Math.%s(%s,%s)",$1,$3->sval,$5->sval); 

        //fill expression struct
        aux->sval = s;
        aux->type = NUM_TYPE;
        
        //free previous allocations
        free($1);
        free($3->sval);
        free($3);
        free($5->sval);
        free($5);
     
        $$ = aux;
    }
    | INTEGER {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "INTEGER: %s\n",$1);
        
        //create and fill exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = NUM_TYPE;
        aux->sval = $1;

        $$ = aux;
    }
    | FLOAT {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "FLOAT: %s\n",$1);
        
        //create and fill exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = NUM_TYPE;
        aux->sval = $1;

        $$ = aux;
    }
    | QSTRING {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "QSTRING: %s\n",$1);
        
        //create and fill exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = STR_TYPE;
        aux->sval = $1;
        
        $$ = aux;
    }
    | TRUE_TK { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "TRUE_TK\n");

        //create and fill exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = BOOL_TYPE;
        aux->sval = strdup("true");

        $$ = aux;
    }
    | FALSE_TK{ 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "FALSE_TK\n");

        //create and fill exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        aux->type = BOOL_TYPE;
        aux->sval = strdup("false");

        $$ = aux;
    }
    | READ_STR '(' exp ')' { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "READ\n");
        
        //type verification
        if($3->type != STR_TYPE) yyerror(ERROR_STR("Type conflict: read message must be of type str\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);  
        
        //build js answer 
        char *s = malloc(strlen($3->sval) + strlen("window.prompt()") + 1);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"window.prompt(%s)",$3->sval); 

        //fill expression struct
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
        if($3->type != STR_TYPE) yyerror(ERROR_STR("Type conflict: read message must be of type str\n"));

        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);  

        //build js answer
        char *s = malloc(strlen($3->sval) + strlen("parseInt(window.prompt())") + 1);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("no memory left\n"));
        sprintf(s,"parseInt(window.prompt(%s))",$3->sval); 

        //fill expression struct
        aux->type = NUM_TYPE;
        aux->sval = s;
                                                 
        //free previous allocations
        free($3->sval);
        free($3);
     
        $$ = aux; 
    }
    | GET_HEIGHT '(' ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "GET_HEIGHT\n");    
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        
        //build js answer
        char *s = malloc(strlen("window.innerHeight")+1);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"window.innerHeight");

        //fill expression struct
        aux->type = NUM_TYPE;
        aux->sval = s;
        
        $$ = aux;
    }
    | GET_WIDTH '(' ')' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "GET_WIDTH\n");    
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);   
        
        //build js answer
        char *s = malloc(strlen("window.innerWidth")+1);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"window.innerWidth");

        //fill expression struct
        aux->type = NUM_TYPE;
        aux->sval = s;
        
        $$ = aux;
    }
    ;


arr_init: '[' arr_item ']' {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_init: "ANSI_COLOR_RESET "arr_item\n");
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char  *s = malloc(strlen($2->sval) + 3);
        if(aux == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"[%s]",$2->sval);
        
        //fill expression struct
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
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);
        if(aux == NULL) yyerror(ERROR_STR("No memory left\n"));

        //fill expression struct
        aux->type = $1->type;
        aux->sval = strdup($1->sval);
        
        //free previous allocations
        free($1->sval);
        free($1);

        $$ = aux;
    } 
    |  exp ',' arr_item {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "exp, arr_item\n");
        
        //type verification
        if($1->type != $3->type) yyerror(ERROR_STR("Type conflict: differing array item types\n"));
        
        //create exression struct
        struct exp_t* aux = malloc(EXP_SIZE);

        //build js answer
        char * s = malloc(strlen($1->sval) + strlen($3->sval) + 3);
        if(s == NULL || aux == NULL) yyerror(ERROR_STR("No memory left\n"));
        sprintf(s,"%s, %s",$1->sval,$3->sval);
        
        //fill expression struct
        aux->type = $1->type;
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

            //type verification
            if($3->type != NUM_TYPE || $5->type != NUM_TYPE || $7->type != NUM_TYPE || $9->type != NUM_TYPE || $11->type != NUM_TYPE || $13->type != NUM_TYPE || $15->type != STR_TYPE) yyerror(ERROR_STR("Type conflict: addBody(num,num,num,num,num,num,str)\n"));
            
            //build js answer
            char *s = malloc(strlen($3->sval) + strlen($5->sval) + strlen($7->sval) + strlen($9->sval) + strlen($11->sval) + strlen($13->sval) + strlen($15->sval) + strlen("bodies.push(new Body(,,,,,,))")+1);
            if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
            
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
            if($3->type != NUM_TYPE) yyerror(ERROR_STR("Type conflict: gravityConstant(num)\n"));
            
            //build js answer
            char *s = malloc(strlen($3->sval) + strlen("Gc = ")+1);
            if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
            sprintf(s,"Gc = %s",$3->sval);
                                                                                 
            //free previous allocations
            free($3->sval);
            free($3);

            $$ = s;
        }
        | BOUNCE_CONF '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "BOUNCE_CONF\n");  
            
            //type verification
            if($3->type != BOOL_TYPE) yyerror(ERROR_STR("Type conflict: worldBorderBounce(boolean)\n"));

            //build js answer
            char *s = malloc(strlen($3->sval) + strlen("worldBorderBounce = ") + 1);
            if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
            sprintf(s,"worldBorderBounce = %s",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
            
            $$ = s;
        }
        | TRAIL_CONF '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "TRAIL_CONF\n");  
            
            //type verification
            if($3->type != BOOL_TYPE) yyerror(ERROR_STR("Type conflict: enableBodyTrail(boolean)\n"));

            //build js answer
            char *s = malloc(strlen($3->sval) + strlen("bodyTrail = ") + 1);
            if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
            sprintf(s,"bodyTrail = %s",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
            
            $$ = s;
        }
    ;

print: PRINT '(' exp ')' {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"print: "ANSI_COLOR_RESET "PRINT\n");  

            //build js answer
            char *s = malloc(strlen($3->sval) + strlen("alert()") + 1);
            if(s == NULL) yyerror(ERROR_STR("No memory left\n"));
            sprintf(s,"alert(%s)",$3->sval);
                                                                                             
            //free previous allocations
            free($3->sval);
            free($3);
             
            $$ = s; 
        }
    ;
   
%%


/* ---------------------------------- PROGRAM FUNCTIONS ------------------------------------ */

// Looks for symbol in symbol table
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

// Stores symbol in symbol table if not already stored
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
        else if(sp->name && !strcmp((sp->name)+2,s)){
            yyerror(ERROR_STR("Variable definition error: variable already defined\n"));
        }
    }
    yyerror(ERROR_STR("Variable definition error: Too many symbols\n"));

    return NULL;
}

char * expOp(char * exp1,char * op,char * exp2){
    char *s = malloc(strlen(exp1) + strlen(op) + strlen(exp2)+4);
    if(s == NULL){
        yyerror(ERROR_STR("No memory left\n"));
    }
    if(exp1 != NULL && op != NULL && exp2 != NULL){
        sprintf(s,"%s %s %s",exp1,op,exp2);
        return s;            
    } 
    return NULL;
}


/* -------------------------------------- MAIN ----------------------------------------- */

int main(int argc, char* argv[]){

    
   
    char * infile;

    if(argc == 1){
        yyerror(ERROR_STR("Fatal error: no input file\n"));
    
    }else if(argc == 2){
        infile = argv[1];
        yyin = fopen(infile,"r");
        if(yyin == NULL){
            yyerror(ERROR_STR("Fatal error: cannot open %s\n"),infile);
         
        }
        
    }else{
        yyerror(ERROR_STR("Fatal error: too many arguments\n"));
     
     }

    yyout = fopen(DEFAULT_OUTFILE,"w");
    if(yyout == NULL){
           yyerror(ERROR_STR("Fatal error: cannot open %s\n"),DEFAULT_OUTFILE);
        
    }

    numLine = 0;
    appendFiles(HEADER_FILE, yyout);
    yyparse();
    appendFiles(FOOTER_FILE, yyout);
  
    fclose(yyin);
    fclose(yyout);
    freeTable();
    yylex_destroy();
    exit(0);
  
    return 0;
}

// appends necessary source content to destination file
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

    fclose(fp1);

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

// Frees table content
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

// Transforms TYPES to ARR_TYPES
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
            yyerror(ERROR_STR("Variable is not an array type!\n"));
        break;
    }
    return 0;
}


char* typeToPrintableType(enum var_type type){
    switch(type){
        case NUM_TYPE:
            return "num";
        break;
        case BOOL_TYPE:
            return "bool";
        break;
        case STR_TYPE:
            return "str";
        break;
        case STR_ARR_TYPE:
            return "str array";
        break;
        case BOOL_ARR_TYPE:
            return "bool array";
        break;
        case NUM_ARR_TYPE:
            return "num array";
        break;
        default:
            yyerror(ERROR_STR("Type doesn't exist\n"));
        break;
    }
    return 0;
}

void error(int num,...){
    va_list argptr;
    va_start(argptr, num);
    char * msg = va_arg(argptr,char*);
    switch(num){
        case 1:
            fprintf (stderr,ANSI_COLOR_RED "%s\n" ANSI_COLOR_RESET,msg);
            break;
        case 2:
            fprintf (stderr,ANSI_COLOR_RED "%s " ANSI_COLOR_CYAN "%s\n" ANSI_COLOR_RESET,msg,va_arg(argptr,char*));
            break;
        default:
            break;
    }
    va_end(argptr);
    exit(1);
}

// Error handler, prints error and exits program
void yyerror(const char *format,...)
{
    va_list argptr;
    va_start(argptr, format);

    vfprintf(stderr,format, argptr);
    va_end(argptr);
    /* fprintf (stderr,ANSI_COLOR_RED "%s\n" ANSI_COLOR_RESET, s); */
    exit(1);
}


void yydebug(const char * format,...){
    va_list argptr;
    va_start(argptr, format);
    vfprintf (stderr,format, argptr);
    va_end(argptr);
   
}

