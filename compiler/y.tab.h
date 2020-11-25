/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NAME = 258,
    NUM_NAME = 259,
    STR_NAME = 260,
    BOOL_NAME = 261,
    NUM_ARR_NAME = 262,
    STR_ARR_NAME = 263,
    BOOL_ARR_NAME = 264,
    INTEGER = 265,
    FLOAT = 266,
    QSTRING = 267,
    COMPARATION = 268,
    MAIN = 269,
    NEW_LINE = 270,
    TAB = 271,
    IF = 272,
    ELSE = 273,
    WHILE = 274,
    SYSTEM_TOKEN = 275,
    CONFIG_TOKEN = 276,
    TYPE_STR = 277,
    TYPE_NUM = 278,
    TYPE_BOOL = 279,
    TRUE_TK = 280,
    FALSE_TK = 281,
    GRAVITY_CONF = 282,
    BOUNCE_CONF = 283,
    ADDBODY = 284,
    PRINT = 285,
    READ = 286,
    OR = 287,
    AND = 288,
    NOT = 289,
    UMINUS = 290,
    LOWER_THAN_ELSE = 291
  };
#endif
/* Tokens.  */
#define NAME 258
#define NUM_NAME 259
#define STR_NAME 260
#define BOOL_NAME 261
#define NUM_ARR_NAME 262
#define STR_ARR_NAME 263
#define BOOL_ARR_NAME 264
#define INTEGER 265
#define FLOAT 266
#define QSTRING 267
#define COMPARATION 268
#define MAIN 269
#define NEW_LINE 270
#define TAB 271
#define IF 272
#define ELSE 273
#define WHILE 274
#define SYSTEM_TOKEN 275
#define CONFIG_TOKEN 276
#define TYPE_STR 277
#define TYPE_NUM 278
#define TYPE_BOOL 279
#define TRUE_TK 280
#define FALSE_TK 281
#define GRAVITY_CONF 282
#define BOUNCE_CONF 283
#define ADDBODY 284
#define PRINT 285
#define READ 286
#define OR 287
#define AND 288
#define NOT 289
#define UMINUS 290
#define LOWER_THAN_ELSE 291

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 35 "parser2.y"

    char* string;
    struct symtab* symp;
    struct exp_t* exp_type;

#line 135 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
