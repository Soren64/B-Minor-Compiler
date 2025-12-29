%token TOKEN_EOF
%token TOKEN_LEFTPAR
%token TOKEN_RIGHTPAR
%token TOKEN_LEFTBRACK
%token TOKEN_RIGHTBRACK
%token TOKEN_LEFTBRACE
%token TOKEN_RIGHTBRACE
%token TOKEN_SEMICOL
%token TOKEN_COLON
%token TOKEN_COMMA
%token TOKEN_INC
%token TOKEN_DEC
%token TOKEN_NEG
%token TOKEN_NOT
%token TOKEN_NOTEQ
%token TOKEN_ASSIGN
%token TOKEN_EQ
%token TOKEN_LESS
%token TOKEN_LESSEQ
%token TOKEN_GREAT
%token TOKEN_GREATEQ
%token TOKEN_AND
%token TOKEN_OR
%token TOKEN_ADD
%token TOKEN_SUB
%token TOKEN_MULT
%token TOKEN_DIV
%token TOKEN_MOD
%token TOKEN_EXP
%token TOKEN_IDENT
%token TOKEN_NUMBER
%token TOKEN_AUTO
%token TOKEN_WHILE
%token TOKEN_ARRAY
%token TOKEN_PRINT
%token TOKEN_INT
%token TOKEN_FOR
%token TOKEN_FUNC
%token TOKEN_IF
%token TOKEN_ELSE
%token TOKEN_BOOL
%token TOKEN_TRUE
%token TOKEN_FALSE
%token TOKEN_RET
%token TOKEN_VOID
%token TOKEN_CHAR
%token TOKEN_CHARLIT
%token TOKEN_STRING
%token TOKEN_STRLIT
%token TOKEN_ERROR

%{

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

extern char *yytext;
extern int yylex();
extern int yyerror( char *str );

%}

%%


program : statement TOKEN_SEMICOL
	| statement program { return 0; }
	;
	
statement : TOKEN_IF expr TOKEN_THEN statement
	| TOKEN_IF expr TOKEN_THEN statement TOKEN_ELSE statement
	| TOKEN_FOR TOKEN_LEFTPAR expr TOKEN_SEMICOL expr TOKEN_SEMICOL expr TOKEN_RIGHTPAR	//For loop
	| TOKEN_WHILE expr statement
	| TOKEN_PRINT expr
	| expr
	;

expr	: expr TOKEN_PLUS expr
	| expr TOKEN_MINUS expr
	| expr TOKEN_MUL expr
	| expr TOKEN_DIV expr
	| expr TOKEN_MOD expr
	| expr TOKEN_EXP expr
	| TOKEN_NEG expr
	| TOKEN_NOT expr
	| expr TOKEN_INC
	| expr TOKEN_DEC
	| expr TOKEN_EQ expr
	| expr TOKEN_LESS expr
	| expr TOKEN_LESSEQ expr
	| expr TOKEN_GREAT expr
	| expr TOKEN_GREATEQ expr
	| expr TOKEN_AND expr
	| expr TOKEN_OR expr
	| expr TOKEN_NOTEQ expr
	| TOKEN_LEFTPAR expr TOKEN_RIGHTPAR
	| TOKEN_LEFTBRACK expr TOKEN_RIGHTBRACK
	| TOKEN_IDENT TOKEN_LEFTPAR expr TOKEN_RIGHTPAR 	//Function call
	| TOKEN_IDENT TOKEN_ASSIGN expr
	| TOKEN_NUMBER		//int literal
	| TOKEN_CHARLIT
	| TOKEN_STRLIT
	| TOKEN_TRUE
	| TOKEN_FALSE
	| TOKEN_INDENT
	;

%%

int yyerror( char *str )
{
	printf("parse error: %s\n",str);
	return 0;
}
