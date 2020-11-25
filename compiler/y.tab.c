/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "parser2.y"

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
extern FILE *yyin, *yyout;



#line 104 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
    READ_STR = 286,
    READ_NUM = 287,
    OR = 288,
    AND = 289,
    NOT = 290,
    UMINUS = 291,
    LOWER_THAN_ELSE = 292
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
#define READ_STR 286
#define READ_NUM 287
#define OR 288
#define AND 289
#define NOT 290
#define UMINUS 291
#define LOWER_THAN_ELSE 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 35 "parser2.y"

    char* string;
    struct symtab* symp;
    struct exp_t* exp_type;

#line 236 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   397

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  51
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  20
/* YYNRULES -- Number of rules.  */
#define YYNRULES  67
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  180

#define YYUNDEFTOK  2
#define YYMAXUTOK   292


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      42,    43,    38,    37,    49,    36,    50,    39,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    46,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    47,     2,    48,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    44,     2,    45,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    40,    41
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    88,    88,    89,   100,   106,   121,   135,   167,   171,
     175,   179,   183,   187,   191,   195,   204,   213,   222,   232,
     242,   253,   261,   268,   277,   288,   302,   313,   323,   333,
     346,   350,   354,   361,   365,   375,   385,   395,   399,   402,
     405,   411,   415,   425,   435,   445,   455,   460,   466,   475,
     484,   493,   502,   511,   521,   525,   529,   536,   549,   559,
     581,   587,   598,   604,   613,   624,   636,   648
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "NAME", "NUM_NAME", "STR_NAME",
  "BOOL_NAME", "NUM_ARR_NAME", "STR_ARR_NAME", "BOOL_ARR_NAME", "INTEGER",
  "FLOAT", "QSTRING", "COMPARATION", "MAIN", "NEW_LINE", "TAB", "IF",
  "ELSE", "WHILE", "SYSTEM_TOKEN", "CONFIG_TOKEN", "TYPE_STR", "TYPE_NUM",
  "TYPE_BOOL", "TRUE_TK", "FALSE_TK", "GRAVITY_CONF", "BOUNCE_CONF",
  "ADDBODY", "PRINT", "READ_STR", "READ_NUM", "OR", "AND", "NOT", "'-'",
  "'+'", "'*'", "'/'", "UMINUS", "LOWER_THAN_ELSE", "'('", "')'", "'{'",
  "'}'", "'='", "'['", "']'", "','", "'.'", "$accept", "start",
  "statement_list", "statement", "data_type", "if_statement",
  "while_statement", "exp", "num_exp", "str_exp", "bool_exp", "arr_init",
  "arr_item", "system", "system_action", "config", "config_action",
  "print", "read_str", "read_num", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,    45,    43,    42,    47,
     291,   292,    40,    41,   123,   125,    61,    91,    93,    44,
      46
};
# endif

