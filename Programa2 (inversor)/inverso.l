%{
    #include "inverso.tab.h"
    #define MAX_LENGTH 100  // Asegúrate de definir MAX_LENGTH aquí también
%}

%%

0       { return ZERO; }
1       { return ONE; }
\n      { return '\n'; }
.       { yyerror("Caracter no reconocido"); }

%%

int yywrap(void) {
    return 1;
}

