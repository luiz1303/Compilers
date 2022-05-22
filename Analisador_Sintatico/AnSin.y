%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();
    int yyval;
    extern ARQ *yyin; //Arquivo de entrada ARQ declarado no Analisador Léxico
%}

%token  PROG
        BEGIN
        END

        READ
        PRINT
        FUNC
        PROCED

        VAR
        INT
        REAL
        BOOL

        TRUE
        FALSE
        NOT
        AND
        OR

        IF
        ELSE
        THEN
        DO

        OPNPAR
        CLSEPAR
        PLUS
        MINUS
        MULT
        DIV

        COLON
        SCOLON
        COMMA
        EQUAL
        SMALLER
        BIGGER
        ASSIGN
        DIF
        SMALLEQ
        BIGEQ

        NUM
        NUMREAL
        ID    

%right NOT
%left  PLUS MINUS
%left  MULT DIV
%left  SMALLER BIGGER SMALLEQ BIGEQ
%left  EQUAL DIF
%right ASSIGN

%%

//GLC

%%
#include "lex.yy.c"

int main () {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf("\n\033[0;31mERROR: %c\033[0;37m\n", s); 
}

int yywrap() {
    return 1;
}
