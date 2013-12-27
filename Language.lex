%{
#include <stdlib.h>
#include <stdio.h>
#include "SymbolTable.h"

SymTab s = mkSymTab();
%}

%%

[a..z]+	{ 
	printf("VARIABLE: %s\n", yytext);
}
:=	{
	printf("ASSIGNMENT");
}
\+	{
	printf("ADD");
}
\-	{
	printf("SUBTRACT");
}
\*	{
	printf("MULT");
}
\/	{
	printf("DIVIDE");
}
\(	{
	printf("LPAREN");
}
\)	{
	printf("RPAREN");
}
\{	{
	printf("LBRACE");
}
\}	{
	printf("RBRACE");
}


%%

int yywrap() {
	return 1; //scan forever
}

int main(int argc, char* argv[]) {
	yyin - stdin;
	return yylex();
}

