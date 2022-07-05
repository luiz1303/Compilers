/* Trabalho de Compiladores - Análise Sintática
Aluno: Luiz Ricardo Brumati De Lima
UTFPR-PB - RA: a2155184 */

%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "parser.tab.h"
    
    int line = 1; //Contador de linhas
    int error = 0; //Contador de erros
    extern YYSTYPE yylval;

    //Exibe uma mensagem quando um erro léxico é encontrado!
    void error_message() { 
        printf("\n\033[0;31mERRO LEXICO ---> Linha %d\033[0;37m\n", line);
        error++;
    }

    //10=Valor de \n em ASCII
    void multilineComment (int lenght, char *comentario) {
        
        int i;

        for (i=0; i<lenght ;i++) {
            if (comentario[i] == 10) 
                line++;
        }
    }
%}

inteiro   "-"?[1-9][0-9]*
real      "-"?[0-9]*[.][0-9]*
id        [a-zA-Z_][a-zA-Z0-9_]*

%%
\n                        {line++;}
\t                        { } /*Ignora identações*/
[[:space:]]               { } /*Ignora espaços*/
programa                  {return PROG;}
inicio                    {return START;}
fim                       {return END;}
leia                      {return READ;}
escreva                   {return PRINT;}
funcao                    {return FUNC;}
var                       {return VAR;}
inteiro                   {return INT_TYPE;}
real                      {return REAL_TYPE;}
booleano                  {return BOOL_TYPE;}
verdadeiro                {return TRUE;}
falso                     {return FALSE;}
not                       {return NOT;}
e                         {return AND;}
ou                        {return OR;}
se                        {return IF;}
senao                     {return ELSE;}
entao                     {return THEN;}
enquanto                  {return WHILE;}
faca                      {return DO;}
[(]                       {return OPNPAR;}
[)]                       {return CLSEPAR;}
[+]                       {yylval.lexic_val = strdup(yytext); return PLUS;}
[-]                       {yylval.lexic_val = strdup(yytext); return MINUS;}
[*]                       {yylval.lexic_val = strdup(yytext); return MULT;}
div                       {yylval.lexic_val = strdup(yytext); return DIV;}
[:]                       {return COLON;}
[;]                       {return SCOLON;}
[,]                       {return COMMA;}
[=]                       {return EQUAL;}
[<]                       {return SMALLER;}
[>]                       {return BIGGER;}
":="                      {return ASSIGN;}
"<>"                      {return DIF;}
"<="                      {return SMALLEQ;}
">="                      {return BIGGEQ;}
{inteiro}                 {yylval.val = atoi(yytext); return NUM;}
{real}                    {return NUM;}
{id}                      {yylval.lexic_val = strdup(yytext); return ID;}
[{][^}]*[}]               {multilineComment(yyleng, yytext);} // Qualquer conteúdo entre { e } que seja diferente de '}' será ignorado!
{id}[^([:space:]\n\t)]+   {error_message();} //Gera um erro para identificadores não seguidos de espaço, \n ou \t
([0-9]+{id}*)+            {error_message();} //Gera um erro para tokens como: 123teste
.                         {error_message();} //Gera um erro para qualquer outro token não identificado
%%

/*

REFERÊNCIAS:


SOBRE YYVAL = ATOI;
https://www.ibm.com/docs/pt-br/zos/2.4.0?topic=lex-translations



YYSTYPE:
https://stackoverflow.com/questions/1851829/how-to-use-yylval-with-strings-in-yacc#:~:text=The%20YYSTYPE%20is%20a%20union,within%20the%20yacc%20source%20file.

https://www.gnu.org/software/bison/manual/html_node/Value-Type.html

*/