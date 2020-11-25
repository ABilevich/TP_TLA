#ifndef PARSER_H
#define PARSER_H

#define MAX_SYMBOLS 50 // Maximum number of symbols

enum var_type{NOT_DEFINED,NUM_TYPE,STR_TYPE,BOOL_TYPE,NUM_ARR_TYPE,STR_ARR_TYPE,BOOL_ARR_TYPE};

struct symtab
{
    char *name;
    double (*funcptr)();
    enum var_type type;

} symtab[MAX_SYMBOLS];

struct exp_t{
 char * sval;
 enum var_type type;   
};


struct symtab *symLook(char *s);
void symAdd(char *name);
void addFunc(char *name, double (*func)());
char *expOp(char *exp1, char *op, char *exp2);
void appendStmList(char *dest, char *stm_list);
#endif // MACRO