#define YYPACT_NINF (-108)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      -8,   -21,    13,    12,  -108,    30,   365,    26,    40,    48,
      44,    58,    61,    36,    78,    71,    72,  -108,  -108,  -108,
     108,   109,   110,   177,  -108,   126,  -108,  -108,  -108,  -108,
    -108,  -108,  -108,    31,   326,   293,   149,   151,   154,   293,
     293,   143,     6,    18,   326,   326,  -108,  -108,     5,  -108,
     127,  -108,  -108,    31,    31,   224,  -108,  -108,   130,  -108,
     238,   142,  -108,  -108,   140,  -108,  -108,   293,   293,    74,
      28,   145,   147,   169,   -25,    32,   146,  -108,   208,   222,
    -108,   181,    80,   142,    28,   -33,   -23,    18,   230,    31,
    -108,   132,    31,    31,    31,    31,    31,   326,   326,    31,
    -108,    45,    46,    31,   293,   293,   233,   236,   247,   254,
     270,    31,    31,   293,  -108,  -108,  -108,  -108,   275,   253,
    -108,    65,    65,  -108,  -108,   269,    65,  -108,   118,  -108,
     274,  -108,   224,   281,  -108,    31,   326,   293,   365,   365,
      87,   210,    94,   273,  -108,  -108,  -108,   224,   142,    28,
     206,   235,    31,  -108,  -108,    18,  -108,   298,  -108,   104,
     277,   276,   279,    31,    18,  -108,   365,   153,  -108,   264,
      31,  -108,   167,    31,   182,    31,   196,   326,    27,  -108
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     0,     1,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    21,    22,    23,
       0,     0,     0,     0,     4,     0,    13,    14,     8,     9,
      10,    11,    12,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     3,     5,     0,    37,
       0,    38,    39,     0,     0,    18,    40,    46,     0,    41,
       0,    19,    47,    54,     0,    55,    56,     0,     0,     0,
      20,     0,     0,     0,     0,     0,     0,    60,     0,     0,
      62,     0,    27,    28,    29,     0,     0,     0,     0,     0,
      34,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      50,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    65,    66,    67,     6,     0,     0,
      35,    31,    30,    33,    32,     0,    30,    43,    44,    42,
       0,    52,    51,    49,    48,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    36,    45,    53,    15,    16,    17,
       0,     0,     0,    63,    64,     0,     7,    24,    26,     0,
      58,     0,     0,     0,     0,    57,     0,     0,    59,     0,
       0,    25,     0,     0,     0,     0,     0,     0,     0,    61
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -108,  -108,  -107,   -20,  -108,  -108,  -108,   -42,     3,   -29,
     -28,  -108,   163,  -108,  -108,  -108,  -108,  -108,    -6,    -4
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,    23,    24,    25,    26,    27,   160,    69,    83,
      84,   156,   161,    28,    77,    29,    80,    30,    62,    56
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      31,    81,    32,    47,    98,    61,     1,    70,   104,   105,
     115,    74,    75,     4,    98,    85,    86,    31,   109,    32,
     116,     3,    49,    57,    63,    50,    58,    64,    51,    52,
      59,   150,   151,    78,    79,    49,    55,    60,    50,   100,
     102,    51,    52,    65,    66,   117,    82,    60,    60,    21,
      22,    87,    88,    67,    53,     5,    90,    91,   103,   169,
      68,   104,   105,    22,    98,   104,   105,    53,   127,   129,
     179,   101,    33,    54,     6,   110,   133,   134,    39,   104,
     105,    92,    93,    94,    95,   142,    34,   103,   120,   131,
      82,    36,   119,   103,    35,   121,   122,   123,   124,   125,
     126,   128,   130,    94,    95,    37,   132,   148,    38,   149,
      92,    93,    94,    95,   140,   141,    92,    97,    94,    95,
      40,    41,    42,    92,    93,    94,    95,   104,   105,    48,
      47,    47,    31,    31,    32,    32,   152,   154,   147,    60,
      92,    93,    94,    95,    31,    31,    32,    32,   178,    47,
      43,    44,    45,   163,    92,   159,    94,    95,    82,    71,
      31,    72,    32,    31,    73,    32,   167,    82,    92,    93,
      94,    95,    76,   172,    89,   120,   174,    96,   176,    98,
      60,     7,     8,     9,    10,    11,    12,    99,   111,    92,
      93,    94,    95,   106,    13,   107,    14,    15,    16,    17,
      18,    19,   170,    92,    93,    94,    95,    20,    21,    22,
       7,     8,     9,    10,    11,    12,   173,   108,    92,    93,
      94,    95,    46,    13,   114,    14,    15,    16,    17,    18,
      19,   175,    92,    93,    94,    95,    20,    21,    22,     7,
       8,     9,    10,    11,    12,   177,    92,    93,    94,    95,
     112,   157,    13,   153,    14,    15,    16,    17,    18,    19,
      92,    93,    94,    95,   113,    20,    21,    22,     7,     8,
       9,    10,    11,    12,    92,    97,    94,    95,   118,   135,
     158,    13,   136,    14,    15,    16,    17,    18,    19,    92,
      93,    94,    95,   137,    20,    21,    22,    49,   138,    63,
      50,   144,    64,    51,    52,    92,    93,    94,    95,   171,
      92,    93,    94,    95,   139,   105,   162,   145,    65,    66,
     155,   143,   146,   166,   165,    22,   164,   168,    67,    53,
      49,    57,     0,    50,    58,    68,    51,    52,    59,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    21,    22,     0,
       0,     0,    53,     0,     0,     0,     0,     0,    54,     7,
       8,     9,    10,    11,    12,     0,     0,     0,     0,     0,
       0,     0,    13,     0,    14,    15,    16,    17,    18,    19,
       0,     0,     0,     0,     0,    20,    21,    22
};

