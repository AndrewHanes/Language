%{
#define YYDEBUG 1
#include "SymbolTable.h"

int line = 1;
%}

%union {
double fval;
char* s;
Variable v;
char boolean;
}
%token LPAREN RPAREN LBRACE RBRACE NEWLINE ASSIGNMENT
%token <fval> INTEGER FLOATING ADDITION SUBTRACTION MULTIPLICATION DIVISION MODULUS 
%token <boolean> EQUALITY LESS GREATER
%token <v> VAR

%%
 program: ;
%%

#include Language.yy.c

int yyerror(char* s) {
	fprintf(stderr, "Error: %s at line %d\n", s, line);
	return 0;
}

int main(int argc, char* argv[]) {
	int result = yyparse();
	return result;
}
