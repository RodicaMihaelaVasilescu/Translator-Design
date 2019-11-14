#ifndef _TREE_H_
#define _TREE_H_

#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef enum {
    S_empty = 1,
  S_Program,
  S_VarDecl,
  S_Type,
  S_FnDecl,
  S_Parameters,
  S_FormalsList,
  S_FormalDecl,
  S_Block,
  S_DeclList,
  S_StmtList,
  S_Stmt,
  S_Exp,
  S_Atom,
  S_FnCallExpr,
  S_FnCallStmt,
  S_ActualList,
  S_SubscriptExpr,
  S_Id
} Syn_Unit_Cont;

typedef struct TreeNode {
  Syn_Unit_Cont s_cont;
  int childnum;
  struct TreeNode** child;
  union {
    char* syn_name;
    char* id_name;
    char* type_name;
    int int_value;
  };
} TreeNode;

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int childnum,
                           ...);

void PrintBlank(int deepth);

void DisplayTree(TreeNode* Head, int curdeepth);

int FreeTree(TreeNode* head);

void shownode(TreeNode* node);

#endif
