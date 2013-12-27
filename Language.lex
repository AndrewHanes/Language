%{
#include <stdlib.h>
#include <stdio.h>
#include "SymbolTable.h"
%}

%%

[a..z]+	return STRING;
:=	return ASSIGNMENT;
\+	return PLUS;
\-	return MINUS;
\*	return MULT;
\/	return DIVIDE;
\(	return LPAREN;
\)	return RPAREN;
\{	return LBRACE;
\}	return RBRACE;


%%

int yywrap() {
	return 1;
}
