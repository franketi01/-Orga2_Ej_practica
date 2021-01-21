/*
 * pract2b.c
 * 
 * Copyright 2016 franco <franco@fM1>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */




#include <stdio.h>
#include <stdlib.h>
#include "pract2b.h"

extern void imprimirPalabra(nodo* node);

extern void imprimirOracion(lista* list);

void eliminarLista(lista* l)
{
	nodo* aux = l->primero;
	while(aux != NULL)
	{
		nodo* a = aux;
		aux = aux->prox;
		free(a);
	}
	
	free(l);
}

void ejercicio15a()
{
	char word[] = {'h', 'o', 'l', 'a', 0};
	nodo* n = (nodo*) malloc(16);
	n->str = word;
	n->prox = NULL;
	
	imprimirPalabra(n);
	
	free(n);
}


void ejercicio15b()
{
	char word1[] = {'h', 'o', 'l', 'a', 0};
	char word2[] = {'m', 'u', 'n', 'd', 'o', 0};
	lista* l = (lista*) malloc(sizeof(lista));
	nodo* n1 = (nodo*) malloc(sizeof(nodo));
	nodo* n2 = (nodo*) malloc(sizeof(nodo));
	l->primero =n1;
	n1->str = word1;
	n2->str = word2;
	n1->prox = n2;
	n2->prox = NULL;
	imprimirOracion(l);
	printf("\n");
	eliminarLista(l);
}

int main()
{
//	ejercicio15a();
//	ejercicio15b();
	

	return 0;
}

