/*
 * pract3.c
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
#include "pract2.h"

extern long maximo(long* v, unsigned short n);

extern long sumaTodos(long* v, unsigned short n);

extern void productoEscalar(long* v, int k, unsigned short n, long* w);

extern void suma(long *v1, long *v2, unsigned short n);

extern unsigned long productoInterno(unsigned int *v1, unsigned int *v2, unsigned short n);

extern long iesimo(lista* l, unsigned long i);

extern int buscar(lista* l, long n);

extern void agregarAd(lista* l, long n);

extern void agregarAt(lista* l, long n);

extern void eliminarLista(lista* l);

extern void eliminarApariciones(lista* l, long n);

extern void eliminarRepetidos(lista* l);

extern void agregarOrdenado(lista* l, lista* l1);

void ejercicio2()
{
	short n = 5;
	long vector[] = {15,5,3,54,8};
	long max = maximo(vector, n);
	printf("mi maximo: %ld\n", max); 
}

void ejercicio3()
{
	short n = 7;
	long vector[] = {1,23,2,5,4,14,8};
	long suma = sumaTodos(vector,n);
	printf("suma vector: %ld\n", suma);
}
void ejercicio4()
{
	short n = 5;
	long vector[] = {1,2,3,2,1};
	int k = 4;
	long salida[n];
	productoEscalar(vector,k,n,salida);
	for(int i = 0; i < n; i++)
	{
		printf("%ld ", salida[i]);
	}
	printf("\n");
}

void ejercicio5()
{
	short n = 6;
	long vector[] = {1,5,3,10,7,9};
	long vector2[] = {4,65,32,11,4,8};
	printf("v: ");
	for(int i = 0; i < n; i++)
	{
		printf("%ld ", vector[i]);
	}
	printf("\n");
	printf("w: ");
	for(int i = 0; i < n; i++)
	{
		printf("%ld ", vector2[i]);
	}
	printf("\n");
	suma(vector, vector2, n);

	printf("salida: ");
	for(int i = 0; i < n; i++)
	{
		printf("%ld ", vector[i]);
	}
	printf("\n");
}

void ejercicio6()
{
	short n = 4;
	unsigned int vector[] = {1,3,3,1};
	unsigned int vector2[] = {3,1,1,3};
	printf("v: ");
	for(int i = 0; i < n; i++)
	{
		printf("%d ", vector[i]);
	}
	printf("\n");
	printf("w: ");
	for(int i = 0; i < n; i++)
	{
		printf("%d ", vector2[i]);
	}
	printf("\n");
	
	unsigned long res = productoInterno(vector,vector2,n);
	printf("producto interno: %ld\n", res);
}

void ejercicio14()
{
	lista* list = (lista*) malloc(sizeof(lista));
	list->primero = NULL;
	agregarAt(list, 1);
	agregarAt(list, 4);
	agregarAt(list, 5);
	agregarAt(list, 3);
	agregarAt(list, 8);
	nodo* aux = list->primero;
	while(aux != NULL)
	{
		printf("%ld ", aux->dato);
		aux = aux->prox;
	}
	printf("\n");
	int i = 1;
	printf("%i-esimo: %ld\n", i, iesimo(list, i));
	
	long b = 5;
	printf("el elemento %ld se encuentra en la pos %i\n", b, buscar(list, b));
	
	eliminarLista(list);
}

void ejercicio14G()
{
	lista* list = (lista*) malloc(sizeof(lista));
	list->primero = NULL;
	agregarAt(list, 1);
	agregarAt(list, 2);
	agregarAt(list, 1);
	agregarAt(list, 3);
	agregarAt(list, 1);
	
	nodo* aux2 = list->primero;
	printf("antes: ");
	while(aux2 != NULL)
	{
		printf("%ld ", aux2->dato);
		aux2 = aux2->prox;
	}
	printf("\n");
	eliminarApariciones(list, 1);
	
	nodo* aux = list->primero;
	printf("despues: ");
	while(aux != NULL)
	{
		printf("%ld ", aux->dato);
		aux = aux->prox;
	}
	printf("\n");
	eliminarLista(list);
}

void ejercicio14H()
{
	
	lista* list = (lista*) malloc(sizeof(lista));
	list->primero = NULL;
	agregarAt(list, 1);
	agregarAt(list, 2);
	agregarAt(list, 1);
	agregarAt(list, 3);
	agregarAt(list, 2);
	agregarAt(list, 4);
	agregarAt(list, 5);
	agregarAt(list, 1);
	agregarAt(list, 3);
	
	nodo* aux2 = list->primero;
	printf("antes: ");
	while(aux2 != NULL)
	{
		printf("%ld ", aux2->dato);
		aux2 = aux2->prox;
	}
	printf("\n");
	
	eliminarRepetidos(list);
	
	nodo* aux = list->primero;
	printf("despues: ");
	while(aux != NULL)
	{
		printf("%ld ", aux->dato);
		aux = aux->prox;
	}
	printf("\n");
	eliminarLista(list);
}



int main()
{
//	ejercicio2();
//	ejercicio3();
//	ejercicio4();
//	ejercicio5();
//	ejercicio6();
//	ejercicio14();
//	ejercicio14G();
	ejercicio14H();
	return 0;
}

