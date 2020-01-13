%option noyywrap
%{
  #include "grammar.y"
%}
NAME [a-zA-Z]
whitespace [ \r\t\v\f]
linefeed \n
tab \t
NUMBER [0-9]+

%%
{name} {return NAME;}
"int" {return INT;}
"if" {return IF;}
"else" {return ELSE;}
"!=" {return NEQUAL;}
"return" {return RETURN;}
"(" {return LPAR;}
")" {return RPAR;}
"{" {return LBRACE;}
"}" {return RBRACE;}
"[" {return LBRACK;}
"]" {return RBRACK;}
"=" {return ASSIGN;}
";" {return SEMICOLON;}
"," {return COMMA;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return TIMES;}
"/" {return DIVIDE;}
"==" {return EQUAL;}
"char" {return CHAR;}
"write" {return WRITE;}
"read" {return READ;}
">" {return GREATER;}
"<" {return LESS;}
"!" {return NOT;}
"length" {return LENGTH;}
"while" {return WHILE;}
{whitespace}
{linefeed}
"//" {return COMMENT;}
"/*" {return COMMENT;}
"*/" {return COMMENT;}
%%
