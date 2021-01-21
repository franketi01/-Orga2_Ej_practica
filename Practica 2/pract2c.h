typedef struct _nodo_t {
	char* clave;
	char* significado;
	struct nodo_t  *izq;
	struct nodo_t  *der;
} nodo;

typedef struct _dicc_arb_bin_t {
nodo *raiz;
} dicc_arb_bin;
