%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start statement_list

%union { int i; char* str; float fl; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<fl> FLOAT
%type<str> END
%type<str> POINT
%type<str> LINE
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> SET_COLOR

%%

statement_list: statement END
	|	statement statement_list END
;

statement: point_command END_STATEMENT
	| line_command END_STATEMENT
	| circle_command END_STATEMENT
	| rect_command END_STATEMENT
	| set_color_command END_STATEMENT
;

point_command: POINT INT INT
	{ point($2, $3); }
;

line_command: LINE INT INT INT INT
	{ line($2, $3, $4, $5); }
;

circle_command: CIRCLE INT INT INT
	{ circle($2, $3, $4); }
;

rect_command: RECTANGLE INT INT INT INT
	{ rectangle($2, $3, $4, $5); }
;

set_color_command: SET_COLOR INT INT INT
	{ set_color($2, $3, $4); }
;

%%

int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
