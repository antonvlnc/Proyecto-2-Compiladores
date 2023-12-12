%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define MAX_LENGTH 100  // Definir MAX_LENGTH aquí
    char *buffer;           
    int buffer_index;       
    int length;             
    int yylex(void);
    void yyerror(char *);
    void reverseAndPrint(char *str, int length);
%}

%token ZERO ONE
%start input

%%

input:
    /* empty */
    | input sequence '\n'  { reverseAndPrint(buffer, buffer_index); free(buffer); buffer_index = 0; }
    ;

sequence:
    ZERO        { buffer[buffer_index++] = '0'; }
    | ONE       { buffer[buffer_index++] = '1'; }
    | sequence ZERO  { buffer[buffer_index++] = '0'; }
    | sequence ONE   { buffer[buffer_index++] = '1'; }
    ;

%%

void reverseAndPrint(char *str, int length) {
    for (int i = length - 1; i >= 0; i--) {
        printf("%c", str[i]);
    }
    printf("\n");
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    buffer_index = 0;
    buffer = (char*)malloc(MAX_LENGTH * sizeof(char));
    if (buffer == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria\n");
        return 1;
    }
    freopen("cadenas.txt", "r", stdin);
    yyparse();
    return 0;
}