static const yytype_int16 yycheck[] =
{
       6,    43,     6,    23,    37,    34,    14,    35,    33,    34,
      43,    39,    40,     0,    37,    44,    45,    23,    43,    23,
      43,    42,     4,     5,     6,     7,     8,     9,    10,    11,
      12,   138,   139,    27,    28,     4,    33,    34,     7,    67,
      68,    10,    11,    25,    26,    87,    43,    44,    45,    31,
      32,    46,    47,    35,    36,    43,    53,    54,    13,   166,
      42,    33,    34,    32,    37,    33,    34,    36,    97,    98,
      43,    68,    46,    42,    44,    43,   104,   105,    42,    33,
      34,    36,    37,    38,    39,   113,    46,    13,    43,    43,
      87,    47,    89,    13,    46,    92,    93,    94,    95,    96,
      97,    98,    99,    38,    39,    47,   103,   136,    47,   137,
      36,    37,    38,    39,   111,   112,    36,    37,    38,    39,
      42,    50,    50,    36,    37,    38,    39,    33,    34,     3,
     150,   151,   138,   139,   138,   139,    49,    43,   135,   136,
      36,    37,    38,    39,   150,   151,   150,   151,   177,   169,
      42,    42,    42,    49,    36,   152,    38,    39,   155,    10,
     166,    10,   166,   169,    10,   169,   163,   164,    36,    37,
      38,    39,    29,   170,    47,    43,   173,    47,   175,    37,
     177,     4,     5,     6,     7,     8,     9,    47,    42,    36,
      37,    38,    39,    48,    17,    48,    19,    20,    21,    22,
      23,    24,    49,    36,    37,    38,    39,    30,    31,    32,
       4,     5,     6,     7,     8,     9,    49,    48,    36,    37,
      38,    39,    45,    17,    43,    19,    20,    21,    22,    23,
      24,    49,    36,    37,    38,    39,    30,    31,    32,     4,
       5,     6,     7,     8,     9,    49,    36,    37,    38,    39,
      42,    45,    17,    43,    19,    20,    21,    22,    23,    24,
      36,    37,    38,    39,    42,    30,    31,    32,     4,     5,
       6,     7,     8,     9,    36,    37,    38,    39,    48,    46,
      45,    17,    46,    19,    20,    21,    22,    23,    24,    36,
      37,    38,    39,    46,    30,    31,    32,     4,    44,     6,
       7,    48,     9,    10,    11,    36,    37,    38,    39,    45,
      36,    37,    38,    39,    44,    34,    18,    48,    25,    26,
      47,    46,    48,    44,    48,    32,    49,   164,    35,    36,
       4,     5,    -1,     7,     8,    42,    10,    11,    12,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    31,    32,    -1,
      -1,    -1,    36,    -1,    -1,    -1,    -1,    -1,    42,     4,
       5,     6,     7,     8,     9,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    17,    -1,    19,    20,    21,    22,    23,    24,
      -1,    -1,    -1,    -1,    -1,    30,    31,    32
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    14,    52,    42,     0,    43,    44,     4,     5,     6,
       7,     8,     9,    17,    19,    20,    21,    22,    23,    24,
      30,    31,    32,    53,    54,    55,    56,    57,    64,    66,
      68,    69,    70,    46,    46,    46,    47,    47,    47,    42,
      42,    50,    50,    42,    42,    42,    45,    54,     3,     4,
       7,    10,    11,    36,    42,    59,    70,     5,     8,    12,
      59,    60,    69,     6,     9,    25,    26,    35,    42,    59,
      61,    10,    10,    10,    61,    61,    29,    65,    27,    28,
      67,    58,    59,    60,    61,    60,    60,    46,    47,    47,
      59,    59,    36,    37,    38,    39,    47,    37,    37,    47,
      61,    59,    61,    13,    33,    34,    48,    48,    48,    43,
      43,    42,    42,    42,    43,    43,    43,    58,    48,    59,
      43,    59,    59,    59,    59,    59,    59,    60,    59,    60,
      59,    43,    59,    61,    61,    46,    46,    46,    44,    44,
      59,    59,    61,    46,    48,    48,    48,    59,    60,    61,
      53,    53,    49,    43,    43,    47,    62,    45,    45,    59,
      58,    63,    18,    49,    49,    48,    44,    59,    63,    53,
      49,    45,    59,    49,    59,    49,    59,    49,    60,    43
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    51,    52,    52,    53,    53,    54,    54,    54,    54,
      54,    54,    54,    54,    54,    54,    54,    54,    54,    54,
      54,    55,    55,    55,    56,    56,    57,    58,    58,    58,
      59,    59,    59,    59,    59,    59,    59,    59,    59,    59,
      59,    60,    60,    60,    60,    60,    60,    60,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    62,    63,    63,
      64,    65,    66,    67,    67,    68,    69,    70
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     6,     1,     2,     4,     6,     1,     1,
       1,     1,     1,     1,     1,     6,     6,     6,     3,     3,
       3,     1,     1,     1,     7,    11,     7,     1,     1,     1,
       3,     3,     3,     3,     2,     3,     4,     1,     1,     1,
       1,     1,     3,     3,     3,     4,     1,     1,     3,     3,
       2,     3,     3,     4,     1,     1,     1,     3,     1,     3,
       3,    16,     3,     4,     4,     4,     4,     4
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 3:
#line 89 "parser2.y"
                                            {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN "main\n" ANSI_COLOR_RESET);
        char * s = malloc(strlen((yyvsp[-1].string))+1);
          if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"\n%s\n",(yyvsp[-1].string));
        fprintf(yyout,"%s",s);
    }
