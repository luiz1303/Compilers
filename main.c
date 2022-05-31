/*Aluno: Luiz Ricardo Brumati De Lima*/
/*UTFPR-PB - RA: a2155184*/
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.h" //Gerado através do analisador léxico, permite que yyin seja visível para este arquivo

int yylex(void);
extern int yyparser (void);

void yyerror(char constant *s) {
    printf("\n\033[0;31mERROR: %s\033[0;37m\n", s); 
}

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
    yylex()
    int result_code = yyparse(); //yyparse retorna 0 se não encontrar nenhuma inconsistência no processo de análise sintática

    if (error) {
        printf("\n\033[0;31m%d ERROS ENCONTRADOS!\033[0;37m\n", error);
    }
    
    fclose(arq);
    return result_code; //Retorna 0 se não houverem erros e 1 se algo estiver errado!
}


/*

REFERÊNCIAS:

AJUDOU PRA K7: https://www.ibm.com/docs/pt-br/zos/2.4.0?topic=yacc-lex-output

https://silcnitc.github.io/lex.html#navyyleng

https://www.skenz.it/compilers/flex_bison
https://www.ibm.com/docs/en/zos/2.4.0?topic=works-yyparse-yylex

*/

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



SOBRE YYVAL = ATOI (YYLEX);
https://www.ibm.com/docs/pt-br/zos/2.4.0?topic=lex-translations
*/