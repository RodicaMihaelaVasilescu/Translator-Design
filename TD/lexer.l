digit       [0-9]
number      {digit}+
qchar      [a-zA-Z]
name        {letter}+
identifier [\_|[:alpha:]][\_|[:alnum:]]*
newline     [(\r\n)|(\n)]
string      "((\\)|(\")|(\\\")|(\\')|(\\\')|(\\\\)|(\\n)|(\\t)|&|!|#|[a-zA-Z]|[0-9]|_)*"
/* blank - space and tabs */
whitespace  [:blank:]
linefeed \n
tab \t

%{

  #include <stdlib.h>
  #include <string.h> 
  #include "parser.tab.h"
  #include "ast.h"

  int yycolumn = 1;
  #define YY_USER_ACTION \
  yylloc.first_line = yylloc.last_line = yylineno; \
  yylloc.first_column = yycolumn; \
  yylloc.last_column = yycolumn + yyleng - 1; \
  yycolumn += yyleng;
  #define YYDEBUG 1


void yyerror(char *);
#define yyterminate() return( END )
%}
%option nodefault
%option noyywrap
%option yylineno

%%
    /* Reserved keywords*/

int            { yylval.tnode = CreateTreeNode(L_TYPE, yytext, yylineno); return(INT); }
char            { yylval.tnode = CreateTreeNode(L_TYPE, yytext, yylineno); return(CHAR); }
if           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, yytext, yylineno);return(IF); }
else           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, yytext, yylineno);return(ELSE); }
return          { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RETURN", yylineno);return(RETURN); }
write           { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "WRITE", yylineno);return(WRITE); }
read          { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "READ", yylineno);return(READ); }
while         { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "WHILE", yylineno);return(WHILE); }
length            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LENGTH", yylineno);return(LENGTH); }

  /* comments */

^\/\/.*\n$     { /* comment */ }
^\/\*.*\n$      { /* comment */ }
^\*\*.*\n$      { /* comment */ }

  /* special characters */

\<            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LESS", yylineno);return(LESS); }
\>            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "GREATER", yylineno);return(GREATER); }
\=\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "EQUAL", yylineno);return(EQUAL); }
\!\=            { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "NEQUAL", yylineno);return(NEQUAL); }
\;              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "SEMICOLON", yylineno);return(SEMICOLON); }
\{              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LBRACE", yylineno);return(LBRACE); }
\}              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RBRACE", yylineno);return(RBRACE); }
\,              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "COMMA", yylineno);return(COMMA); }
\=              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "ASSIGN", yylineno);return(ASSIGN); }
\(              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LPAR", yylineno);return(LPAR); }
\)              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RPAR", yylineno);return(RPAR); }
\[              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "LBRACK", yylineno);return(LBRACK); }
\]              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "RBRACK", yylineno);return(RBRACK); }
\-              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "MINUS", yylineno);return(MINUS); }
\+              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "PLUS", yylineno);return(PLUS); }
\*              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "TIMES", yylineno);return(TIMES); }
\/              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "DIVIDE", yylineno);return(DIVIDE); }
\!              { yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "NOT", yylineno);return(NOT); }

{newline}       {
                  yycolumn = 1;
                  //return( NEWLINE );
                }
{number}        {
                  yylval.tnode = CreateTreeNode(L_INT, yytext, yylineno);
                  return( NUMBER ); 
                }

{whitespace}    { /* skip */ }

{string}        {
                  yylval.tnode = CreateTreeNode(L_STRING, yytext, yylineno);
                  return( STRINGLITERAL );
                }

{identifier}    {
                  yylval.tnode = CreateTreeNode(L_ID, yytext, yylineno);
                  return( IDENTIFIER );
                }

.               { /* skip */ }

<<EOF>>        {
                yylval.tnode = CreateTreeNode(L_ANYTHINGELSE, "END", yylineno);
                return ( END );
               }

%%
