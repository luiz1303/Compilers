#include "armazenamento.h"

ITEM *criarItem(char* lexic_val, int val) {
    ITEM* item = malloc(sizeof(ITEM));
    item->next = NULL;
    item->id = lexic_val;
    item->val = val;
}

ARMAZENAMENTO *criarArmazenamento(void) {
    ARMAZENAMENTO *armaz = malloc(sizeof(ARMAZENAMENTO));
    armaz->head = NULL; //Inicializa a lista vazia
    return armaz;
}

int lista_vazia (ARMAZENAMENTO *lista) {
    if (lista != NULL && lista->head != NULL) {
        return 1;
    }
    return 0;
}

void mostrarLista(ARMAZENAMENTO *lista) {
    ITEM *aux;

    if (!lista_vazia(lista)) {
        aux = lista->head;

        //Percorre a lista exibindo o nome do identificador e seu valor léxico
        while (aux != NULL) {
            printf("%s = %d\t", aux->id, aux->val);
            aux = aux->next;
        }
    }
}

int atrib_valor (ARMAZENAMENTO *lista, char *lexic_val, int val) {
    
    ITEM * aux; //Auxiliar para percorrer a lista

    //Caso a lista esteja vazia, cria um novo item na cabeça
    if (lista_vazia(lista)) {
        lista->head = criarItem (lexic_val, val);
        return 1;
    }
    else {
        aux = lista->head;

        while (aux->next != NULL) {
            if (!strcmp (aux->id, lexic_val)) { //Procura pelo id de uma variável criada previamente
                aux->val = val; //Atribui um novo valor para a variável já existente
                return 1;
            }
            aux = aux->next;
        }

        //Verifica se o último item da lista é possui um id existente
        if (!strcmp (aux->id, lexic_val)) {
            aux->val = val;
            return 1;
        }

        //Caso não encontre um id existente, cria um novo item na lista
        aux->next = criarItem(lexic_val, val);
        return 1;
    }

    return 0;
}