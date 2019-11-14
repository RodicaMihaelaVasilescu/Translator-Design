#include "ast.h"

TreeNode* GenerateTreeNode(Syn_Unit_Cont s_cont, char* syn_name, int childnum,
                           ...) {
  TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
  node->s_cont = s_cont;
  node->childnum = childnum;
  va_list args;
  va_start(args, childnum);
  node->child = (TreeNode**)malloc(sizeof(TreeNode*) * abs(childnum));
  int count;
  for (count=0; count < abs(childnum); count++) {
    TreeNode* temp = va_arg(args, TreeNode*);
    node->child[count] = temp;
  }
  node->syn_name = syn_name;
  return node;
}

void DisplayTree(TreeNode* Head, int curdeepth) {
  if (Head->childnum < 0) return;
  PrintBlank(curdeepth);
  printf("%s (%d)\n", Head->syn_name);
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

void shownode(TreeNode* node) { printf("%d\n", node->s_cont); }
