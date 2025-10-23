%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
%}

%define parse.error verbose

%token PROGRAM FUNCTION VAR INTEGER STRING
%token WHILE DO IF THEN ELSE KW_BEGIN KW_END
%token ID NUM STR
%token PLUS MINUS STAR SLASH
%token LT GT LE GE EQ NEQ
%token ASSIGN LPAREN RPAREN COMMA SEMI DOT COLON

%nonassoc LT GT LE GE EQ NEQ
%left PLUS MINUS
%left STAR SLASH
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%

program
  : PROGRAM ID SEMI declaration_list_opt function_declaration_list_opt compound_statement DOT
  ;

declaration_list_opt
  :
  | declaration_list
  ;

declaration_list
  : declaration_list VAR variable_list COLON type SEMI
  | VAR variable_list COLON type SEMI
  ;

variable_list
  : ID
  | variable_list COMMA ID
  ;

type
  : INTEGER
  | STRING
  ;

function_declaration_list_opt
  :
  | function_declaration_list
  ;

function_declaration_list
  : function_declaration_list function_declaration SEMI
  | function_declaration SEMI
  ;

function_declaration
  : function_header declaration_list_opt compound_statement
  ;

function_header
  : FUNCTION ID LPAREN parameter_list RPAREN COLON type SEMI
  ;

parameter_list
  : variable_list COLON type
  | parameter_list SEMI variable_list COLON type
  ;

compound_statement
  : KW_BEGIN statement_list opt_semi KW_END
  ;

opt_semi
  :
  | SEMI
  ;

statement_list
  : statement
  | statement_list SEMI statement
  ;

statement
  : ID ASSIGN expression
  | ID LPAREN RPAREN
  | ID LPAREN expression_list RPAREN
  | compound_statement
  | selection_statement
  | iteration_statement
  ;

selection_statement
  : IF expression THEN statement %prec LOWER_THAN_ELSE
  | IF expression THEN statement ELSE statement
  ;

iteration_statement
  : WHILE expression DO statement
  ;

expression_list
  : expression
  | expression_list COMMA expression
  ;

expression
  : simple_expression
  | simple_expression LT simple_expression
  | simple_expression GT simple_expression
  | simple_expression LE simple_expression
  | simple_expression GE simple_expression
  | simple_expression EQ simple_expression
  | simple_expression NEQ simple_expression
  ;

simple_expression
  : term
  | simple_expression PLUS term
  | simple_expression MINUS term
  ;

term
  : factor
  | term STAR factor
  | term SLASH factor
  ;

factor
  : ID
  | NUM
  | STR
  | LPAREN expression RPAREN
  | ID LPAREN expression_list RPAREN
  | PLUS factor
  | MINUS factor
  ;

%%

void yyerror(const char *s) {
    extern int yylineno;
    extern char *yytext;
    printf("%s at line %d near '%s'\n", s, yylineno, yytext ? yytext : "");
}
