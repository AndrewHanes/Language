%{
#define YYDEBUG 1
#include "SymbolTable.h"
int lineNum = 1;
%}

%token ASSIGNMENT PLUS MINUS MULT DIVIDE LPAREN RPAREN LBRACE RBRACE STRING
%token <ti> VAR
%token <ti> INTEGER

%%

code: code scope| /* e */;

scope: LBRACE expression RBRACE
	{
	};

expression: INTEGER {}


%%

int yyerror(char* s) {
	fprintf(stderr, "Error: %s\nOn line: %d\n", s, lineNum);
	return 0;
}


