#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

//Estrutura para lista encadeada

typedef struct Item ITEM;
typedef struct Armazen ARMAZENAMENTO;
struct Item {
    int val;
    char *id;
    ITEM *next;
};

struct Armazen {
    ITEM *head;
};


//Funções auxiliares para lista encadeada
ITEM *criarItem(char* lexic_val, int val);
ARMAZENAMENTO *criarArmazenamento(void);
int lista_vazia (ARMAZENAMENTO *lista);
void mostrarLista(ARMAZENAMENTO *lista);
int atrib_identificador (ARMAZENAMENTO *lista, char *lexic_val, int val);
int acessar_identificador (ARMAZENAMENTO *lista, char *lexic_val);
void limpar_armazenamento (ARMAZENAMENTO *lista);
