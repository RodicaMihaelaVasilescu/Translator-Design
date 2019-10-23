%{
  #include <math.h>
  %include <stdio.h>
  %include <stdlib.h>
  int yylex (void);
  void yyerror (char const *)
%}

%define api.value.type {double}
%define FLEX_SCANNER
%token NAME NUMBER QCHAR INT IF ELSE RETURN LPAR RPAR LBRACE RBRACE LBRACK RBRACK ASSIGN SEMICOLON COMMA PLUS MINUS TIMES DIVIDE EQUAL CHAR WRITE READ GREATER LESS NOT LENGTH WHILE COMMENT

%start input

%%

input:
  NAME NUMBER QCHAR INT IF ELSE RETURN LPAR RPAR LBRACE RBRACE LBRACK RBRACK ASSIGN SEMICOLON COMMA PLUS MINUS TIMES DIVIDE EQUAL CHAR WRITE READ GREATER LESS NOT LENGTH WHILE COMMENT


  program : [declaration]+
  ;
  declaration : fun_declaration
  | var_declaration
  ;
  fun_declaration : type NAME LPAR formal_pars RPAR block
  ;
  formal_pars : formal_par [ COMMA formal_par ]*
  | // empty
  ;
  formal_par : type NAME
  ;
  block : LBRACE var_declaration* statements RBRACE
  ;
  var_declaration : type NAME SEMICOLON
  ;
  type : INT
  | CHAR
  | type LBRACK exp RBRACK // array type
  ;
  statements : statement [ SEMICOLON statement]*
  |
  ;
  statement : IF LPAR exp RPAR statement
  | IF LPAR exp RPAR statement ELSE statement
  | WHILE LPAR exp RPAR statement
  | lexp ASSIGN exp
  | RETURN exp
  | NAME LPAR pars RPAR // function call
  | block
  | WRITE exp
  | READ lexp
  ;
  lexp : var
  | lexp LBRACK exp RBRACK // array access
  ;
  exp : lexp
  | exp binop exp
  | unop exp
  | LPAR exp RPAR
  | NUMBER
  | NAME LPAR pars RPAR // function call
  | QCHAR
  | LENGTH lexp // size of an array
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
  pars : exp [COMMA exp]*
  |
  ;
  var : NAME
%%
