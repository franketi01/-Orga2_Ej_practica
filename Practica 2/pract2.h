#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

struct A {
	int n;
	int m;
	struct A *s;
} __attribute__((packed));

struct B {
	unsigned int n;
	unsigned short v[3];
	struct B *s;
} __attribute__((packed));

struct C {
	unsigned char c;
	struct C *v[10];
} __attribute__((packed));

typedef struct nodo_t {
	long    dato;                   /* dato del nodo (un entero) */
	struct  nodo_t *prox;           /* puntero al siguiente */
} nodo;

typedef struct lista_t {
	nodo*   primero;                /* puntero al primer nodo */
} lista;
