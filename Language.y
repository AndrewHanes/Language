%{
#define YYDEBUG 1
#include "SymbolTable.h"
SymTab* s;
int statement = 0;
%}

%union {
	TokenInfo tok;
}
%token LPAREN RPAREN LBRACE RBRACE NEWLINE ASSIGNMENT TRUE FALSE END
%token <tok> INTEGER FLOATING ADDITION SUBTRACTION MULTIPLICATION DIVISION MODULUS FUNC VAR
%token <tok> EQUALITY LESS GREATER
%type <tok> expr
%type <tok> line
%type <tok> program

%%
program: program line { ++statement; } 
       | /* e */ ;

line: expr END {printf("%g\n", $1.val);}
	| VARTERM END
	| LBRACE { enterScope(s); }
	| RBRACE { leaveScope(s); }
    ;
VARTERM: VAR ASSIGNMENT expr {
		storeVar(s, mkVariable(FLOATING, $3.val, $1.name, s->scopeLevel));
	}
	;

expr: FLOATING { $$ = $1; }
    | VAR { 
    		$$.val = lookupVariable(s, $1.name)->data; 
		//printf("LOOKED UP: %g\n", $$.val);
	}
    		
    | INTEGER	{ $$ = $1; $$.val = (int) $$.val; } 
    | LPAREN expr RPAREN { $$.val = $2.val; }
    | expr ADDITION expr { $$.val = $1.val + $3.val; }
    | expr SUBTRACTION expr { $$.val = $1.val + $3.val; }
    | expr MULTIPLICATION expr { $$.val = $1.val * $3.val; }
    | expr DIVISION expr { $$.val = $1.val / $3.val; }
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
