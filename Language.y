%{
#define YYDEBUG 1
#include "SymbolTable.h"
#include <inttypes.h>
SymTab* s;
int statement = 0;
%}

%union {
	TokenInfo tok;
}
%token LPAREN RPAREN LBRACE RBRACE NEWLINE ASSIGNMENT TRUE FALSE END
%token <tok> INTEGER FLOATING FUNC VAR
%token <tok> DIVISION SUBTRACTION
%token <tok> MULTIPLICATION MODULUS ADDITION 
%token <tok> EQUALITY LESS GREATER
%type <tok> expr
%type <tok> statement 
%type <tok> program

%%
program: program statement { ++statement; } 
       | /* e */ ;

statement: expr END {printf("%g\n", $1.val);}
	| VARTERM END
	| LBRACE { enterScope(s); }
	| RBRACE { leaveScope(s); }
    ;
VARTERM: VAR ASSIGNMENT expr {
		storeVar(s, mkVariable(FLOATING, $3.val, $1.name, s->scopeLevel));
	}
	;

expr: VAR { 
    		$$.val = lookupVariable(s, $1.name)->data; 
		//printf("LOOKED UP: %g\n", $$.val);
	}
    | LPAREN expr RPAREN { $$.val = $2.val; }
    | expr ADDITION expr { $$.val = $1.val + $3.val; }
    | expr SUBTRACTION expr { $$.val = $1.val - $3.val; }
    | expr MULTIPLICATION expr { $$.val = $1.val * $3.val; }
    | expr DIVISION expr { $$.val = $1.val / $3.val; }
    | SUBTRACTION expr { $$.val = -1 * $2.val; }
    | INTEGER	{ $$ = $1; $$.val = (int) $$.val; } 
    | FLOATING { $$ = $1; }
     ; 
%%

#include "Language.yy.c"

int yyerror(char* s) {
	fprintf(stderr, "Error: %s at statement %d\n", s, statement);
	return 0;
}

int main(int argc, char* argv[]) {
	s = mkSymTab();
	int result = yyparse();
	return result;
}
