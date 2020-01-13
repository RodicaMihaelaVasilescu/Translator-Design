#include "ast.h"

TreeNode* CreateTreeNode(Lex_Unit_Cont l_cont, char* value, int lineno) {
  TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
  node->u_type = lex_unit;
  node->s_cont = 0;
  node->l_cont = l_cont;
  node->childnum = 0;
  node->child = NULL;
  node->lineno = lineno;
  switch (node->l_cont) {
    case L_ID: {
      node->id_name = (char*)malloc(strlen(value));
      strcpy(node->id_name, value);
      break;
    }
    case L_TYPE: {
      node->type_name = (char*)malloc(strlen(value));
      strcpy(node->type_name, value);
      break;
    }
    case L_INT: {
      node->int_value = atoi(value);
      break;
    }
    case L_STRING: {
      node->string_value = (char*)malloc(strlen(value));
      strcpy(node->string_value, value);
      break;
    }
    case L_ANYTHINGELSE: {
      node->anything_else_name = (char*)malloc(strlen(value));
      strcpy(node->anything_else_name, value);
      break;
    }
  }

  return node;
}

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int lineno,
                           int childnum, ...) {
  TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
  node->u_type = syn_unit;
  node->s_cont = s_cont;
  node->l_cont = 0;
  node->childnum = childnum;
  node->lineno = lineno;
  va_list args;
  va_start(args, childnum);
  node->child = (TreeNode**)malloc(sizeof(TreeNode*) * abs(childnum));
  int count = 0;
  for (; count < abs(childnum); count++) {
    TreeNode* temp = va_arg(args, TreeNode*);
    node->child[count] = temp;
  }
  node->syn_name = syn_name;

  return node;
}
void DisplayTree(TreeNode* Head, int curdeepth) {
  PrintBlank(curdeepth);
  printf("%d)", curdeepth);
  shownode(Head);
  if (Head->childnum < 0) return;
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      DisplayTree(Head->child[i], curdeepth + 1);
    }
  }
}

void PrintBlank(int deepth) {
  int temp = 0;
  for (; temp < deepth; temp++) printf("  ");
}

const char* unit_type_arr[] = {"", "lex_unit", "syn_unit"};
const char* lex_unit_arr[] = {"",      "L_ID",     "L_TYPE",
                              "L_INT", "L_STRING", "L_ANYTHINGELSE"};
const char* syn_unit_arr[] = {"",
                              "S_empty",
                              "S_program",
                              "S_declaration",
                              "S_formal_pars",
                              "S_formal_par",
                              "S_block",
                              "S_var_declaration",
                              "S_type",
                              "S_statements",
                              "S_statement",
                              "S_lexp",
                              "S_exp",
                              "S_binop",
                              "S_unop",
                              "S_pars",
                              "S_var"};

void shownode(TreeNode* node) {
  printf("%s  ", unit_type_arr[node->u_type]);
  printf("%s  ", lex_unit_arr[node->l_cont]);
  printf("%s  ", syn_unit_arr[node->s_cont]);
  printf("line %d ", node->lineno);
  if (node->u_type == 2) printf("%s  ", node->syn_name);
  printf("\n");
}

void FreeTree(TreeNode* Head) {
  if (Head->childnum < 0) {
    free(Head);
    return;
  };
  if (Head->childnum > 0 && Head->child[0] != NULL) {
    int i;
    for (i = 0; i < Head->childnum; i++) {
      FreeTree(Head->child[i]);
    }
  }
}