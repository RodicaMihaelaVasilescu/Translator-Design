#ifndef _TREE_H_
#define _TREE_H_

#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { lex_unit = 1, syn_unit } UnitType;

typedef enum {
  L_ID = 1,
  L_TYPE,
  L_INT,
  L_STRING,
  L_ANYTHINGELSE
} Lex_Unit_Cont;

typedef enum {
  S_empty = 1,
  S_program,
  S_declaration,
  S_formal_pars,
  S_formal_par,
  S_block,
  S_var_declaration,
  S_type,
  S_statements,
  S_statement,
  S_lexp,
  S_exp,
  S_binop,
  S_unop,
  S_pars,
  S_var
} Syn_Unit_Cont;
typedef struct TreeNode {
  UnitType u_type;
  Syn_Unit_Cont s_cont;
  Lex_Unit_Cont l_cont;
  int childnum;
  struct TreeNode** child;
  union {
    char* syn_name;
    char* id_name;
    char* type_name;
    int int_value;
    char* string_value;
    char* anything_else_name;
  };
  int lineno;
} TreeNode;

TreeNode* CreateTreeNode(Lex_Unit_Cont l_cont, char* value, int lineno);

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int lineno,
                           int childnum, ...);

void PrintBlank(int deepth);
void DisplayTree(TreeNode* Head, int curdeepth);
void FreeTree(TreeNode* head);
void shownode(TreeNode* node);
#endif