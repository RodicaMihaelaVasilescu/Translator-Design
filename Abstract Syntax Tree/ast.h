#ifndef _TREE_H_
#define _TREE_H_

#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* TreeNode Structure*/
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