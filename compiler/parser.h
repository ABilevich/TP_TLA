#ifndef PARSER_H
#define PARSER_H

#define MAX_SYMBOLS 50 // Maximum number of symbols

enum var_type
{
    NUM_TYPE,
    STR_TYPE,
    BOOL_TYPE,
    NUM_ARR_TYPE,
    STR_ARR_TYPE,
    BOOL_ARR_TYPE
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

struct symtab * symSave(char *s,enum var_type type);
// void addFunc(char *name, double (*func)());
char *expOp(char *exp1, char *op, char *exp2);
#endif // MACRO
