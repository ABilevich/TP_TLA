%{
#include "parser.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define YYDEBUG 1
#define DEFAULT_OUTFILE "script.js"
int yylex();
void yyerror(const char *s);

extern FILE *yyin, *yyout;


%}

%union{
    char* string;
    struct symtab* symp;
}

%token <symp> NAME
%token <string> NUMBER
%token <string>QSTRING

%token <string> COMPARATION
%token MAIN NEW_LINE TAB PRINT IF ELSE WHILE OR AND NOT GT LT GE LE EQ NEQ SYSTEM CONFIG NUM_TYPE STR_T 

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

%type <string> num_exp
%type <string> statement
%type <string> statement_list
%type <string> print_func
%%


start:  /*empty */
        |  MAIN '(' ')' '{' statement_list '}'  {fprintf(yyout,"%s",$1);}
        ;

statement_list: statement { $$ = $1;}
        |     statement_list statement {
                char *s = $$;
                strcat(s,$2);
                // free($2);
                $$ =s;
            }
        ;

statement: NAME '=' num_exp  ';' {   
                char *s = malloc(strlen($1->name) + strlen($3) +5);
                if(s == NULL){
                    yyerror("no memory left");
                }
                sprintf(s,"%s = %s;\n",$1->name,$3);
                // free($3);
                $$ = s;
        }
        | IF '(' num_exp ')' '{' statement_list '}' %prec LOWER_THAN_ELSE {
            char * s  = malloc(7+strlen($3)+strlen($6));
             if(s == NULL){
                    yyerror("no memory left");
                }
            sprintf(s,"if( %s ) {\n%s}",$3,$6);
            //    free($3);
            //    free($6);
            $$ = s;
        }
        | IF '(' num_exp ')' '{' statement_list '}' ELSE '{' statement_list '}'  {
           char * s  = malloc(7+strlen($3)+strlen($6)+strlen($10));
            if(s == NULL){
                    yyerror("no memory left");
                }
           sprintf(s,"if( %s ) {\n%s}else{\n%s}",$3,$6,$10);
        //    free($3);
        //    free($6);
        //    free($10);
            $$ = s;
        }
        | WHILE '(' num_exp ')' '{' statement_list '}'  {
           char * s  = malloc(7+strlen($3)+strlen($6));
            if(s == NULL){
                    yyerror("no memory left");
                }
           sprintf(s,"while( %s ) {\n%s}",$3,$6);
        //    free($3);
        //    free($6);
            $$ = s;
        }
        | print_func ';' {
            char *s = malloc(strlen($1) +3);
             if(s == NULL){
                    yyerror("no memory left");
                }
            sprintf(s,"%s;\n",$1);
            //free($1);
            $$ = s;
        }
        
        ;


system:
        SYSTEM ADDBODY '(' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' num_exp ',' str_exp ')' {
            //hacer algo
        }
    ;

config:
        CONFIG GRAVITY '(' num_exp ')'{

        } | CONFIG WINDOW_BOUNCE '(' num_exp ')'{
            
        }
    ;

num_exp: num_exp '+' num_exp                { $$ = expOp($1,"+",$3); }
        | num_exp '-' num_exp               { $$ = expOp($1,"-",$3); }
        | num_exp '/' num_exp               { $$ = expOp($1,"/",$3); }
        | num_exp '*' num_exp               { $$ = expOp($1,"*",$3); }
        | num_exp COMPARATION num_exp       { $$ = expOp($1,$2,$3); }
        | num_exp AND num_exp               { $$ = expOp($1,"&&",$3); }
        | num_exp OR num_exp                { $$ = expOp($1,"||",$3); }
        | NOT num_exp { 
                char *s = malloc(strlen($2) +2);
                if(s == NULL){
                    yyerror("no memory left");
                }
                sprintf(s,"!%s",$2);
                $$ = s;
        }
        | '-' num_exp %prec UMINUS { 
                char *s = malloc(strlen($2) +2);
                if(s == NULL){
                    yyerror("no memory left");
                }
                sprintf(s,"-%s",$2);
                $$ = s;
        }
        |   '(' num_exp ')'      { 
                char *s = malloc(strlen($2) +3);
                if(s == NULL){
                    yyerror("no memory left");
                }
                sprintf(s,"(%s)",$2);
               
                $$ = s;
        }
        |   NAME '(' num_exp ')' {
                if($1->funcptr){
                    char *s = malloc(strlen($1->name) + strlen($3) +3);
                    if(s == NULL){
                        yyerror("no memory left");
                    }
                    sprintf(s,"%s(%s)",$1->name,$3);
                
                    $$ = s;
                
                }else{
                    printf("%s is not a function\n",$1->name);
                    $$ = 0;
                }
        }
        |   NUMBER 
        |   NAME { $$ = strdup($1->name);}
   
        ;



bool_exp:



print_func:  PRINT '(' num_exp ')' {
            char *s = malloc(15 + strlen($3));
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"console.log(%s)",$3);
            $$ = s;
        }
        |    PRINT '(' QSTRING ')' {
            char *s = malloc(15 + strlen($3));
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"console.log(\"%s\")",$3);
            $$ = s;
        }
        ;

%%
// void symAdd(char *name){
//     struct symtab * sp;
//     for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){
  
//         /* is it free */
//         if(!sp->name) {
//             sp->name = strdup(s);
//             return;
//         }
//         /* otherwise continue to next */
//     }
//     yyerror("Too much symbols");
//     exit(1);
// }

struct symtab * symLook(char* s){
    struct symtab * sp;
    for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){
        /* is it alreaw here? */
        if (sp->name && !strcmp(sp->name, s) ){
            return sp;
        }
      
        /* is it free */
        if(!sp->name) {
            sp->name = strdup(s);
          
            return sp;
        }
        /* otherwise continue to next */
    }
     yyerror("Too much symbols");
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
    char * outfile;
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
 
    outfile = DEFAULT_OUTFILE;

    yyout = fopen(outfile,"w+");
    if(yyout == NULL){
        fprintf(stderr,"%s: cannot open %s\n",progname,outfile);
        exit(1);
    }
    yyparse();
  
    fclose(yyin);
    fclose(yyout);
    exit(0);
    // while(!feof(yyin)){
    //     yyparse();
    // }
  
    return 0;
}


void yyerror(const char *s)
{
    fprintf (stderr, "%s\n", s);
}

