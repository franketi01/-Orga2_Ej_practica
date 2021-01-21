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

extern void SumarVectores(char *vectorA, char *vectorB, char *vectorResultado, int dimension);

extern double promedio4(int* a, int n);

extern int sumar();

extern void mult4(int* v, int n);

extern void test(int* v);

extern int* memreserv(int n, int* a);

void ejercicio1()
{
	char vA[] = {'a','1','1','h','k','5','f','z'};
	char vB[] = {'d','j','j','b','o','h','n','m'};
	
	printf("vA: ");
	for(int i = 0; i < 8; i++)
	{
		printf("%c ", vA[i]);
	}
	printf("\n");

	printf("vB: ");
	for(int i = 0; i < 8; i++)
	{
		printf("%c ", vB[i]);
	}
	printf("\n");
	
	char vC[8];
	SumarVectores(vA,vB,vC,8);
	
	for(int i = 0; i < 8; i++)
	{
		printf("%c ", vC[i]);
	}
	printf("\n");
	
}

void funcionA()
{
	int n = 4;
	int vec[] = {1,5,3,6};
	double prom = promedio4(vec,n);
	printf("%f \n", prom);
}

void stack1()
{
	int rs = sumar();
	printf("%i \n", rs);
}

void funcionB()
{
	int n = 8;
	int vector[] = {5,2,4,6,16,20,32,11};
	int i;
	for(i = 0; i < n; i++)
	{
		printf("%i ", vector[i]);
	}
	printf("\n");
	
	mult4(vector,n);
	
	for(i = 0; i < n; i++)
	{
		printf("%i ", vector[i]);
	}
	printf("\n");
}

void testeo()
{
	int vec[] = {4,2,3,5};
	test(vec);
	int i;
	for(i = 0; i < 4; i++)
	{
		printf("%i ", vec[i]);
	}
	printf("\n");
}

void stack2()
{
	int n = 4;
	int a[] = {4,5,3,8};
	int* vec = memreserv(n, a);
	int i;
	for(i = 0; i < n; i++)
	{
		printf("%d ", vec[i]);
	}
	printf("\n");
}

int main()
{
//	ejercicio1();
//	funcionA();
//	stack1();
//	funcionB();
//	testeo();
	stack2();
	return 0;
}

