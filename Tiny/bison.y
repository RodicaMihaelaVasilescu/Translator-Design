%{
#define YYSTYPE double
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
int yyerror(const char* s);
int yylex(void);
%}

%token NAME
%token NUMBER
%token QCHAR
%token COMMENT

%token INT
%token IF
%token ELSE
%token NEQUAL
%token RETURN
%token LPAR
%token RPAR
%token LBRACE
%token RBRACE
%token LBRACK
%token RBRACK
%token ASSIGN
%token SEMICOLON
%token COMMA
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token EQUAL
%token CHAR
%token WRITE
%token READ
%token GREATER
%token LESS
%token NOT
%token LENGTH
%token WHILE

%% 

program : declaration_list
        ;

declaration_list: declaration declaration_list
                | declaration
				;

declaration : fun_declaration
            | var_declaration
            ;
			
fun_declaration : type NAME LPAR formal_pars RPAR block
                ;

formal_pars : formal_par formal_pars_list
            |
			;

formal_pars_list : COMMA formal_par
                 |
				 ;

formal_par : type NAME
           ;

block : LBRACE var_declaration_list statements RBRACE
      ;
	  
var_declaration_list : var_declaration var_declaration_list
                     | var_declaration
					 ;

var_declaration : type NAME SEMICOLON
                ;

type : INT
     | CHAR
     | type LBRACK exp RBRACK // array type
     ;

statements : statement statement_list
           |
           ;

statement_list : SEMICOLON statement
               |
			   ;

statement : IF LPAR exp RPAR statement
          | IF LPAR exp RPAR statement ELSE statement
          | WHILE LPAR exp RPAR statement
          | lexp ASSIGN exp
          | RETURN exp
          | NAME LPAR pars RPAR
          | block
          | WRITE exp
          | READ lexp
          ;

lexp : var
     | lexp LBRACK exp RBRACK
     ;

exp : lexp
    | exp binop exp
    | unop exp
    | LPAR exp RPAR
    | NUMBER
    | NAME LPAR pars RPAR
    | QCHAR
    | LENGTH lexp
    ;
	
binop : MINUS
      | PLUS
      | TIMES
      | DIVIDE
      | EQUAL
      | NEQUAL
      | GREATER
      | LESS
      ;

unop : MINUS
     | NOT
     ;

pars : exp exp_list
     |
     ;

exp_list : COMMA exp
         |
		 ;

var : NAME
    ;

%%
#include <ctype.h>
int main(void) { return yyparse(); }
int yyerror(const char* s) { printf("%s\n", s); return 0; }