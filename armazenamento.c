#include "armazenamento.h"

ARMAZENAMENTO *criarArmazenamento(void) {
    ARMAZENAMENTO *armaz = malloc(sizeof(ARMAZENAMENTO));
    armaz->head = NULL; //Inicializa a lista vazia
    return armaz;
}

int lista_vazia (ARMAZENAMENTO *lista) {
    if (lista == NULL || lista->head == NULL) {
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
            printf("%s = %d\n", aux->id, aux->val);
            aux = aux->next;
        }
    }
}

ITEM *criarItem(char* lexic_val, int val) {
    ITEM* item = malloc(sizeof(ITEM));
    item->next = NULL;
    item->id = lexic_val;
    item->val = val;
    return item;
}

int atrib_identificador (ARMAZENAMENTO *lista, char *lexic_val, int val) {
    
    ITEM * aux; //Auxiliar para percorrer a lista

    //Caso a lista esteja vazia, cria um novo item na cabeça
    if (lista_vazia(lista)) {
        lista->head = criarItem (lexic_val, val);
        return 1;
    }
    else {
        aux = lista->head;

        while (aux->next != NULL) {
            if (strcmp (aux->id, lexic_val) == 0) { //Procura pelo id de uma variável criada previamente
                aux->val = val; //Atribui um novo valor para a variável já existente
                return 1;
            }
            aux = aux->next;
        }

        //Verifica se o último item da lista possui um id existente
        if (strcmp (aux->id, lexic_val) == 0) {
            aux->val = val;
            return 1;
        }

        //Caso não encontre um id existente, cria um novo item na lista
        aux->next = criarItem(lexic_val, val);
        return 1;
    }

    return 0; //Na teoria, o código nunca retornará zero!
}

int acessar_identificador (ARMAZENAMENTO *lista, char *lexic_val) {
    
    ITEM *aux;

    if (!lista_vazia(lista)) {
        aux = lista->head;

        //Percorre a lista exibindo o nome do identificador e seu valor léxico
        while (aux != NULL) {
            if (strcmp(aux->id, lexic_val) == 0) //Busca pelo identificador com o mesmo nome (lexic_val)
                return aux->val;
            aux = aux->next;
        }
    }
    return INT_MIN; //Caso não encontre o elemento, retorna o valor mínimo que um int pode receber
}

void limpar_armazenamento (ARMAZENAMENTO *lista) {
    ITEM *aux;
    if(lista != NULL){
        while(!lista_vazia(lista)){
            aux = lista->head;
            lista->head = lista->head->next;
            free(aux);
        }
        free(lista);
    }
}