#line 1574 "y.tab.c"
    break;

  case 4:
#line 100 "parser2.y"
                          {
    if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement:"ANSI_COLOR_RESET "%s\n",(yyvsp[0].string));
        char * s = malloc(strlen((yyvsp[0].string))+2);
        sprintf(s,"%s\n",(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1585 "y.tab.c"
    break;

  case 5:
#line 106 "parser2.y"
                                 {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement:"ANSI_COLOR_RESET "%s\n",(yyvsp[0].string));
        // printf("statement list: %s\n",$1);
        // printf("statement: %s\n",$2);
        // char *s = malloc(strlen($$) +strlen($2) +3);
        // sprintf(s,"%s\t%s\n",$$,$2);    
        char *s = (yyval.string);
        strcat(s,(yyvsp[0].string));
        strcat(s,"\n");
        (yyval.string) =s;
    }
#line 1601 "y.tab.c"
    break;

  case 6:
#line 121 "parser2.y"
                           {
    
        if((yyvsp[-3].exp_type)->type != (yyvsp[0].exp_type)->type){
              yyerror("invalid type assignment.");
        }

        (yyvsp[-2].symp)->type = (yyvsp[-3].exp_type)->type;
        char *s = malloc(strlen((yyvsp[-2].symp)->name) + strlen((yyvsp[0].exp_type)->sval) + 8);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"let %s = %s",(yyvsp[-2].symp)->name,(yyvsp[0].exp_type)->sval);
        (yyval.string) = s;
    }
#line 1620 "y.tab.c"
    break;

  case 7:
#line 135 "parser2.y"
                                          {
         if((yyvsp[-5].exp_type)->type != (yyvsp[0].exp_type)->type){
              yyerror("invalid type assignment.");
              exit(1);
        }
        enum var_type type;

        switch((yyvsp[-5].exp_type)->type){
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
        
        (yyvsp[-4].symp)->type = type;
         
        char *s = malloc(strlen((yyvsp[-4].symp)->name) + strlen((yyvsp[0].exp_type)->sval) +8);
     
        if(s == NULL){
            yyerror("no memory left");
        }
  
        sprintf(s,"let %s = [%s]",(yyvsp[-4].symp)->name,(yyvsp[0].exp_type)->sval);
        (yyval.string) = s;
    }
#line 1657 "y.tab.c"
    break;

  case 8:
#line 167 "parser2.y"
             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET"system %s\n",(yyvsp[0].string));
        (yyval.string) = (yyvsp[0].string);
    }
#line 1666 "y.tab.c"
    break;

  case 9:
#line 171 "parser2.y"
             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "config %s\n",(yyvsp[0].string));
        (yyval.string) = (yyvsp[0].string);
    }
#line 1675 "y.tab.c"
    break;

  case 10:
