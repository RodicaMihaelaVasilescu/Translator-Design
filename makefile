all:
		$(MAKE) grammar
		$(MAKE) lex
		g++ std=c++11 -Wall -Wextra compilers/grammar.tab.c compilers/lex.yy.c compilers/main.cpp
		./a.exe < sample_input

grammar:
	bison -d compilers/grammar.y

lex:
	flex compilers/lex.l
