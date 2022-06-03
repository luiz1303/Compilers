/* Trabalho de Compiladores - Análise Sintática
Aluno: Luiz Ricardo Brumati De Lima
UTFPR-PB - RA: a2155184 */
#include <stdio.h>
#include "lex.yy.c" //Criado durante a execução do analisador léxico!

extern int yyparse (void);

void yyerror(const char *msg) { //Exibe uma mensagem quando um erro sintático é encontrado!
    printf("\n\033[0;31mERRO SINTATICO: %s\033[0;37m\n", msg);
}

int main (int argc, char *argv[]) {
    
    yyin = fopen (argv[1],"r");
    int result_code = yyparse();
    fclose(yyin);
    return result_code;
}