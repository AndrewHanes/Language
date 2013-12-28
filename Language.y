%{
#define YYDEBUG 1
#include "SymbolTable.h"

int line = 1;
%}

%union {
	TokenInfo tok;
}
%token LPAREN RPAREN LBRACE RBRACE NEWLINE ASSIGNMENT VAR
%token <tok> INTEGER FLOATING ADDITION SUBTRACTION MULTIPLICATION DIVISION MODULUS
%token <tok> EQUALITY LESS GREATER
%type <tok> expr
%type <tok> line

%%
program: program line {} | /* e */ ;

line: expr NEWLINE {printf("GOT: %g\n", $1.val);}
    ;

expr: INTEGER	{ $$ = $1; }
    ;
%%

#include "Language.yy.c"

int yyerror(char* s) {
	fprintf(stderr, "Error: %s at line %d\n", s, line);
	return 0;
}

int main(int argc, char* argv[]) {
	int result = yyparse();
	return result;
}
