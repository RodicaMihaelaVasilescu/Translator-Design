
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NAME = 258,
     NUMBER = 259,
     QCHAR = 260,
     COMMENT = 261,
     INT = 262,
     IF = 263,
     ELSE = 264,
     NEQUAL = 265,
     RETURN = 266,
     LPAR = 267,
     RPAR = 268,
     LBRACE = 269,
     RBRACE = 270,
     LBRACK = 271,
     RBRACK = 272,
     ASSIGN = 273,
     SEMICOLON = 274,
     COMMA = 275,
     PLUS = 276,
     MINUS = 277,
     TIMES = 278,
     DIVIDE = 279,
     EQUAL = 280,
     CHAR = 281,
     WRITE = 282,
     READ = 283,
     GREATER = 284,
     LESS = 285,
     NOT = 286,
     LENGTH = 287,
     WHILE = 288
   };
#endif
/* Tokens.  */
#define NAME 258
#define NUMBER 259
#define QCHAR 260
#define COMMENT 261
#define INT 262
#define IF 263
#define ELSE 264
#define NEQUAL 265
#define RETURN 266
#define LPAR 267
#define RPAR 268
#define LBRACE 269
#define RBRACE 270
#define LBRACK 271
#define RBRACK 272
#define ASSIGN 273
#define SEMICOLON 274
#define COMMA 275
#define PLUS 276
#define MINUS 277
#define TIMES 278
#define DIVIDE 279
#define EQUAL 280
#define CHAR 281
#define WRITE 282
#define READ 283
#define GREATER 284
#define LESS 285
#define NOT 286
#define LENGTH 287
#define WHILE 288




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


