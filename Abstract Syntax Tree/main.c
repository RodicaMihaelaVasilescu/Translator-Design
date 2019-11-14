#include "y.tab.h"
#include <stdio.h>
#include <string.h>
int yylex();
FILE* yyin;
FILE* yyout;
void yyrestart(FILE*);

char** copy_argv(char* argv[], int start, int end) {
  int length = 0;
  size_t ptr_args = end - start + 1;
  for (int i = start + 1; i < end + 1; i++) {
    length += (strlen(argv[i]) + 1);
  }
  char** new_argv = (char**)malloc((ptr_args) * sizeof(char*) + length);
  length = 0;
  int k = 0;
  for (int i = start + 1; i < end + 1; i++) {
    new_argv[k] = &(((char*)new_argv)[(ptr_args * sizeof(char*)) + length]);
    strcpy(new_argv[k], argv[i]);
    length += (strlen(argv[i]) + 1);
    k++;
  }
  new_argv[ptr_args - 1] = NULL;
  return (new_argv);
}

int main(int argc, char** argv){
  int i;
  int token;
  if(argc == 1){
    printf("%s","Flags like -i -ap can be used together and are recommended to be used together\n");
    printf("%s","The lexer defaults to print tokens to the console\n");
    printf("%s","<executable> -h - Displays the help menu\n");
    printf("%s","<executable> -i - Read from the console.\n");
    printf("%s","<executable> -i <filename> - Read from the file\n");
    printf("%s","<executable> -i <filename1> <filename2> ... <filenameN> - Read from multiple files\n");
    printf("%s","<executable> -ap - Prints the scanned tokens to the console\n");
    printf("%s","<executable> -as <filename> - Saves the scanned tokens to the console\n");
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
        return;
      }
      if (!strcmp(argv[i], "-i")) {
        int j = i;
        while(j + 1 < argc && strchr(argv[j + 1], '-') == NULL){
          j++;
        }
        if(j - i == 0){
          yyin = stdin;//(void)(*scanFunction)(*action);
        }else {
          if (j - i == 1){
            if(!(yyin = fopen(argv[j], "r"))) {
                perror(argv[j]);
            }
            //scanFunction;
          }else{
            char** filenames = copy_argv(argv,i,j);
            int i;
            for(i = 0; i < j-i; i++) {
                printf("%s\n",filenames[i]);
                FILE *f = fopen(filenames[i], "r");
                if(!f) {
                    perror(filenames[i]);
                }
                //scanFunction;
                fclose(f);
            }

          }
        }
      }
    }


//    int token;
    while(token = yylex()) {
        scanf("%d ",token);
    }
    return 0;


}
