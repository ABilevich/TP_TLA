%{
#include "parser.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define YYDEBUGGING 1

#define HEADER_FILE "header.aux"
#define DEFAULT_OUTFILE "index.html"
#define FOOTER_FILE "footer.aux"

#ifdef DEBUG_TRUE
  #define DEBUGGING 1
#else
  #define DEBUGGING 0
#endif
void appendFiles(char source[], FILE * fd2);
int yylex();
void yyerror(const char *s);

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
%token ADDBODY PRINT READ

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
%type <string> read
%type <string> print
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
        if(DEBUGGING) printf("main\n");
        char * s = malloc(strlen($5)+1);
          if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"\n%s\n",$5);
        fprintf(yyout,"%s",s);
    }
    ;

statement_list: statement {
    if(DEBUGGING) printf("statement: %s\n",$1);
        char * s = malloc(strlen($1)+2);
        sprintf(s,"%s\n",$1);
        $$ = s;
    }
    |   statement_list statement {
        if(DEBUGGING) printf("statement: %s\n",$2);
        // printf("statement list: %s\n",$1);
        // printf("statement: %s\n",$2);
        // char *s = malloc(strlen($$) +strlen($2) +3);
        // sprintf(s,"%s\t%s\n",$$,$2);    
        char *s = $$;
        strcat(s,$2);
        strcat(s,"\n");
        $$ =s;
    }
    ;

