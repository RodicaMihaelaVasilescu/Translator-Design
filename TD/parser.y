%{
#include "main.h"
%}

%locations 

%union{
    struct TreeNode *tnode;
}

%token <tnode>               INT
%token <tnode>               NAME
%token <tnode>               IF
%token <tnode>               ELSE
%token <tnode>               NEQUAL
%token <tnode>               RETURN
%token <tnode>               LPAR
%token <tnode>               RPAR
%token <tnode>               LBRACE
%token <tnode>               RBRACE
%token <tnode>               LBRACK
%token <tnode>               RBRACK
%token <tnode>               ASSIGN
%token <tnode>               SEMICOLON
%token <tnode>               COMMA
%token <tnode>               PLUS
%token <tnode>               MINUS
%token <tnode>               TIMES
%token <tnode>               DIVIDE
%token <tnode>               EQUAL
%token <tnode>               CHAR
%token <tnode>               WRITE
%token <tnode>               READ
%token <tnode>               GREATER
%token <tnode>               LESS
%token <tnode>               NOT
%token <tnode>               LENGTH
%token <tnode>               WHILE
%token <tnode>				 IDENTIFIER 
%token <tnode>	             WHITESPACE
%token <tnode>               LINEFEED
%token <tnode>				 COMMENT 
%token <tnode>               END    0     "end of file"


%type <tnode> program declaration fun_declaration formal_pars formal_par block var_declaration type statements statement lexp exp binop unop pars var

/*operator precedence*/
%right GREATER LESS LE_OP GE_OP EQUAL NEQUAL
%left PLUS MINUS
%left TIMES DIVIDE
%left NOT
%left LPAR RPAR LBRACE RBRACE LBRACK RBRACK

%%
/*grammar*/
program : [declaration]+ { $$=GenerateTreeNode(S_program,"program",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  ;
declaration 
 : declaration var_declaration { $$=GenerateTreeNode(S_declaration,"declaration",$1->lineno,2,$1,$2); TreeRoot = $$;}
 | declaration fun_declaration  { $$=GenerateTreeNode(S_declaration,"declaration",$1->lineno,2,$1,$2); TreeRoot = $$;}
 ;
fun_declaration 
 : type NAME LPAR formal_pars RPAR block      { $$=GenerateTreeNode(S_VarDecl,"VarDecl",$1->lineno,5,$1,$2,$3,$4,$5); TreeRoot = $$;}
 ;
 formal_pars : formal_par [ COMMA formal_par ]* { $$=GenerateTreeNode(S_formal_pars,"formal_pars",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  | // empty { $$=GenerateTreeNode(S_formal_pars,"formal_pars",yylineno,-1); TreeRoot = $$;}
  ;
  formal_par : type NAME { $$=GenerateTreeNode(S_formal_par,"formal_par",$1->lineno,2,$1,$2); TreeRoot = $$;}
  ;
  block : LBRACE var_declaration* statements RBRACE { $$=GenerateTreeNode(S_block,"block",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  ;
  var_declaration : type NAME SEMICOLON { $$=GenerateTreeNode(S_var_declaration,"var_declaration",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  ;
  type : INT { $$=GenerateTreeNode(S_type,"type",$1->lineno,1,$1); TreeRoot = $$;}
  | CHAR { $$=GenerateTreeNode(S_type,"type",$1->lineno,1,$1); TreeRoot = $$;}
  | type LBRACK exp RBRACK // array type { $$=GenerateTreeNode(S_type,"type",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  ;
  statements : statement [ SEMICOLON statement]* { $$=GenerateTreeNode(S_statements,"statements",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  | // empty { $$=GenerateTreeNode(S_statements,"statements",yylineno,-1); TreeRoot = $$;}
  ;
  statement : IF LPAR exp RPAR statement { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,5,$1,$2,$3,$5); TreeRoot = $$;}
  | IF LPAR exp RPAR statement ELSE statement { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,7,$1,$2,$3,$4,$5,$6,$7); TreeRoot = $$;}
  | WHILE LPAR exp RPAR statement { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,5,$1,$2,$3,$4,$5); TreeRoot = $$;}
  | lexp ASSIGN exp { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  | RETURN exp { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,2,$1,$2); TreeRoot = $$;}
  | NAME LPAR pars RPAR // function call { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  | block { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,1,$1); TreeRoot = $$;}
  | WRITE exp { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,2,$1,$2); TreeRoot = $$;}
  | READ lexp { $$=GenerateTreeNode(S_statement,"statement",$1->lineno,2,$1,$2); TreeRoot = $$;}
  ;
  lexp : var { $$=GenerateTreeNode(S_lexp,"lexp",$1->lineno,1,$1); TreeRoot = $$;}
  | lexp LBRACK exp RBRACK // array access { $$=GenerateTreeNode(S_lexp,"lexp",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  ;
  exp : lexp { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,1,$1); TreeRoot = $$;}
  | exp binop exp { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  | unop exp { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,2,$1,$2); TreeRoot = $$;}
  | LPAR exp RPAR { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,3,$1,$2,$3); TreeRoot = $$;}
  | NUMBER { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,1,$1); TreeRoot = $$;}
  | NAME LPAR pars RPAR // function call { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,4,$1,$2,$3,$4); TreeRoot = $$;}
  | QCHAR { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,1,$1); TreeRoot = $$;}
  | LENGTH lexp // size of an array { $$=GenerateTreeNode(S_exp,"exp",$1->lineno,2,$1,$2); TreeRoot = $$;}
  ;
  binop : MINUS { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | PLUS { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | TIMES { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | DIVIDE { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | EQUAL { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | NEQUAL { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | GREATER { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  | LESS { $$=GenerateTreeNode(S_binop,"binop",$1->lineno,1,$1); TreeRoot = $$;}
  ;
  unop : MINUS { $$=GenerateTreeNode(S_unop,"unop",$1->lineno,1,$1); TreeRoot = $$;}
  | NOT { $$=GenerateTreeNode(S_unop,"unop",$1->lineno,1,$1); TreeRoot = $$;}
  ;
  pars : exp [COMMA exp]* { $$=GenerateTreeNode(S_pars,"pars",$1->lineno,1,$1); TreeRoot = $$;}
  | { $$=GenerateTreeNode(S_pars,"pars",yylineno,-1); TreeRoot = $$;}
  ;
  var : NAME { $$=GenerateTreeNode(S_var,"var",$1->lineno,1,$1); TreeRoot = $$;}
%%