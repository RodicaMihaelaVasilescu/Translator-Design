%option noyywrap

%{
#include "y.tab.h"
%}

NAME [a-zA-Z][a-zA-Z0-9_]*
NUMBER 0|([1-9][0-9]*)
QCHAR '[a-zA-Z]'
COMMENT //^.*$

INT int
IF if
ELSE else
NEQUAL !=
RETURN return
LPAR (
RPAR )
LBRACE {
RBRACE }
LBRACK [
RBRACK ]
ASSIGN =
SEMICOLON ;
COMMA ,
PLUS +
MINUS -
TIMES *
DIVIDE /
EQUAL ==
CHAR char
WRITE write
READ read
GREATER >
LESS <
NOT !
LENGTH length
WHILE while

%%

%%
