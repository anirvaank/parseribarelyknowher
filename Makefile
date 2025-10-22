# ===== Config: set your name or rename files to match =====
NAME    ?= Anirvaan_Kar
LEXERL  := $(NAME)_PA1.l
TESTNP  := $(NAME)_PA1.np

LEX     ?= flex
CC      ?= gcc
CFLAGS  ?= -O2 -Wall
LDFLAGS ?=
LDLIBS  ?=   # with %option noyywrap, -lfl not needed

# Default: build and run on the sample
all: lexer run

# Build the lexer
lexer: lex.yy.o main.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

# Generate scanner from .l
lex.yy.c: $(LEXERL)
	$(LEX) -o $@ $<

# Compile objects
lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c $<

main.o: main.c
	$(CC) $(CFLAGS) -c $<

# Run on your sample .np file
run: lexer $(TESTNP)
	@echo "== Running lexer on $(TESTNP) =="
	./lexer $(TESTNP)

# Clean build artifacts
clean:
	rm -f lex.yy.c *.o lexer

.PHONY: all run clean
