flex lex.l
bison -dy bison.y
gcc y.tab.c lex.yy.c -o compiler.exe
compiler.exe 