#line 175 "parser2.y"
            {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "print\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 1684 "y.tab.c"
    break;

  case 11:
#line 179 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "read\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 1693 "y.tab.c"
    break;

  case 12:
#line 183 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "read\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 1702 "y.tab.c"
    break;

  case 13:
#line 187 "parser2.y"
                   {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "if\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 1711 "y.tab.c"
    break;

  case 14:
#line 191 "parser2.y"
                      {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "while\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 1720 "y.tab.c"
    break;

  case 15:
#line 195 "parser2.y"
                                                {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "num array\n");
        char *s = malloc(strlen((yyvsp[-5].symp)->name) + strlen((yyvsp[-3].string)) + strlen((yyvsp[0].string)) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",(yyvsp[-5].symp)->name,(yyvsp[-3].string),(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1734 "y.tab.c"
    break;

  case 16:
#line 204 "parser2.y"
                                                {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "str array\n");
        char *s = malloc(strlen((yyvsp[-5].symp)->name) + strlen((yyvsp[-3].string)) + strlen((yyvsp[0].string)) +8);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",(yyvsp[-5].symp)->name,(yyvsp[-3].string),(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1748 "y.tab.c"
    break;

  case 17:
#line 213 "parser2.y"
                                                 {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "bool array\n");
        char *s = malloc(strlen((yyvsp[-5].symp)->name) + strlen((yyvsp[-3].string)) + strlen((yyvsp[0].string)) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s] = %s",(yyvsp[-5].symp)->name,(yyvsp[-3].string),(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1762 "y.tab.c"
    break;

  case 18:
#line 222 "parser2.y"
                           {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "num eq\n");
        char *s = malloc(strlen((yyvsp[-2].symp)->name) + strlen((yyvsp[0].string)) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
          printf("%s = %s\n",(yyvsp[-2].symp)->name,(yyvsp[0].string));
        sprintf(s,"%s = %s",(yyvsp[-2].symp)->name,(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1777 "y.tab.c"
    break;

  case 19:
#line 232 "parser2.y"
                           {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "str eq\n");
        char *s = malloc(strlen((yyvsp[-2].symp)->name) + strlen((yyvsp[0].string)) +6);
        if(s == NULL){
            yyerror("no memory left");
        }
        printf("%s = %s\n",(yyvsp[-2].symp)->name,(yyvsp[0].string));
        sprintf(s,"%s = %s",(yyvsp[-2].symp)->name,(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1792 "y.tab.c"
    break;

  case 20:
#line 242 "parser2.y"
                             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"statement "ANSI_COLOR_RESET "bool eq\n");
        char *s = malloc(strlen((yyvsp[-2].symp)->name) + strlen((yyvsp[0].string)) +4);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s = %s",(yyvsp[-2].symp)->name,(yyvsp[0].string));
        (yyval.string) = s;
    }
#line 1806 "y.tab.c"
    break;

  case 21:
#line 253 "parser2.y"
                    {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_STR\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = STR_TYPE;
        aux->sval = "str";
        (yyval.exp_type) = aux; 
 
    }
#line 1819 "y.tab.c"
    break;

  case 22:
#line 261 "parser2.y"
               { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_NUM\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = NUM_TYPE;
         aux->sval = "num";
        (yyval.exp_type) = aux; 
    }
#line 1831 "y.tab.c"
    break;

  case 23:
#line 268 "parser2.y"
                { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"data_type: "ANSI_COLOR_RESET "TYPE_BOOL\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        aux->type = BOOL_TYPE;
        aux->sval = "bool";
        (yyval.exp_type) = aux; 
    }
#line 1843 "y.tab.c"
    break;

  case 24:
#line 277 "parser2.y"
                                                                               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if\n");
        char * s  = malloc( strlen("if(  ) {\n}") + strlen((yyvsp[-4].string)) + strlen((yyvsp[-1].string)) +1);
        if(s == NULL){
            yyerror("no memory left");
        }    
        sprintf(s,"if( %s ) {\n%s}",(yyvsp[-4].string),(yyvsp[-1].string));
        //    free($3);
        //    free($6);
        (yyval.string) = s;
    }
#line 1859 "y.tab.c"
    break;

  case 25:
#line 288 "parser2.y"
                                                                             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"if_statement: "ANSI_COLOR_RESET "if else\n");
        char * s  = malloc(strlen("if(  ) {\n}else{\n}") + strlen((yyvsp[-8].string)) + strlen((yyvsp[-5].string)) + strlen((yyvsp[-1].string)) + 1);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"if( %s ) {\n%s}else{\n%s}",(yyvsp[-8].string),(yyvsp[-5].string),(yyvsp[-1].string));
        //    free($3);
        //    free($6);
        //    free($10);
        (yyval.string) = s;
    }
#line 1876 "y.tab.c"
    break;

  case 26:
#line 302 "parser2.y"
                                                               {
    if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"while_statement: "ANSI_COLOR_RESET "while\n");
    char * s  = malloc(17+strlen((yyvsp[-4].string))+strlen((yyvsp[-1].string)));
    if(s == NULL){
        yyerror("no memory left");
    }
        sprintf(s,"while( %s ) {\n%s}",(yyvsp[-4].string),(yyvsp[-1].string));
        (yyval.string) = s;
    }
#line 1890 "y.tab.c"
    break;

  case 27:
#line 313 "parser2.y"
             { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "num exp\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = NUM_TYPE;
        aux->sval = (yyvsp[0].string);
        (yyval.exp_type) = aux;
    }
#line 1905 "y.tab.c"
    break;

  case 28:
#line 323 "parser2.y"
              { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "str exp\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = STR_TYPE;
        aux->sval = (yyvsp[0].string);
        (yyval.exp_type) = aux;
    }
#line 1920 "y.tab.c"
    break;

  case 29:
#line 333 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"exp: "ANSI_COLOR_RESET "bool exp\n"); 
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = BOOL_TYPE;
        aux->sval = (yyvsp[0].string);
        (yyval.exp_type) = aux;
    }
#line 1935 "y.tab.c"
    break;

  case 30:
#line 346 "parser2.y"
                             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "sum\n");
        (yyval.string) = expOp((yyvsp[-2].string),"+",(yyvsp[0].string));
    }
