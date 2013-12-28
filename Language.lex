%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "SymbolTable.h"

#ifdef TestLex
#define LPAREN 258
#define RPAREN 259
#define LBRACE 260
#define RBRACE 261
#define NEWLINE 262
#define ASSIGNMENT 263
#define INTEGER 264
#define FLOATING 265
#define ADDITION 266
#define SUBTRACTION 267
#define MULTIPLICATION 268
#define DIVISION 269
#define MODULUS 270
#define EQUALITY 271
#define LESS 272
#define GREATER 273
#define VAR 274
#endif
%}

%%
\/\*.*\*\/ {
	//Do nothing
}

\/\/.*\n {
	//Do nothing
}
[A-z]+	{ 
	yylval.tok.val = 0;
	yylval.tok.name = (char*) strdup(yytext);
	return VAR;
}

[0-9]+ {
	//printf("NUMBER");
	yylval.tok.val = atoi(yytext);
	yylval.tok.name = 0;
	return INTEGER;
}

[0-9]+.[0-9]+ {
	yylval.tok.val = atoi(yytext);
	yylval.tok.name = 0;
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
	//printf("LBRACE");
	return LBRACE;
}
\}	{
	
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

[ ]  ;

.	{
	printf("ERROR: Unknown Token %s\n", yytext);
}

%%

int yywrap() {
	return 1; //scan forever
}
#ifdef TestLex
int main(int argc, char* argv[]) {
	yyin = stdin;
	if(argc > 1)
		yyin = fopen(argv[1], "r");
	return yylex();
}
#endif
