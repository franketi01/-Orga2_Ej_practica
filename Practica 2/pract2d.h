typedef struct _nodo_t{
	long elem;
	struct _nodo_t *siguiente;
} nodo;

typedef struct _conj_t {
	nodo* primero;
} conj;
