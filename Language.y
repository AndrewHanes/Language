%{
#define YYDEBUG 1
#include "SymbolTable.h"
SymTab* s;
int line = 1;
%}

%union {
	TokenInfo tok;
}
%token LPAREN RPAREN LBRACE RBRACE NEWLINE ASSIGNMENT VAR
%token <tok> INTEGER FLOATING ADDITION SUBTRACTION MULTIPLICATION DIVISION MODULUS FUNC
%token <tok> EQUALITY LESS GREATER
%type <tok> expr
%type <tok> line

%%
program: program line {} | /* e */ ;

line: expr NEWLINE {printf("%g\n", $1.val);}
    | LBRACE line RBRACE { 
		enterScope(s); 
		$$.val = $2.val; 
		leaveScope(s);
	}
    ;

expr: FLOATING { $$ = $1; }
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
	fprintf(stderr, "Error: %s at line %d\n", s, line);
}

int main(int argc, char* argv[]) {
	s = mkSymTab();
	int result = yyparse();
	return result;
}
