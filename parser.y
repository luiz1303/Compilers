/* Trabalho de Compiladores - Análise Semântica
Aluno: Luiz Ricardo Brumati De Lima
UTFPR-PB - RA: a2155184 */

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "armazenamento.h"

    extern void yyerror(const char *msg);
    extern int yylex(void);

    ARMAZENAMENTO *armazenamento; //Lista Encadeada usada para armazenar as variáveis declaradas pelo usuário
%}


%union {
    /*Relacionado a YYSTYPE, usada no analisador léxico*/

    int val;
    char* lexic_val;
}

%token  PROG
        START
        END
        READ
        PRINT
        FUNC
        VAR
        INT_TYPE
        REAL_TYPE
        BOOL_TYPE
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
        NUM
        ID    

%right NOT
%left  MULT DIV
%left  PLUS MINUS
%left  SMALLER BIGGER SMALLEQ BIGGEQ
%left  EQUAL DIF
%left  TRUE FALSE
%right ASSIGN


%type <val> numero fator termo simples expressao identificador
%start programa

%%

/* 
%type <val> não-terminais  ---> Especifíca que os não terminais numero,fator,termo..etc serão do tipo val, criado na %union

%start programa  ---> Especifíca qual não-terminal será usado como início da gramática */







/*
A linguagem Small L é ambígua, visto que pode apresentar mais de uma árvore de derivação para enunciados com if, then e else.
O livro Compiladores: Princípios, Técnicas e Ferramentas (Alfred V. Aho), pag. 78, propõe um solução para tal caso
que pode ser incorporada diretamente na gramática: Associar cada else ao then anterior mais próximo, quando este último ainda não está associado.
*/

programa: PROG identificador SCOLON bloco                         {printf("\n\033[0;32m ---> ANALISE CONCLUIDA: Nenhum erro foi encontrado.\033[0;37m");}
    ;
bloco: VAR declaracao START comandos END                          { }
    ;
declaracao: nome_var COLON tipo SCOLON                            { }
    | nome_var COLON tipo SCOLON declaracao                       { }
    ;
nome_var: identificador                                           { }
    | identificador COMMA nome_var                                { }
    ;
tipo: INT_TYPE                                                    { }
    | REAL_TYPE                                                   { }
    | BOOL_TYPE                                                   { }
    ;
comandos: comando                                                 { }
    | comando SCOLON comandos                                     { }
    ;
/*Correção de ambiguidade*/
comando: cmd_Associado                                            { }
    | cmd_NaoAssociado                                            { }                
    ;
cmd_Associado: IF expressao THEN cmd_Associado ELSE cmd_Associado { }                  
    | atribuicao                                                  { }
    | enquanto                                                    { }
    | leitura                                                     { }
    | escrita                                                     { }
    ;
cmd_NaoAssociado: IF expressao THEN comando                       { }
    | IF expressao THEN cmd_Associado ELSE cmd_NaoAssociado       { }
    ;
/*Fim da correção de ambiguidade*/
atribuicao: identificador ASSIGN expressao                        { }
    ;
enquanto: WHILE expressao DO cmd_Associado                        { }
    ;
leitura: READ OPNPAR identificador CLSEPAR                        { }
    ;
escrita: PRINT OPNPAR identificador CLSEPAR                       { }
    ;
expressao: simples                                                { }
    | simples opRelacional simples                                { }
    ;
opRelacional: DIF                                                 { }
    | EQUAL                                                       { }
    | SMALLER                                                     { }
    | BIGGER                                                      { }
    | SMALLEQ                                                     { }
    | BIGGEQ                                                      { }
    ;
simples: termo operador termo                                     { }
    | termo                                                       { }
    ;
operador: PLUS                                                    { }
    | MINUS                                                       { }
    | OR                                                          { }
    ;
termo: fator                                                      { }
    | fator op fator                                              { }
    ;
op: MULT                                                          { }
    | DIV                                                         { }
    | AND                                                         { }
    ;
fator: identificador                                              { }
    | numero                                                      { }
    | OPNPAR expressao CLSEPAR                                    { }
    | TRUE                                                        { }
    | FALSE                                                       { }
    | NOT fator                                                   { }
    ;
identificador: ID                                                 { }
    ;
numero: NUM                                                       { }
    ;
%%


/*
    %union:
    https://www.gnu.org/software/bison/manual/html_node/Union-Decl.html

    %type
    https://www.gnu.org/software/bison/manual/html_node/Type-Decl.html

    Ações semânticas:
    https://www.gnu.org/software/bison/manual/html_node/Semantic-Actions.html
*/