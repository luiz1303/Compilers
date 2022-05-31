/* noyywrap: Lê o arquivo uma única vez */
%option noyywrap
/* %option header-file="lex.yy.h" /// header-file="lex.yy.h" vai gerar o arquivo, já referenciado main*/

%{
    //#include "y.tab.h" //Relaciona flex e bison
    extern int yyval;
    int line = 1; //Contador de linhas
    int error = 0; //Contador de erros

%}

inteiro   "-"?[1-9][0-9]*
real      "-"?[0-9]*[.][0-9]*
id        [a-zA-Z_][a-zA-Z0-9_]*

%%
\n                        {line++;} //Quando ler "/n" vai aumentar o contador de linhas e pular uma linha
\t                        {/*Ignorar*/}
[[:space:]]               {/*Ignorar*/}
programa                  {yylval = atoi(yytext); return PROG;}
inicio                    {yylval = atoi(yytext); return BEGIN;}
fim                       {yylval = atoi(yytext); return END;}
leia                      {yylval = atoi(yytext); return READ;}
escreva                   {yylval = atoi(yytext); return PRINT;}
funcao                    {yylval = atoi(yytext); return FUNC;}
procedimento              {yylval = atoi(yytext); return PROCED;}
var                       {yylval = atoi(yytext); return VAR;}
inteiro                   {yylval = atoi(yytext); return INT;}
real                      {yylval = atoi(yytext); return REAL;}
booleano                  {yylval = atoi(yytext); return BOOL;}
verdadeiro                {yylval = atoi(yytext); return TRUE;}
falso                     {yylval = atoi(yytext); return FALSE;}
not                       {yylval = atoi(yytext); return NOT;}
e                         {yylval = atoi(yytext); return AND;}
ou                        {yylval = atoi(yytext); return OR;}
se                        {yylval = atoi(yytext); return IF;}
senao                     {yylval = atoi(yytext); return ELSE;}
entao                     {yylval = atoi(yytext); return THEN;}
enquanto                  {yylval = atoi(yytext); return WHILE;}
faca                      {yylval = atoi(yytext); return DO;}
[(]                       {yylval = atoi(yytext); return OPNPAR;}
[)]                       {yylval = atoi(yytext); return CLSEPAR;}
[+]                       {yylval = atoi(yytext); return PLUS;}
[-]                       {yylval = atoi(yytext); return MINUS;}
[*]                       {yylval = atoi(yytext); return MULT;}
div                       {yylval = atoi(yytext); return DIV;}
[:]                       {yylval = atoi(yytext); return COLON;}
[;]                       {yylval = atoi(yytext); return SCOLON;}
[,]                       {yylval = atoi(yytext); return COMMA;}
[=]                       {yylval = atoi(yytext); return EQUAL;}
[<]                       {yylval = atoi(yytext); return SMALLER;}
[>]                       {yylval = atoi(yytext); return BIGGER;}
":="                      {yylval = atoi(yytext); return ASSIGN;}
"<>"                      {yylval = atoi(yytext); return DIF;}
"<="                      {yylval = atoi(yytext); return SMALLEQ;}
">="                      {yylval = atoi(yytext); return BIGGEQ;}
{inteiro}                 {yylval = atoi(yytext); return NUMINT;}
{real}                    {yylval = atoi(yytext); return NUMREAL;}
{id}                      {yylval = atoi(yytext); return ID;}
[{][^}]*[}]               { 
                            int i; char *comentario = yytext; 
                            for (i=0; i<yyleng ;i++) { //yyleng retorna o tamanho do lexema lido (yytext)
                                if (comentario[i] == 10) 
                                    line++; //Para não perder a contagem de linhas (que depende de \n) é necessário um contador quando são feitos comentários
                            }
} // Qualquer conteúdo entre { e } que seja diferente de '}' será ignorado! --> Reconhece Comentários multi Linha
{id}[^([:space:]\n\t)]+   {error++; yylval = atoi(yytext); return ERROR;} //Gera um erro para identificadores não seguidos de espaço, \n ou \t
([0-9]+{id}*)+            {error++; yylval = atoi(yytext); return ERROR;} //Gera um erro para tokens como: 123teste
.                         {error++; yylval = atoi(yytext); return ERROR;} //Qualquer token não identificado gerará um erro!

%%

int main (void) {

    yylex();
    return 0;
}