statement: 

    data_type NAME '=' exp {
    
        if($1->type != $4->type){
              yyerror("invalid type assignment.");
        }

        $2->type = $1->type;
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
        if(DEBUGGING) printf("statement system %s\n",$1);
        $$ = $1;
    }
    | config {
        if(DEBUGGING) printf("statement config %s\n",$1);
        $$ = $1;
    }
    | print {
        if(DEBUGGING) printf("statement print\n");
        $$ = $1;

    }
    | read {
        if(DEBUGGING) printf("statement read\n");
        $$ = $1;

    }
    | if_statement {
        if(DEBUGGING) printf("statement If\n");
        $$ = $1;

    }
    | while_statement {
        if(DEBUGGING) printf("statement while\n");
        $$ = $1;

    }
    | NUM_ARR_NAME '[' num_exp ']'  '=' num_exp {
        if(DEBUGGING) printf("statement num array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | STR_ARR_NAME '[' num_exp ']'  '=' str_exp {
        if(DEBUGGING) printf("statement str array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +8);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | BOOL_ARR_NAME '[' num_exp ']' '=' bool_exp {
        if(DEBUGGING) printf("statement bool array\n");
        char *s = malloc(strlen($1->name) + strlen($3) + strlen($6) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",$1->name,$3,$6);
        $$ = s;
    }
    | NUM_NAME '=' num_exp {
        if(DEBUGGING) printf("statement num eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }
    | STR_NAME '=' str_exp {
        if(DEBUGGING) printf("statement str eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }
    | BOOL_NAME '=' bool_exp {
        if(DEBUGGING) printf("statement bool eq\n");
        char *s = malloc(strlen($1->name) + strlen($3) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s = %s",$1->name,$3);
        $$ = s;
    }
    ;

data_type: TYPE_STR {
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = STR_TYPE;
        aux->sval = "str";
        $$ = aux; 
 
    }
    | TYPE_NUM { 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = NUM_TYPE;
         aux->sval = "num";
        $$ = aux; 
    }
    | TYPE_BOOL { 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = BOOL_TYPE;
        aux->sval = "bool";
        $$ = aux; 
    }
    ;

if_statement: IF '(' bool_exp ')' '{' statement_list '}' %prec LOWER_THAN_ELSE {
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
    char * s  = malloc(17+strlen($3)+strlen($6));
    if(s == NULL){
        yyerror("no memory left");
    }
        sprintf(s,"while( %s ) {\n%s}",$3,$6);
        $$ = s;
    }
    ;

exp: num_exp { 
       
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = NUM_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | str_exp { 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = STR_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    | bool_exp { 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = BOOL_TYPE;
        aux->sval = $1;
        $$ = aux;
    }
    ;

    
num_exp: num_exp '+' num_exp {
        $$ = expOp($1,"+",$3);
    }
    | num_exp '-' num_exp {
        $$ = expOp($1,"-",$3);
    }
    | num_exp '/' num_exp {
        if(!strcmp($3,"0")){
            yyerror("division by zero.");
        }
        $$ = expOp($1,"/",$3);
    }
    | num_exp '*' num_exp {
        $$ = expOp($1,"*",$3);
    }
    | '-' num_exp %prec UMINUS {
        char *s = malloc(strlen($2) +2);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"-%s",$2);
                
        $$ = s;
    }
    | '(' num_exp ')' {
        char *s = malloc(strlen($2) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"(%s)",$2);
                
        $$ = s;
    }
    | NUM_ARR_NAME '[' num_exp ']' {
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    | NUM_NAME {
        $$ = strdup($1->name);
    }
    | INTEGER {
    }
    | FLOAT {
    }
    ;
    
str_exp: QSTRING {

    }

    | str_exp '+' str_exp {
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }

    | num_exp '+' str_exp {
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }
                    
    | str_exp '+' num_exp {
        char * str = malloc(strlen($1) + strlen($3) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",$1,$3);
        $$ = str;
    }

    | STR_ARR_NAME '[' num_exp ']' {
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    | STR_NAME {
        $$ = strdup($1->name);
    }
    ;

bool_exp: bool_exp AND bool_exp {
        char * str = malloc(strlen($1) + strlen($3) + strlen("&&") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s && %s",$1,$3);
        $$ = str;
    }
    |   bool_exp OR bool_exp {
        char * str = malloc(strlen($1) + strlen($3) + strlen("||") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s || %s",$1,$3);
        $$ = str;
    }
    |   NOT bool_exp {
        char * str = malloc(strlen($2) + strlen("!") + 1);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"!%s",$2);
        $$ = str;
    }
    |   num_exp COMPARATION num_exp {
        char *str = malloc(strlen($1) + strlen($3) + strlen($2) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s %s %s",$1, $2, $3);
        $$ = str;
    }
    |   '(' bool_exp ')' {
        char *str = malloc(strlen($2) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"(%s)",$2);
        $$ = str;
        
    }
    |   BOOL_ARR_NAME '[' num_exp ']' {
        char *s = malloc(strlen($1->name) + strlen($3) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",$1->name,$3);
                
        $$ = s;
    }
    |   BOOL_NAME {
            $$ = strdup($1->name);
    }
    |   TRUE_TK { 
    
        if(DEBUGGING) printf("TRUE\n");
            $$ = strdup("true");
    }
    |   FALSE_TK{
         $$ = strdup("false");
    }
    ;


arr_init: '[' arr_item ']' {
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        printf("array_init type %d\n",$$->type);
        aux->type = $2->type;
        aux->sval = $2->sval;
        $$ = aux;
    }
    ; 

arr_item: exp {
        struct exp_t* aux = malloc(sizeof(struct exp_t));
         if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = $1->type;
        aux->sval = $1->sval;
        $$ = aux;
    } 
    |  exp ',' arr_item {
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
           if(DEBUGGING) printf("system\n");
           $$ = $3;
        }
    ;

system_action: ADDBODY '(' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' str_exp ')' { 
            char *s = malloc(strlen($3) + strlen($5) + strlen($7) + strlen($9) + strlen($11) + strlen($13) + strlen($15) + strlen("bodies.push(new Body(,,,,,,))")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"bodies.push(new Body(%s,%s,%s,%s,%s,%s,%s))",$3,$5,$7,$9,$11,$13,$15); 
            $$ = s; 
        }
    ;
    
config: CONFIG_TOKEN '.' config_action { 
        if(DEBUGGING) printf("config\n");
         $$ = $3;
    }
    ;

config_action: GRAVITY_CONF '(' num_exp ')' { 
            char *s = malloc(strlen($3) + strlen("Gc = ")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"Gc = %s",$3);
            $$ = s;
        }
        | BOUNCE_CONF '(' bool_exp ')' {
            char *s = malloc(strlen($3) + strlen("worldBorderBounce = ") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"worldBorderBounce = %s",$3);
            $$ = s;
        }
    ;

print: PRINT '(' exp ')' {
          
            char *s = malloc(strlen($3->sval) + strlen("console.log()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"console.log(%s)",$3->sval); 
            $$ = s; 
        }
    ;

read:  READ '(' str_exp ')' { 
           
            char *s = malloc(strlen($3) + strlen("window.prompt()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"window.prompt(%s)",$3); 
            $$ = s; 
        }
    ;

%%


struct symtab * symLook(char* s){
    struct symtab * sp;
    for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){
        /* is it alreaw here? */
        if (sp->name && !strcmp((sp->name)+2, s) ){
            return sp;
        }
      
        /* is it free */
        if(!sp->name) {
            char * snew = malloc(sizeof(s)+3);
            sprintf(snew, "u_%s", s);
            sp->name = snew;
            sp->type = NOT_DEFINED;
            return sp;
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
   
    addFunc("sqrt",sqrt);
    addFunc("exp",exp);
    addFunc("log",log);
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

    

    yyout = fopen(DEFAULT_OUTFILE,"a");
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
 

void yyerror(const char *s)
{
    fprintf (stderr,"\x1b[31m" "Error: %s\n" "\x1b[0m", s);
    exit(1);
}


