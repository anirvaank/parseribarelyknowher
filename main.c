// #include <stdio.h>
// #include <stdlib.h>

// extern int yylex(void);
// extern FILE* yyin;

// int main(int argc, char** argv) {
//     if (argc > 1) {
//         yyin = fopen(argv[1], "r");
//         if (!yyin) { perror("fopen"); return 1; }
//     }
//     yylex();
//     if (yyin && yyin != stdin) fclose(yyin);
//     return 0;
// }
#include <stdio.h>
#include <stdlib.h>

int yyparse(void);
extern FILE* yyin;

int main(int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror("fopen"); return 1; }
    }
    if (yyparse() == 0) {
        printf("Parsed successfully.\n");
    }
    if (yyin && yyin != stdin) fclose(yyin);
    return 0;
}
