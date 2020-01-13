#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

TreeNode* TreeRoot;

extern int yylex();
extern int yylineno;
extern FILE* yyin;
extern FILE* yyout;
extern void yyrestart(FILE*);
extern int yyparse(void);

void printTree();
void saveTreeToFile();

void scan(void (*action)());
void readFromFile(char* filename, void (*scan)(void (*action)()),
                  void (*action)());
void readMultipleFiles(int numberOfFiles, char** fileNames,
                       void (*scan)(void (*action)()), void (*action)());
char** copy_argv(char* argv[], int start, int end);
void printHelpMenu();
void yyerror(char* message);