#line 1944 "y.tab.c"
    break;

  case 31:
#line 350 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "subs\n");
        (yyval.string) = expOp((yyvsp[-2].string),"-",(yyvsp[0].string));
    }
#line 1953 "y.tab.c"
    break;

  case 32:
#line 354 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "div\n");
        if(!strcmp((yyvsp[0].string),"0")){
            yyerror("division by zero.");
        }
        (yyval.string) = expOp((yyvsp[-2].string),"/",(yyvsp[0].string));
    }
#line 1965 "y.tab.c"
    break;

  case 33:
#line 361 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "mult\n");
        (yyval.string) = expOp((yyvsp[-2].string),"*",(yyvsp[0].string));
    }
#line 1974 "y.tab.c"
    break;

  case 34:
#line 365 "parser2.y"
                               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "negation\n");
        char *s = malloc(strlen((yyvsp[0].string)) +2);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"-%s",(yyvsp[0].string));
                
        (yyval.string) = s;
    }
#line 1989 "y.tab.c"
    break;

  case 35:
#line 375 "parser2.y"
                      {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "parenthesis\n");
        char *s = malloc(strlen((yyvsp[-1].string)) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"(%s)",(yyvsp[-1].string));
                
        (yyval.string) = s;
    }
#line 2004 "y.tab.c"
    break;

  case 36:
#line 385 "parser2.y"
                                   {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen((yyvsp[-3].symp)->name) + strlen((yyvsp[-1].string)) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",(yyvsp[-3].symp)->name,(yyvsp[-1].string));
                
        (yyval.string) = s;
    }
#line 2019 "y.tab.c"
    break;

  case 37:
#line 395 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "variable\n");
        (yyval.string) = strdup((yyvsp[0].symp)->name);
    }
#line 2028 "y.tab.c"
    break;

  case 38:
#line 399 "parser2.y"
              {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "integer\n");
    }
#line 2036 "y.tab.c"
    break;

  case 39:
#line 402 "parser2.y"
            {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "float\n");
    }
#line 2044 "y.tab.c"
    break;

  case 40:
#line 405 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"num_exp: "ANSI_COLOR_RESET "read_num\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 2053 "y.tab.c"
    break;

  case 41:
#line 411 "parser2.y"
                 {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "qstring\n");
    }
#line 2061 "y.tab.c"
    break;

  case 42:
#line 415 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition str str\n");
        char * str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",(yyvsp[-2].string),(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2075 "y.tab.c"
    break;

  case 43:
#line 425 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition num str\n");
        char * str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",(yyvsp[-2].string),(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2089 "y.tab.c"
    break;

  case 44:
#line 435 "parser2.y"
                          {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "addition str num\n");
        char * str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + 4);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s + %s",(yyvsp[-2].string),(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2103 "y.tab.c"
    break;

  case 45:
#line 445 "parser2.y"
                                   {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen((yyvsp[-3].symp)->name) + strlen((yyvsp[-1].string)) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",(yyvsp[-3].symp)->name,(yyvsp[-1].string));
                
        (yyval.string) = s;
    }
