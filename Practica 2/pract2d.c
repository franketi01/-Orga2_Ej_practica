/*
 * pract2d.c
 * 
 * Copyright 2017 franco <franco@fM1>
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
#include "pract2d.h"

extern conj * crear_conj();
extern int esta(conj * c, long d);
extern void borrar_todo(conj * c);
extern void agregarElemento(conj* c, long d);
extern void borrarElemento(conj* c, long elem);
extern void interseccion(conj* c, conj* c1);
extern void union_c(conj* c, conj* c1);
extern long promedio(conj c);

void print_conj(conj* cj);
void ejercicio17a();
void ejercicio17b();
void ejercicio17c();
void ejercicio17d();
void ejercicio17e();

int main()
{
//	ejercicio17a();
//	ejercicio17b();
//	ejercicio17c();
//	ejercicio17d();
	ejercicio17e();
	
	return 0;
}

void print_conj(conj* cj)
{
	nodo* aux = cj->primero;
	printf("{ ");
	while(aux != NULL)
	{
		printf("%ld ", (*aux).elem);
		aux = aux->siguiente;
	}
	printf("}\n");
}

void ejercicio17a()
{
	conj* cj = (conj*) crear_conj();
	
	printf("1 esta: %i\n", esta(cj,1));
	
	borrar_todo(cj);
}

void ejercicio17b()
{
	conj* cj = (conj*) crear_conj();
	int i;
	for (i = 0; i < 5; i++)
	{
		long a = (long)(i*i);
		agregarElemento(cj,a);
	}
	print_conj(cj);
	agregarElemento(cj,4);
	print_conj(cj);
	
	agregarElemento(cj,15);
	print_conj(cj);
	
	borrar_todo(cj);
}

void ejercicio17c()
{
	conj* cj = (conj*) crear_conj();
	
	int i;
	for(i = 0; i < 7; i++)
	{
		agregarElemento(cj,i+1);		
	}
	printf("conjunto: ");
	print_conj(cj);
	
	//for(i = 0; i < 7; i++)
	//{
		borrarElemento(cj,5);
	//}
	
	printf("borrado: ");
	print_conj(cj);
	
	borrar_todo(cj);
}

void ejercicio17d()
{
	conj* cj = (conj*) crear_conj();
	conj* c1 = (conj*) crear_conj();
	
	int i;
	for (i = 0; i < 10; i++)
	{
		agregarElemento(cj, i*2);
	//	agregarElemento(c1,i*4);
	}
	printf("conj 1: ");
	print_conj(cj);
	printf("conj 2: ");
	print_conj(c1);
	
	interseccion(cj,c1);
	printf("interseccion: ");
	print_conj(cj);
	
	borrar_todo(cj);
	borrar_todo(c1);
}

void ejercicio17e()
{
	conj* cj = (conj*) crear_conj();
	conj* c1 = (conj*) crear_conj();
	
	for (int i = 0; i < 5; ++i)
	{
		agregarElemento(cj, i*6);
		agregarElemento(c1,i*3);
	}
	printf("conj 1: ");
	print_conj(cj);
	printf("conj 2: ");
	print_conj(c1);

	union_c(cj,c1);
	printf("union: ");
	print_conj(cj);

	borrar_todo(cj);
	borrar_todo(c1);
}
