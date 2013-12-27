%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "SymbolTable.h"

SymTab* s;

%}

%%

\/\*.*\*\/ {
	//Do nothing
}

\/\/.*\n {
	//Do nothing
}
[A-z]+	{ 
	//printf("VARIABLE: %s\n", yytext);
	return VAR;
}

[0-9]+ {
	//printf("NUMBER");
	return INTEGER;
}

[0-9]+.[0-9]+ {
	//printf("FLOAT");
	return FLOATING;
}
:=	{
	//printf("ASSIGNMENT");
	return ASSIGNMENT;
}
\+	{
	//printf("ADD");
	return ADDITION;
}
\-	{
	//printf("SUBTRACT");
	return SUBTRACTION;
}
\*	{
	//printf("MULT");
	return MULTIPLICATION;
}
\/	{
	//printf("DIVIDE");
	return DIVISION;
}
\(	{
	//printf("LPAREN");
	return LPAREN;
}
\)	{
	//printf("RPAREN");
	return RPAREN;
}
\{	{
	enterScope(s);
	//printf("LBRACE");
	return LBRACE;
}
\}	{
	
	leaveScope(s);
	//printf("RBRACE");
	return RBRACE;
}

\%	{
	//printf("MOD");
	return MODULUS;
}
\=	{
	return EQUALITY;
}

\<	{
	return LESS;
}

\>	{
	return GREATER;
}

\n	{
	return NEWLINE;
}
.	{
	printf("ERROR: Unknown Token %s\n", yytext);
}

%%

int yywrap() {
	return 1; //scan forever
}
/*
int main(int argc, char* argv[]) {
	s = mkSymTab();
	yyin = stdin;
	if(argc > 1)
		yyin = fopen(argv[1], "r");
	return yylex();
}
*/
