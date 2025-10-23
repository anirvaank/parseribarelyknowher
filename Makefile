# 

.RECIPEPREFIX := >
NAME    ?= Anirvaan_Kar
LEXERL  := $(NAME)_PA2.l
PARSERY := $(NAME)_PA2.y
TESTNP  ?= $(NAME)_PA2.np

LEX     ?= flex
YACC    ?= bison
CC      ?= gcc
CFLAGS  ?= -O2 -Wall
LDFLAGS ?=
LDLIBS  ?=

all: run

parser: parser.tab.o lex.yy.o main.o
> $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

parser.tab.c parser.tab.h: $(PARSERY)
> $(YACC) -d -o parser.tab.c --defines=parser.tab.h $<

lex.yy.c: $(LEXERL) parser.tab.h
> $(LEX) -o $@ $<

parser.tab.o: parser.tab.c
> $(CC) $(CFLAGS) -c $<

lex.yy.o: lex.yy.c parser.tab.h
> $(CC) $(CFLAGS) -c $<

main.o: main.c parser.tab.h
> $(CC) $(CFLAGS) -c main.c

run: parser $(TESTNP)
> ./parser $(TESTNP)

clean:
> rm -f parser parser.tab.c parser.tab.h lex.yy.c *.o

.PHONY: all run clean
