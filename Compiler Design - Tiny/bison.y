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

declaration_list: declaration declaration_list {printf("declaration_list\n");}
                | declaration 				   {printf("declaration_list\n");}
				;

declaration : fun_declaration {printf("declaration\n");}
            | var_declaration {printf("declaration\n");}
            ;
			
fun_declaration : type NAME LPAR formal_pars RPAR block {printf("fun_declaration\n");}
                ;

formal_pars : formal_par formal_pars_list {printf("formal_pars\n");}
            |
			;

formal_pars_list : COMMA formal_par {printf("formal_pars_list\n");}
                 |
				 ;

formal_par : type NAME {printf("formal_par\n");}
           ;

block : LBRACE var_declaration_list statements RBRACE {printf("block\n");}
      ;
	  
var_declaration_list : var_declaration var_declaration_list {printf("var_declaration_list\n");}
                     | var_declaration                      {printf("var_declaration_list\n");}
					 ;

var_declaration : type NAME SEMICOLON {printf("var_declaration\n");}
                ;

type : INT                    {printf("type\n");}
     | CHAR                   {printf("type\n");}
     | type LBRACK exp RBRACK {printf("type\n");}
     ;

statements : statement statement_list {printf("statements\n");}
           |
           ;

statement_list : SEMICOLON statement {printf("statement_list\n");}
               |
			   ;

statement : IF LPAR exp RPAR statement                {printf("statement\n");}
          | IF LPAR exp RPAR statement ELSE statement {printf("statement\n");}
          | WHILE LPAR exp RPAR statement             {printf("statement\n");}
          | lexp ASSIGN exp                           {printf("statement\n");}
          | RETURN exp                                {printf("statement\n");}
          | NAME LPAR pars RPAR                       {printf("statement\n");}
          | block                                     {printf("statement\n");}
          | WRITE exp                                 {printf("statement\n");}
          | READ lexp                                 {printf("statement\n");}
          ;

lexp : var                    {printf("lexp\n");}
     | lexp LBRACK exp RBRACK {printf("lexp\n");}
     ;

exp : lexp                {printf("exp\n");}
    | exp binop exp       {printf("exp\n");}
    | unop exp            {printf("exp\n");}
    | LPAR exp RPAR       {printf("exp\n");}
    | NUMBER              {printf("exp\n");}
    | NAME LPAR pars RPAR {printf("exp\n");}
    | QCHAR               {printf("exp\n");}
    | LENGTH lexp         {printf("exp\n");}
    ;
	
binop : MINUS   {printf("binop\n");}
      | PLUS    {printf("binop\n");}
      | TIMES   {printf("binop\n");}
      | DIVIDE  {printf("binop\n");}
      | EQUAL   {printf("binop\n");}
      | NEQUAL  {printf("binop\n");}
      | GREATER {printf("binop\n");}
      | LESS    {printf("binop\n");}
      ;

unop : MINUS {printf("unop\n");}
     | NOT   {printf("unop\n");}
     ;

pars : exp exp_list {printf("pars\n");}
     |
     ;

exp_list : COMMA exp {printf("exp_list\n");}
         |
		 ;

var : NAME {printf("var\n");}
    ;

%%
#include <ctype.h>
int main(void) { return yyparse(); }
int yyerror(const char* s) { printf("%s\n", s); return 0; }