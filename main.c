#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
extern FILE* yyin;

int main(int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror("fopen"); return 1; }
    }
    yylex();
    if (yyin && yyin != stdin) fclose(yyin);
    return 0;
}
