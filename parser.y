%{
    #include <stdio.h>
    #include <stdlib.h>

    extern void yyerror (char cont *error_msg)
    extern int yylex();
%}

%token  PROG
        BEGIN
        END

        READ
        PRINT
        FUNC
        PROCED

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
%left  PLUS MINUS
%left  MULT DIV
%left  SMALLER BIGGER SMALLEQ BIGGEQ
%left  EQUAL DIF
%left TRUE FALSE
%right ASSIGN

%%

/*
A linguagem Small L é ambígua, visto que pode apresentar mais de uma árvore de derivação para enunciados com if, then e else.
O livro Compiladores: Princípios, Técnicas e Ferramentas (Alfred V. Aho), pag. 78, propõe um solução para tal caso
que pode ser incorporada diretamente na gramática: Associar cada else ao then anterior mais próximo ainda não associado.
*/

programa: PROG identificador SCOLON bloco        {printf("P -> programa ID ; BLOCO \n\n\033[0;32m --> Análise Sintática Concluída: Nenhum erro foi encontrado.\033[0;37m");};
    ;
bloco: VAR declaracao BEGIN comandos END         {printf("B -> var DECLARACAO inicio COMANDOS fim");}
    ;
declaracao: nome_var COLON tipo SCOLON           {printf("DECLARACAO -> NOMEVAR : TIPO ;");}
    | nome_var COLON tipo SCOLON declaracao      {printf("DECLARACAO -> NOMEVAR : TIPO ; DECLARACAO");}
    ;
nome_var: identificador                          {printf("NOMEVAR -> IDENTIFICADOR");}
    | identificador COMMA nome_var               {printf("NOMEVAR -> IDENTIFICADOR , NOMEVAR");}
    ;
tipo: INT_TYPE                                   {printf("TIPO -> tipo_inteiro");}
    | REAL_TYPE                                  {printf("TIPO -> tipo_real");}
    | BOOL_TYPE                                  {printf("TIPO -> tipo_booleano");}
    ;
comandos: comando                                {printf("COMANDOS -> COMANDO");}
    | comando SCOLON comandos                    {printf("COMANDOS -> COMANDO ; COMANDOS");}
    ;

comando: atribuicao                              {printf("COMANDO -> ATRIBUICAO");}
    | condicional                                {printf("COMANDO -> CONDICIONAL");}
    | enquanto                                   {printf("COMANDO -> ENQUANTO");}
    | leitura                                    {printf("COMANDO -> LEITURA");}
    | escrita                                    {printf("COMANDO -> ESCRITA");}
    ;

atribuicao: identificador ASSIGN expressao       {printf("ATRIBUICAO -> IDENTIFICADOR := EXPRESSAO");}
    ;
/*Correção de ambiguidade*/
condicional: condAssociada                       {printf("CONDICIONAL -> CONDASSOCIADA");}
    | condNaoAssociada                           {printf("CONDICIONAL -> CONDNAOASSOCIADA");}
    ;
condAssociada: IF expressao THEN condAssociada ELSE condAssociada {printf("CONDASSOCIADA -> se EXPRESSAO entao CONDASSOCIADA senao CONDASSOCIADA");}
    ;
condNaoAssociada: IF expressao THEN condicional                    {printf("COND_NAOASSOCIADA -> se EXPRESSAO entao CONDICIONAL");}
    | IF expressao THEN condAssociada ELSE condNaoAssociada        {printf("COND_NAOASSOCIADA -> se EXPRESSAO entao CONDASSOCIADA senao COND_NAOASSOCIADA");}
    ;
/*Fim da correção de ambiguidade*/
enquanto: WHILE expressao DO comandos            {printf("ENQUANTO -> enquanto EXPRESSAO faca COMANDOS");}
    ;
leitura: READ OPNPAR identificador CLSEPAR       {printf("LEITURA -> leia (IDENTIFICADOR)");}
    ;
escrita: PRINT OPNPAR identificador CLSEPAR      {printf("LEITURA -> escreva (IDENTIFICADOR)");}
    ;
expressao: simples                               {printf("EXPRESSAO -> SIMPLES");}
    | simples opRelacional simples               {printf("EXPRESSAO -> SIMPLES OP_RELACIONAL SIMPLES");}
    ;
opRelacional: DIF                                {printf("OP_RELACIONAL -> <>");}
    | EQUAL                                      {printf("OP_RELACIONAL -> =");}
    | SMALLER                                    {printf("OP_RELACIONAL -> <");}
    | BIGGER                                     {printf("OP_RELACIONAL -> >");}
    | SMALLEQ                                    {printf("OP_RELACIONAL -> <=");}
    | BIGGEQ                                     {printf("OP_RELACIONAL -> >=");}
    ;
simples: termo operador termo                    {printf("SIMPLES -> TERMO OPERADOR TERMO");}
    | termo                                      {printf("SIMPLES -> TERMO");}
    ;
operador: PLUS                                   {printf("OPERADOR -> +");}
    | MINUS                                      {printf("OPERADOR -> -");}
    | OR                                         {printf("OPERADOR -> ou");}
    ;
termo: fator                                     {printf("TERMO -> FATOR");}
    | fator op fator                             {printf("TERMO -> FATOR OPERADOR FATOR");}
    ;
op: MULT                                         {printf("OP -> *");}
    | DIV                                        {printf("OP -> div");}
    | AND                                        {printf("OP -> e");}
    ;
fator: identificador                             {printf("FATOR -> IDENTIFICADOR");}
    | numero                                     {printf("FATOR -> NUMERO");}
    | OPNPAR expressao CLSEPAR                   {printf("FATOR -> (EXPRESSAO)");}
    | TRUE                                       {printf("FATOR -> verdadeiro");}
    | FALSE                                      {printf("FATOR -> falso");}
    | NOT fator                                  {printf("FATOR -> not FATOR");}
    ;
identificador: ID                                {printf("IDENTIFICADOR -> id");}
    ;
numero: NUM                                      {printf("NUMERO -> num");}

%%