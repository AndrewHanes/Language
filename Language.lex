%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "SymbolTable.h"

#ifdef TestLex
#define END 10
#define LPAREN 258
#define FUNC 258
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

goto[ ]+\([A-z]+\) {
	FILE* f = yyin;
	if(yyin == stdin) {
		//printf(stderr, "Cannot goto using stdin\n");
		return END;
	}
}
func[ ]+[A-z]+\(([A-z]+.*)*\) {
	#ifndef TestLex
	yylval.tok.val = 0;
	yylval.tok.name = (char*) strdup(yytext);
	#endif
	return FUNC;
}

[A-z]+	{ 
	#ifndef TestLex
	yylval.tok.val = 0;
	yylval.tok.name = (char*) strdup(yytext);
	#endif
	//printf("VARIABLE");
	return VAR;
}
\-	{
	//printf("SUBTRACT");
	return SUBTRACTION;
}

[0-9]+\.[0-9]+ {
	#ifndef TestLex
	yylval.tok.val = atof(yytext);
	yylval.tok.name = 0;
	#endif
	//printf("FLOAT");
	return FLOATING;
}

[0-9]+ {
	#ifndef TestLex
	yylval.tok.val = atoi(yytext);
	yylval.tok.name = 0;
	#endif
	//printf("NUMBER");
	return INTEGER;
}

\:=	{
	//printf("ASSIGNMENT");
	return ASSIGNMENT;
}
\+	{
	//printf("ADD");
	return ADDITION;
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

\; {
	return END;
}

[ \n\t] ;

.	{
	fprintf(stderr, "ERROR: Unknown Token %s\n", yytext);
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
