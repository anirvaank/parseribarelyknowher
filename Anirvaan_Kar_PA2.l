%{
#include <stdio.h>
#include "parser.tab.h"
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

/* Single-char set (handled in action) */
P_SINGLE      [\*\+\/\-\<\>\=\(\)\,\;\.\:]

/* Whitespace */
WS            [ \t\r\n]+

%%
{COMMENT}          { }
{WS}               { }

{KW_PROGRAM}       { return PROGRAM; }
{KW_FUNCTION}      { return FUNCTION; }
{KW_VAR}           { return VAR; }
{KW_INTEGER}       { return INTEGER; }
{KW_STRING}        { return STRING; }
{KW_WHILE}         { return WHILE; }
{KW_DO}            { return DO; }
{KW_IF}            { return IF; }
{KW_THEN}          { return THEN; }
{KW_ELSE}          { return ELSE; }
{KW_BEGIN}         { return KW_BEGIN; }
{KW_END}           { return KW_END; }

{ID}               { return ID; }
{ZERO}             { return NUM; }
{SIGNED_NZINT}     { return NUM; }
{STRING}           { return STR; }

{P_LE}             { return LE; }
{P_GE}             { return GE; }
"=="               { return EQ; }
"="                { return EQ; }
{P_NE}             { return NEQ; }
{P_ASSIGN}         { return ASSIGN; }

{P_SINGLE}         {
    switch (yytext[0]) {
        case '<': return LT;
        case '>': return GT;
        case '+': return PLUS;
        case '-': return MINUS;
        case '*': return STAR;
        case '/': return SLASH;
        case '(': return LPAREN;
        case ')': return RPAREN;
        case ',': return COMMA;
        case ';': return SEMI;
        case '.': return DOT;
        case ':': return COLON;
        case '=': return EQ;
        default:  return yytext[0];
    }
}

.                  { return yytext[0]; }

%%
/* nothing else */
