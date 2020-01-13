#include "main.h"

void yyerror(char *message) { fprintf(stderr, "error: %s\n", message); }

void printTree() { DisplayTree(TreeRoot, 0); }

void saveTreeToFile() { SaveTreeToFile(TreeRoot, 0, yyout); }

void scan(void (*action)()) {
  yyparse();
  (*action)();
}

void readFromFile(char *filename, void (*scan)(void (*action)()),
                  void (*action)()) {
  if (!(yyin = fopen(filename, "r"))) {
    perror(filename);
    return;
  }
  (*scan)(*action);
}

void readMultipleFiles(int numberOfFiles, char **fileNames,
                       void (*scan)(void (*action)()), void (*action)()) {
  int i;
  for (i = 0; i < numberOfFiles; i++) {
    printf("%s\n", fileNames[i]);
    FILE *f = fopen(fileNames[i], "r");
    if (!f) {
      perror(fileNames[i]);
      return;
    }
    yyrestart(f);
    (*scan)(*action);
    fclose(f);
  }
}

char **copy_argv(char *argv[], int start, int end) {
  int length = 0;
  size_t ptr_args = end - start + 1;
  for (int i = start + 1; i < end + 1; i++) {
    length += (strlen(argv[i]) + 1);
  }
  char **new_argv = (char **)malloc((ptr_args) * sizeof(char *) + length);
  length = 0;
  int k = 0;
  for (int i = start + 1; i < end + 1; i++) {
    new_argv[k] = &(((char *)new_argv)[(ptr_args * sizeof(char *)) + length]);
    strcpy(new_argv[k], argv[i]);
    length += (strlen(argv[i]) + 1);
    k++;
  }
  new_argv[ptr_args - 1] = NULL;
  return (new_argv);
}

void printHelpMenu() {
  printf("%s",
         "Flags like -i -ap can be used together and are recommended to be "
         "used together\n");
  printf("%s", "The parser defaults to print tokens to the console\n");
  printf("%s", "<executable> -h - Displays the help menu\n");
  printf("%s", "<executable> -i - Read from the console.\n");
  printf("%s", "<executable> -i <filename> - Read from the file\n");
  printf("%s",
         "<executable> -i <filename1> <filename2> ... <filenameN> - Read from "
         "multiple files\n");
  printf("%s",
         "<executable> -toFile <filename> - Saves the tree to the "
         "console\n");
}

int main(int argc, char **argv) {
  int i;

  if (argc == 1) {
    printHelpMenu();
  } else {
    void (*action)() = printTree;
    void (*scanFunction)(void (*action)()) = scan;
    for (i = 1; i < argc; i++) {
      if (!strcmp(argv[i], "-h")) {
        printHelpMenu();
      }
      if (!strcmp(argv[i], "-i")) {
        int j = i;
        while (j + 1 < argc && strchr(argv[j + 1], '-') == NULL) {
          j++;
        }
        if (j - i == 0) {
          (void)(*scanFunction)(*action);
        } else {
          if (j - i == 1) {
            for (i = 1; i < argc; i++) {
              if (!strcmp(argv[i], "-toFile")) {
                action = saveTreeToFile;
                if (i < argc) yyout = fopen(argv[i + 1], "w");
              }
            }
            readFromFile(argv[j], scanFunction, action);
          } else {
            for (i = 1; i < argc; i++) {
              if (!strcmp(argv[i], "-toFile")) {
                action = saveTreeToFile;
                if (i < argc) {
                  FILE *f = fopen(argv[i + 1], "w");
                  fclose(f);
                  yyout = fopen(argv[i + 1], "a");
                }
              }
            }
            char **filenames = copy_argv(argv, i, j);
            readMultipleFiles(j - i, filenames, scanFunction, action);
          }
        }
      }
    }
  }

  DisplayTree(TreeRoot, 0);
  int nodes = countSyntaxNodes(TreeRoot);
  // printf("%d \n", nodes);

  initializeSymbolTable(nodes);
  parseTree(TreeRoot);
  printSymbolTable(nodes);
  FreeTree(TreeRoot);
  showError();
  return 0;
}