#line 2118 "y.tab.c"
    break;

  case 46:
#line 455 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "variable\n");
        printf("string name = %s\n",(yyvsp[0].symp)->name);
        (yyval.string) = strdup((yyvsp[0].symp)->name);
    }
#line 2128 "y.tab.c"
    break;

  case 47:
#line 460 "parser2.y"
               {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"str_exp: "ANSI_COLOR_RESET "read_str\n");
        (yyval.string) = strdup((yyvsp[0].string));
    }
#line 2137 "y.tab.c"
    break;

  case 48:
#line 466 "parser2.y"
                                {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "and\n");
        char * str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + strlen("&&") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s && %s",(yyvsp[-2].string),(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2151 "y.tab.c"
    break;

  case 49:
#line 475 "parser2.y"
                             {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "or\n");
        char * str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + strlen("||") + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s || %s",(yyvsp[-2].string),(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2165 "y.tab.c"
    break;

  case 50:
#line 484 "parser2.y"
                     {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "not\n");
        char * str = malloc(strlen((yyvsp[0].string)) + strlen("!") + 1);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"!%s",(yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2179 "y.tab.c"
    break;

  case 51:
#line 493 "parser2.y"
                                    {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "comparation\n");
        char *str = malloc(strlen((yyvsp[-2].string)) + strlen((yyvsp[0].string)) + strlen((yyvsp[-1].string)) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"%s %s %s",(yyvsp[-2].string), (yyvsp[-1].string), (yyvsp[0].string));
        (yyval.string) = str;
    }
#line 2193 "y.tab.c"
    break;

  case 52:
#line 502 "parser2.y"
                         {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "parenthesis\n");
        char *str = malloc(strlen((yyvsp[-1].string)) + 3);
        if(str == NULL){
            yyerror("No memory left");
        }
        sprintf(str,"(%s)",(yyvsp[-1].string));
        (yyval.string) = str;
    }
#line 2207 "y.tab.c"
    break;

  case 53:
#line 511 "parser2.y"
                                      {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "arr access\n");
        char *s = malloc(strlen((yyvsp[-3].symp)->name) + strlen((yyvsp[-1].string)) +3);
        if(s == NULL){
            yyerror("no memory left");
        }
        sprintf(s,"%s[%s]",(yyvsp[-3].symp)->name,(yyvsp[-1].string));
                
        (yyval.string) = s;
    }
#line 2222 "y.tab.c"
    break;

  case 54:
#line 521 "parser2.y"
                  {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "variable\n");
            (yyval.string) = strdup((yyvsp[0].symp)->name);
    }
#line 2231 "y.tab.c"
    break;

  case 55:
#line 525 "parser2.y"
                { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "true\n");
        (yyval.string) = strdup("true");
    }
#line 2240 "y.tab.c"
    break;

  case 56:
#line 529 "parser2.y"
                {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"bool_exp: "ANSI_COLOR_RESET "false\n");
         (yyval.string) = strdup("false");
    }
#line 2249 "y.tab.c"
    break;

  case 57:
#line 536 "parser2.y"
                           {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_init: "ANSI_COLOR_RESET "new arr\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
        if(aux == NULL){
            yyerror("no memory left");
        }
       
        aux->type = (yyvsp[-1].exp_type)->type;
        aux->sval = (yyvsp[-1].exp_type)->sval;
        (yyval.exp_type) = aux;
    }
#line 2265 "y.tab.c"
    break;

  case 58:
#line 549 "parser2.y"
              {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "last arr item\n");
        struct exp_t* aux = malloc(sizeof(struct exp_t));
         if(aux == NULL){
            yyerror("no memory left");
        }
        aux->type = (yyvsp[0].exp_type)->type;
        aux->sval = (yyvsp[0].exp_type)->sval;
        (yyval.exp_type) = aux;
    }
#line 2280 "y.tab.c"
    break;

  case 59:
#line 559 "parser2.y"
                        {
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"arr_item: "ANSI_COLOR_RESET "new arr item\n");
            if((yyvsp[-2].exp_type)->type != (yyvsp[0].exp_type)->type){
                yyerror("invalid type for array item");
            }
            struct exp_t* aux = malloc(sizeof(struct exp_t));
            if(aux == NULL){
                yyerror("no memory left");
            }
            aux->type = (yyvsp[-2].exp_type)->type;
            char * s = malloc(strlen((yyvsp[-2].exp_type)->sval) + strlen((yyvsp[0].exp_type)->sval) + 2);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"%s, %s",(yyvsp[-2].exp_type)->sval,(yyvsp[0].exp_type)->sval);
            aux->sval = s;
            (yyval.exp_type) = aux;
        }
