/* Trabalho de Compiladores - Análise Sintática
Aluno: Luiz Ricardo Brumati De Lima
UTFPR-PB - RA: a2155184 */

%{
    #include <stdio.h>
    #include <stdlib.h>

    extern void yyerror(const char *msg);
    extern int yylex(void);
%}

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

%%

/*
A linguagem Small L é ambígua, visto que pode apresentar mais de uma árvore de derivação para enunciados com if, then e else.
O livro Compiladores: Princípios, Técnicas e Ferramentas (Alfred V. Aho), pag. 78, propõe um solução para tal caso
que pode ser incorporada diretamente na gramática: Associar cada else ao then anterior mais próximo, quando este último ainda não está associado.
*/

programa: PROG identificador SCOLON bloco        {printf("P -> programa ID ; BLOCO \n\n\033[0;32m ---> ANALISE SINTATICA CONCLUIDA: Nenhum erro foi encontrado.\033[0;37m");};
    ;
bloco: VAR declaracao START comandos END         {printf("B -> var DECLARACAO inicio COMANDOS fim\n");}
    ;
declaracao: nome_var COLON tipo SCOLON           {printf("DECLARACAO -> NOMEVAR : TIPO ;\n");}
    | nome_var COLON tipo SCOLON declaracao      {printf("DECLARACAO -> NOMEVAR : TIPO ; DECLARACAO\n");}
    ;
nome_var: identificador                          {printf("NOMEVAR -> IDENTIFICADOR\n");}
    | identificador COMMA nome_var               {printf("NOMEVAR -> IDENTIFICADOR , NOMEVAR\n");}
    ;
tipo: INT_TYPE                                   {printf("TIPO -> tipo_inteiro\n");}
    | REAL_TYPE                                  {printf("TIPO -> tipo_real\n");}
    | BOOL_TYPE                                  {printf("TIPO -> tipo_booleano\n");}
    ;
comandos: comando                                {printf("COMANDOS -> COMANDO\n");}
    | comando SCOLON comandos                    {printf("COMANDOS -> COMANDO ; COMANDOS\n");}
    ;
    /*Correção de ambiguidade*/
comando: cmd_Associado                           {printf("COMANDO -> COMANDO_ASSOCIADO\n");}
    | cmd_NaoAssociado                           {printf("COMANDO -> COMANDO_NAO_ASSOCIADO\n");}                 
    ;
cmd_Associado: IF expressao THEN cmd_Associado ELSE cmd_Associado {printf("COMANDO_ASSOCIADO -> se EXPRESSAO entao COMANDO_ASSOCIADO senao COMANDO_ASSOCIADO\n");}  
    | atribuicao                                 {printf("COMANDO -> ATRIBUICAO\n");}
    | enquanto                                   {printf("COMANDO -> ENQUANTO\n");}
    | leitura                                    {printf("COMANDO -> LEITURA\n");}
    | escrita                                    {printf("COMANDO -> ESCRITA\n");}
    ;
cmd_NaoAssociado: IF expressao THEN comando      {printf("COMANDO_NAO_ASSOCIADO -> se EXPRESSAO entao COMANDO\n");}
    | IF expressao THEN cmd_Associado ELSE cmd_NaoAssociado {printf("COMANDO_NAO_ASSOCIADO -> se EXPRESSAO entao COMANDO_ASSOCIADO senao COMANDO_NAO_ASSOCIADO\n");}
    ;
/*Fim da correção de ambiguidade*/
atribuicao: identificador ASSIGN expressao       {printf("ATRIBUICAO -> IDENTIFICADOR := EXPRESSAO\n");}
    ;
enquanto: WHILE expressao DO cmd_Associado       {printf("ENQUANTO -> enquanto EXPRESSAO faca CMD_ASSOCIADO\n");}
    ;
leitura: READ OPNPAR identificador CLSEPAR       {printf("LEITURA -> leia (IDENTIFICADOR)\n");}
    ;
escrita: PRINT OPNPAR identificador CLSEPAR      {printf("LEITURA -> escreva (IDENTIFICADOR)\n");}
    ;
expressao: simples                               {printf("EXPRESSAO -> SIMPLES\n");}
    | simples opRelacional simples               {printf("EXPRESSAO -> SIMPLES OP_RELACIONAL SIMPLES\n");}
    ;
opRelacional: DIF                                {printf("OP_RELACIONAL -> <>\n");}
    | EQUAL                                      {printf("OP_RELACIONAL -> =\n");}
    | SMALLER                                    {printf("OP_RELACIONAL -> <\n");}
    | BIGGER                                     {printf("OP_RELACIONAL -> >\n");}
    | SMALLEQ                                    {printf("OP_RELACIONAL -> <=\n");}
    | BIGGEQ                                     {printf("OP_RELACIONAL -> >=\n");}
    ;
simples: termo operador termo                    {printf("SIMPLES -> TERMO OPERADOR TERMO\n");}
    | termo                                      {printf("SIMPLES -> TERMO\n");}
    ;
operador: PLUS                                   {printf("OPERADOR -> +\n");}
    | MINUS                                      {printf("OPERADOR -> -\n");}
    | OR                                         {printf("OPERADOR -> ou\n");}
    ;
termo: fator                                     {printf("TERMO -> FATOR\n");}
    | fator op fator                             {printf("TERMO -> FATOR OPERADOR FATOR\n");}
    ;
op: MULT                                         {printf("OP -> *\n");}
    | DIV                                        {printf("OP -> div\n");}
    | AND                                        {printf("OP -> e\n");}
    ;
fator: identificador                             {printf("FATOR -> IDENTIFICADOR\n");}
    | numero                                     {printf("FATOR -> NUMERO\n");}
    | OPNPAR expressao CLSEPAR                   {printf("FATOR -> (EXPRESSAO)\n");}
    | TRUE                                       {printf("FATOR -> verdadeiro\n");}
    | FALSE                                      {printf("FATOR -> falso\n");}
    | NOT fator                                  {printf("FATOR -> not FATOR\n");}
    ;
identificador: ID                                {printf("IDENTIFICADOR -> id\n");}
    ;
numero: NUM                                      {printf("NUMERO -> num\n");}
    ;
%%