%{
#include <stdio.h>

static void print_tok(const char* type, const char* text) {
    printf("%s: %s\n", type, text);
}
%}

%option noyywrap
%option nounput noinput
%option yylineno

/* ===== Definitions ===== */

/* Keywords (ALL CAPS, case-sensitive) */
KW_PROGRAM    PROGRAM
KW_FUNCTION   FUNCTION
KW_VAR        VAR
KW_INTEGER    INTEGER
KW_STRING     STRING
KW_WHILE      WHILE
KW_DO         DO
KW_IF         IF
KW_THEN       THEN
KW_ELSE       ELSE
KW_BEGIN      BEGIN
KW_END        END

/* Identifiers: one or more lower-case letters */
ID            [a-z]+

/* Integers */
ZERO          0
NZDIGIT       [1-9]
DIGIT         [0-9]
SIGNED_NZINT  [\+\-]?{NZDIGIT}{DIGIT}*

/* Strings: single quotes; letters/digits/space; empty allowed */
STRCHR        [A-Za-z0-9 ]
STRING        \'({STRCHR})*\'

/* Comments { ... } no newline inside */
COMMENT       \{[^}\n]*\}

/* Punctuators */
P_LE          <=
P_GE          >=
P_NE          <>
P_ASSIGN      :=
P_SINGLE      [\*\+\/\-\<\>\=\(\)\,\;\.\:]

/* Whitespace */
WS            [ \t\r\n]+

%%

{COMMENT}          { /* ignore */ }
{WS}               { /* ignore */ }

{KW_PROGRAM}       { print_tok("KEYWORD", yytext); }
{KW_FUNCTION}      { print_tok("KEYWORD", yytext); }
{KW_VAR}           { print_tok("KEYWORD", yytext); }
{KW_INTEGER}       { print_tok("KEYWORD", yytext); }
{KW_STRING}        { print_tok("KEYWORD", yytext); }
{KW_WHILE}         { print_tok("KEYWORD", yytext); }
{KW_DO}            { print_tok("KEYWORD", yytext); }
{KW_IF}            { print_tok("KEYWORD", yytext); }
{KW_THEN}          { print_tok("KEYWORD", yytext); }
{KW_ELSE}          { print_tok("KEYWORD", yytext); }
{KW_BEGIN}         { print_tok("KEYWORD", yytext); }
{KW_END}           { print_tok("KEYWORD", yytext); }

{ID}               { print_tok("IDENTIFIER", yytext); }

{ZERO}             { print_tok("CONSTANT", yytext); }
{SIGNED_NZINT}     { print_tok("CONSTANT", yytext); }

{STRING}           { print_tok("STRING_LITERAL", yytext); }

{P_LE}             { print_tok("PUNCTUATOR", yytext); }
{P_GE}             { print_tok("PUNCTUATOR", yytext); }
{P_NE}             { print_tok("PUNCTUATOR", yytext); }
{P_ASSIGN}         { print_tok("PUNCTUATOR", yytext); }
{P_SINGLE}         { print_tok("PUNCTUATOR", yytext); }

.                  { printf("UNRECOGNIZED_CHARACTER: %c\n", yytext[0]); }

%%
/* nothing else */