#line 2303 "y.tab.c"
    break;

  case 60:
#line 581 "parser2.y"
                                       {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system: "ANSI_COLOR_RESET "token.action\n");
            (yyval.string) = (yyvsp[0].string);
        }
#line 2312 "y.tab.c"
    break;

  case 61:
#line 587 "parser2.y"
                                                                                                               { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"system_action: "ANSI_COLOR_RESET "addbody\n");
            char *s = malloc(strlen((yyvsp[-13].string)) + strlen((yyvsp[-11].string)) + strlen((yyvsp[-9].string)) + strlen((yyvsp[-7].string)) + strlen((yyvsp[-5].string)) + strlen((yyvsp[-3].string)) + strlen((yyvsp[-1].string)) + strlen("bodies.push(new Body(,,,,,,))")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"bodies.push(new Body(%s,%s,%s,%s,%s,%s,%s))",(yyvsp[-13].string),(yyvsp[-11].string),(yyvsp[-9].string),(yyvsp[-7].string),(yyvsp[-5].string),(yyvsp[-3].string),(yyvsp[-1].string)); 
            (yyval.string) = s; 
        }
#line 2326 "y.tab.c"
    break;

  case 62:
#line 598 "parser2.y"
                                       { 
        if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config: "ANSI_COLOR_RESET "token.action\n");
        (yyval.string) = (yyvsp[0].string);
    }
#line 2335 "y.tab.c"
    break;

  case 63:
#line 604 "parser2.y"
                                            { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "gravity\n");
            char *s = malloc(strlen((yyvsp[-1].string)) + strlen("Gc = ")+1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"Gc = %s",(yyvsp[-1].string));
            (yyval.string) = s;
        }
#line 2349 "y.tab.c"
    break;

  case 64:
#line 613 "parser2.y"
                                       {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"config_action: "ANSI_COLOR_RESET "bounce\n");
            char *s = malloc(strlen((yyvsp[-1].string)) + strlen("worldBorderBounce = ") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"worldBorderBounce = %s",(yyvsp[-1].string));
            (yyval.string) = s;
        }
#line 2363 "y.tab.c"
    break;

  case 65:
#line 624 "parser2.y"
                         {
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"print: "ANSI_COLOR_RESET "print exp\n");
            char *s = malloc(strlen((yyvsp[-1].exp_type)->sval) + strlen("console.log()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"console.log(%s)",(yyvsp[-1].exp_type)->sval); 
            printf("print: %s, %s\n", (yyval.string), s);
            (yyval.string) = s; 
        }
#line 2378 "y.tab.c"
    break;

  case 66:
#line 636 "parser2.y"
                                    {  
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"read_str: "ANSI_COLOR_RESET "read exp\n");   
            char *s = malloc(strlen((yyvsp[-1].string)) + strlen("window.prompt()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"window.prompt(%s)",(yyvsp[-1].string)); 
            printf("read_str: %s, %s\n", (yyval.string), s);
            (yyval.string) = s; 
        }
#line 2393 "y.tab.c"
    break;

  case 67:
#line 648 "parser2.y"
                                    { 
            if(DEBUGGING) yydebug(ANSI_COLOR_GREEN"read_num: "ANSI_COLOR_RESET "read exp\n");   
            char *s = malloc(strlen((yyvsp[-1].string)) + strlen("window.prompt()") + 1);
            if(s == NULL){
                yyerror("no memory left");
            }
            sprintf(s,"window.prompt(%s)",(yyvsp[-1].string)); 
            printf("read_num: %s, %s\n", (yyval.string), s);
            (yyval.string) = s; 
        }
#line 2408 "y.tab.c"
    break;


#line 2412 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 659 "parser2.y"



struct symtab * symLook(char* s){
    struct symtab * sp;

    printf("searching for: %s\n", s);

    for(sp= symtab; sp <&symtab[MAX_SYMBOLS];sp++){
        /* is it alredy here? */
        printf("comparing: %s\n", sp->name);
        if (sp->name && !strcmp((sp->name)+2, s) ){
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

