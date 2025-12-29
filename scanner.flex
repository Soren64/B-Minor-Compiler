%option yylineno
%{
#include "token.h"
%}
DIGIT  [0-9]
LETTER [a-zA-Z]
%x COMMENT_BLOCK
%%
(" "|\t|\n)  /* skip whitespace */
 \/\/.*\n    /* skip single line comments */
"/*"            { BEGIN(COMMENT_BLOCK); }
<COMMENT_BLOCK>"*/" { BEGIN(INITIAL); }
<COMMENT_BLOCK>.    { }  /* skip comment block */
 \(        { return TOKEN_LEFTPAR; }
 \)        { return TOKEN_RIGHTPAR; }
 \[        { return TOKEN_LEFTBRACK; }
 \]        { return TOKEN_RIGHTBRACK; }
 \{        { return TOKEN_LEFTBRACE; }
 \}        { return TOKEN_RIGHTBRACE; }
 \:        { return TOKEN_COLON; }
 \;        { return TOKEN_SEMICOL; }
 \,        { return TOKEN_COMMA; }
 \^        { return TOKEN_EXP; }  
 \*        { return TOKEN_MULT; }
 \/        { return TOKEN_DIV; }
 \%        { return TOKEN_MOD; }
 \+\+      { return TOKEN_INC; }
 \+        { return TOKEN_ADD; }
 \-\-      { return TOKEN_DEC; }
 \-{DIGIT}+ { return TOKEN_NEG; }
 \-        { return TOKEN_SUB; }
 \!\=      { return TOKEN_NOTEQ; }
 \!        { return TOKEN_NOT; }
 \=\=      { return TOKEN_ASSIGN; }
 \<\=      { return TOKEN_LESSEQ; }
 \<        { return TOKEN_LESS; }
 \>\=      { return TOKEN_GREATEQ; }
 \>        { return TOKEN_GREAT; }
 \&\&      { return TOKEN_AND; }
 \|\|      { return TOKEN_OR; }
while      { return TOKEN_WHILE; }
for	   { return TOKEN_FOR; }
array      { return TOKEN_ARRAY; }
print      { return TOKEN_PRINT; }
auto       { return TOKEN_AUTO; }
true       { return TOKEN_TRUE; }
false      { return TOKEN_FALSE; }
function   { return TOKEN_FUNC; }
integer    { return TOKEN_INT; }
boolean    { return TOKEN_BOOL; }
char       { return TOKEN_CHAR; }
if         { return TOKEN_IF; }
else       { return TOKEN_ELSE; }
return     { return TOKEN_RET; }
void       { return TOKEN_VOID; }
\'.\' { return TOKEN_CHARLIT; }
\".{0,256}\" { return TOKEN_STRLIT; }
(_|{LETTER})({LETTER}|_|{DIGIT}){0,255}   { return TOKEN_IDENT; }
{DIGIT}+   { return TOKEN_NUMBER; }
.          { return TOKEN_ERROR; }
%%
int yywrap() { return 1; }
