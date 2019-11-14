#include "y.tab.h"
#include <stdio.h>
#include <string.h>

extern int yylex();
extern FILE* yyin;
extern FILE* yyout;
extern void yyrestart(FILE*);

void printTokens(int token);
void saveTokensToFile(int token);
void scan(void (*action)(int));
void readFromFile(char* filename, void (*scan)(void (*action)(int)),
                  void (*action)(int));
void readMultipleFiles(int numberOfFiles, char** fileNames,
                       void (*scan)(void (*action)(int)), void (*action)(int));
char** copy_argv(char* argv[], int start, int end);
void printHelpMenu();

int main(int argc, char** argv){
  int i;
  if(argc == 1){
    printf("%s","Flags like -i -ap can be used together and are recommended to be used together\n");
    printf("%s","The lexer defaults to print tokens to the console\n");
    printf("%s","<executable> -h - Displays the help menu\n");
    printf("%s","<executable> -i - Read from the console.\n");
    printf("%s","<executable> -i <filename> - Read from the file\n");
    printf("%s","<executable> -i <filename1> <filename2> ... <filenameN> - Read from multiple files\n");
    printf("%s","<executable> -ap - Prints the scanned tokens to the console\n");
    printf("%s","<executable> -as <filename> - Saves the scanned tokens to the console\n");
  }else{
    printf("%d ",token);
    int token; 
    while(token = yylex()) {
        (*action)(token);
    }

    for (i = 1; i < argc; i++) {
      if (!strcmp(argv[i], "-ap")) {
        printf("%d ",token);
      }
      if (!strcmp(argv[i], "-as")) {
        fprintf(yyout,"%d ", token);
        if(i < argc)
        yyout = fopen(argv[i + 1],"w");
      }
    }
    for (i = 1; i < argc; i++) {
      if (!strcmp(argv[i], "-h")) {
        printf("%s","Flags like -i -ap can be used together and are recommended to be used together\n");
        printf("%s","The lexer defaults to print tokens to the console\n");
        printf("%s","<executable> -h - Displays the help menu\n");
        printf("%s","<executable> -i - Read from the console.\n");
        printf("%s","<executable> -i <filename> - Read from the file\n");
        printf("%s","<executable> -i <filename1> <filename2> ... <filenameN> - Read from multiple files\n");
        printf("%s","<executable> -ap - Prints the scanned tokens to the console\n");
        printf("%s","<executable> -as <filename> - Saves the scanned tokens to the console\n");
      }
      if (!strcmp(argv[i], "-i")) {
        int j = i;
        while(j + 1 < argc && strchr(argv[j + 1], '-') == NULL){
          j++;
        }
        if(j - i == 0){
          (void)(*scanFunction)(*action);
        }else {
          if (j - i == 1){
            if(!(yyin = fopen(argv[j], "r"))) {
                perror(argv[j]);
            }
            scanFunction;
          }else{
            char** filenames = copy_argv(argv,i,j);
            int i;
            for(i = 0; i < j-i; i++) {
                printf("%s\n",filenames[i]);
                FILE *f = fopen(filenames[i], "r");
                if(!f) {
                    perror(filenames[i]);
                }
                yyrestart(f);
                scanFunction;
                fclose(f);
            }

          }
        }
      }
    }
  }
  return 0;
}