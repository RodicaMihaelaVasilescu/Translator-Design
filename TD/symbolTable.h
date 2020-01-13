#ifndef _SYMBOLTABLE_H_
#define _SYMBOLTABLE_H_

// #include "TypeNode.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

typedef struct SymbolNode {
  char* symbol_name;
  char* symbol_type;
  char* symbol_context;
  int line;
  int isAssigned;
} SymbolNode;

SymbolNode** SymbolTable = NULL;
int currentNode = 0;

void symbolTableInsert(char* context, char* type, char* name, int line);
void printSymbolTable(int nodes);
void initializeSymbolTable(int nodes);
void parseTree(TreeNode* root);
int countSyntaxNodes(TreeNode* Head);
void showError();
#endif
