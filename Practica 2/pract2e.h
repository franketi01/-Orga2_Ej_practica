
typedef struct _nodo_t{
		long valor;
		struct _nodo_t* prox;
} nodo;

typedef struct hash_t{
	nodo* arreglo[20];
} hash;
