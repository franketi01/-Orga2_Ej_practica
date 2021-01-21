/*
 * hash.c
 * 
 * Copyright 2017 Franco Armando Martinez Quispe <fquispe@ws20.labo5>
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
#include "pract2e.h"

extern hash *crear_hash();

extern void agregar(hash* h, long v);

extern long esta(hash* h, long v);

extern borrar(hash* h, long v);

extern void borrar_todo(hash* h);

void ej18a();
void ej18b();
void ej18c();
void check_hash();
void print_hash(hash* h);

int main()
{
//	ej18a();
//	ej18b();
//	ej18c();

	check_hash();
	return 0;
}

void ej18a()
{
	hash* h = crear_hash();
	printf("%ld\n", sizeof(hash));
	long i = esta(h,5);
//	printf("esta: %ld\n", i);
	
	borrar_todo(h);
	
	
}

void ej18b()
{
	hash* h = crear_hash();
	agregar(h,5);
	agregar(h, 450);
	long i = esta(h,5);
	printf("esta: %ld\n", i);
	
	borrar_todo(h);
	
	
}

void ej18c()
{
	hash* h = crear_hash();
	borrar(h,5);
	agregar(h,5);
	agregar(h,880);

	borrar(h,5);
	
	borrar_todo(h);
	
	
}

void check_hash()
{
	hash* h = crear_hash();
	int i,j;
	for(i = 0; i < 20; ++i)
	{
		for (j = 0; j < 10; ++j)
		{
			long v = -999 + 100*i + j*6;
			agregar(h, v);
		}
	}
	printf("ws\n");
	print_hash(h);

	borrar_todo(h);
}

void print_hash(hash* h)
{	
	int i;
	for (int i = 0; i < 20; ++i)
	{
		nodo* aux = h->arreglo[i];
		while(aux != NULL)
		{
			printf("%ld ", (*aux).valor);
			aux = aux->prox;
		}
		printf("[]\n");
	}
}
