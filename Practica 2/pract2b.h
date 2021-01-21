typedef struct _nodo_t {
char                    *str;
struct _nodo_t           *prox;
} nodo;

typedef struct lista_t {
nodo    *primero;
} lista;


typedef struct _nodo_lista_de_lista_t {
lista                           *dato;
struct _nodo_lista_de_lista_t   *prox;
} nodo_lista_de_lista;

typedef struct _lista_de_lista_t {
nodo_lista_de_lista     *primero;
} lista_de_lista;
