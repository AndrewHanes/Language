%{
#define YYDEBUG 1
#include "SymbolTable.h"
#include "Types.h"

SymTab* sym = mkSymTab();
int lineNum = 1;
%}

%token ASSIGNMENT PLUS MINUS MULT DIVIDE LPAREN RPAREN LBRACE RBRACE STRING
%token <ti> VAR
%token <ti> INT
%token <ti> BOOL

%%

code: code scope| /* e */;

scope: LBRACE expression RBRACE
	{
		enterScope(sym);
		$$ = $$2;
		leaveScope(sym);
	};

expression: INT {$$ = $1;} | ASSIGN | MATH;

ASSIGN: ;

MATH: ;


%%

int yyerror(char* s) {
	fprintf(stderr, "Error: %s\nOn line: %d\n", s, lineNum);
	return 0;
}


