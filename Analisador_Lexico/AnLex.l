/*Aluno: Luiz Ricardo Brumati De Lima RA: a2155184*/
/*UTFPR-PB - RA: a2155184*/

/* noyywrap: Lê o arquivo uma única vez */
%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h" //Relaciona flex e bison

    extern int yyval;
    int line = 1; //Contador de linhas
    int error = 0; //Contador de erros

%}

id [a-zA-Z_][a-zA-Z0-9_]*

%%
\n                        {printf ("\n"); line++;} //Quando ler "/n" vai aumentar o contador de linhas e pular uma linha
\t                        {printf ("\t"); line;}
programa                  {printf ("<PROG, %d>", line);}
inicio                    {printf ("<BEGIN, %d>", line);}
fim                       {printf ("<END, %d>", line);}

leia                      {printf ("<READ, %d>", line);}
escreva                   {printf ("<PRINT, %d>", line);}
funcao                    {printf ("<FUNC, %d>", line);}
procedimento              {printf ("<PROCED, %d>", line);}

var                       {printf ("<VAR, %d>", line);}
inteiro                   {printf ("<INT, %d>", line);}
real                      {printf ("<REAL, %d>", line);}
booleano                  {printf ("<BOOL, %d>", line);}

verdadeiro                {printf ("<TRUE, %d>", line);}
falso                     {printf ("<FALSE, %d>", line);}
not                       {printf ("<NOT, %d>", line);}
e                         {printf ("<AND, %d>", line);}
ou                        {printf ("<OR, %d>", line);}

se                        {printf ("<IF, %d>", line);}
senao                     {printf ("<ELSE, %d>", line);}
entao                     {printf ("<THEN, %d>", line);}
enquanto                  {printf ("<WHILE, %d>", line);}
faca                      {printf ("<DO, %d>", line);}

[(]                       {printf ("<OPNPAR, %d>", line);}
[)]                       {printf ("<CLSEPAR, %d>", line);}
[+]                       {printf ("<PLUS, %d>", line);}
[-]                       {printf ("<MINUS, %d>", line);}
[*]                       {printf ("<MULT, %d>", line);}
div                       {printf ("<DIV, %d>", line);}

[:]                       {printf ("<COLON, %d>", line);}
[;]                       {printf ("<SCOLON, %d>", line);}
[,]                       {printf ("<COMMA, %d>", line);}
[=]                       {printf ("<EQUAL, %d>", line);}
[<]                       {printf ("<SMALLER, %d>", line);}
[>]                       {printf ("<BIGGER, %d>", line);}
":="                      {printf ("<ASSIGN, %d>", line);}
"<>"                      {printf ("<DIF, %d>", line);}
"<="                      {printf ("<SMALLEQ, %d>", line);}
">="                      {printf ("<BIGEQ, %d>", line);}

[[:space:]]               {}
"-"?[1-9][0-9]*           {printf ("<INT, %d>", line);} //Inteiros positivos ou negativos
"-"?[0-9]*[.][0-9]*       {printf ("<NUMREAL, %d>", line);} //Reais positivos ou negativos
{id}                      {printf ("<ID, %d>", line);}
[{][^}]*[}]               { 
                            int i; char *comentario = yytext; 
                            for (i=0; i<strlen(comentario);i++) {
                                if (comentario[i] == 10)
                                    line++; //Para não perder a contagem de linhas (que depende de \n) é necessário um contador quando são feitos comentários
                            }
} // Qualquer conteúdo entre { e } que seja diferente de '}' será ignorado! --> Reconhece Comentários multi Linha
{id}[^([:space:]\n\t)]+   {printf("\033[0;31m<ERRO, %d>\033[0;37m", line); error++;} //Gera um erro para identificadores não seguidos de espaço, \n ou \t
([0-9]+{id}*)+            {printf("\033[0;31m<ERRO, %d>\033[0;37m", line); error++;} //Gera um erro para tokens como: 123teste
.                         {printf("\033[0;31m<ERRO, %d>\033[0;37m", line); error++;} //Qualquer token não identificado gerará um erro!

%%

/* 
INFO INPUT LEX:
yylex() lê a fonte de input e e gera os tokens.

-> argc é a contagem de argumentos passados e argv é um vetor de ponteiros com argc posições

Ao fazer todos os comandos e gerar um executável (por exemplo, "output.exe"), para rodar o programa você vai passar como argumentos no cmd:

>> output test.l [aperta enter]

Logo, são dois argumentos (argc=2), então argv[] vai de 0 até 1, aonde argv[0] é o próprio programa "output.exe" e argv[1]
é o endereço passado (no caso, do programa "test.l")

A função yyin vai dizer para o lex que o input vai ser esse arquivo ao invés da entrada padrão via linha de comando
yylex() inicia a parte léxica com o input definido!
*/

int main (int argc, char *argv[]) {

    if (argc<=1) {
        printf("\n\033[0;31mNenhum arquivo foi informado!\033[0;37m\n");
        return -1;
    }
    
    FILE *arq = fopen (argv[1],"r");

    if (!arq) {
        printf("\n\033[0;31mArquivo Invalido!\033[0;37m\n");
        return -1;
    }

    yyin = arq;
    yylex();

    if (error) {
        printf("\n\033[0;31m%d ERROS ENCONTRADOS!\033[0;37m\n", error);
    }
    
    fclose(arq);
    return 0;
}