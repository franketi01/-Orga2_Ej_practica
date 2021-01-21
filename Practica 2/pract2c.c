#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "pract2c.h"

extern dicc_arb_bin* crear_dicc();

extern char * significado(dicc_arb_bin* d, char *clave);

extern void agregarPalabra(dicc_arb_bin * d, char * clave, char * significado);


void imprimirAux(nodo* n)
{
	if(n->izq != NULL)
	{
		imprimirAux(n->izq);
	}
	printf("(%s,%s) ", n->clave,n->significado);
	if(n->der != NULL)
	{
		imprimirAux(n->der);
	}
}
void imprimirDicc(dicc_arb_bin* d)
{
	printf("[ ");
	if(d != NULL && d->raiz != NULL)
	{
		imprimirAux(d->raiz);
	}
	printf("]\n");
}

void borrar_aux(nodo* n)
{
	if(n->izq != NULL)
	{
		borrar_aux(n->izq);
	}
	if(n->der != NULL)
	{
		borrar_aux(n->der);
	}
	free(n);
}

void borrar_dicc(dicc_arb_bin* d)
{
	if(d->raiz != NULL)
	{
		borrar_aux(d->raiz);
	}

	free(d);
}

void ejercicio16a()
{
	dicc_arb_bin* dicc = (dicc_arb_bin*) crear_dicc();
	
	char palabra1[] = {'h','o', 'l', 'a', 0};
	char signif1[] = {'k', 'a', '1',0};
	char p2[] = {'z','s','a',0};
	char s2[] = {'d','s','s','a',0};
	char p3[] = {'p','i','s',0};
	char s3[] = {'a','2','s','a',0};
	agregarPalabra(dicc, palabra1, signif1);
	agregarPalabra(dicc,p2,s2);
	agregarPalabra(dicc,p3,s3);
	printf("%s\n", significado(dicc,"hola")); 

	borrar_dicc(dicc);
}

void ejercicio16b()
{
	dicc_arb_bin* dicc = (dicc_arb_bin*) crear_dicc();
	
	char palabra1[] = {'h','o', 'l', 'a', 0};
	char signif1[] = {'k', 'a', '1',0};
	char p2[] = {'z','s','a',0};
	char s2[] = {'d','s','s','a',0};
	char p3[] = {'p','i','s',0};
	char s3[] = {'a','2','s','a',0};
	agregarPalabra(dicc, palabra1, signif1);
	agregarPalabra(dicc,p2,s2);
	agregarPalabra(dicc,p3,s3);
	imprimirDicc(dicc); 

	borrar_dicc(dicc);
}

void ejercicio16c()
{
	dicc_arb_bin* dicc = (dicc_arb_bin*) crear_dicc();
	
	 

	borrar_dicc(dicc);
}

int main()
{
	ejercicio16a();
//	ejercicio16b();
	return 0;
}

