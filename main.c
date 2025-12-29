#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;
extern int yylineno;

int main()
{
	yyin = fopen("good1.bminor","r"); //manually replace with name with respective file name
	if(!yyin) {
		printf("could not open program.\n");
		return 1;
	}

	while(1) {
		token_t t = yylex();
		if(t==TOKEN_EOF) break;
		if(t==TOKEN_ERROR) 
			printf("[ERROR] Unrecognized token: %d  text: %s  line: %d\n",t,yytext,yylineno);
		//printf("token: %d  text: %s  line: %d\n",t,yytext,yylineno);
	}
	
	if(yyparse()==0) {
		printf("parse successful: ");
		return 0;
	} else {
		printf("parse failed!\n");
		return 1;
	}
}


