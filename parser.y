%{
    #include <stdio.h>
    #include <stdlib.h>

    int yyval;
    extern int yyerror(char *s)
    extern int yylex();
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
        WHILE
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
        BIGGEQ

        NUMINT
        NUMREAL
        ID    

%right NOT //Not possui a menor prioridade na lista de precedências
%left  PLUS MINUS //Mais e menos possuem mesma precedência
%left  MULT DIV //Multiplicação e Divisão possuem a mesma precedêncencia (E possuem maior prioridade que + e -)
%left  SMALLER BIGGER SMALLEQ BIGGEQ
%left  EQUAL DIF
%right ASSIGN

%%

//GLC

%%

//Código em C
