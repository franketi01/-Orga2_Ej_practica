global imprimirPalabra
global imprimirOracion
global imprimirParrafo

extern malloc
extern free
extern printf

%define NULL 0

%define nodo_char 0
%define nodo_prox 8

%define lista_prim 0

%define nodo_lista_dato
%define nodo_lista_prox

%define lista_list_prim 0

section .data
	dato: DB '%s', 0
	
	espacio: DB ' ', 0
	
section .text
	
	;void imprimirPalabra(nodo* node)		RDI = node
	imprimirPalabra:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		
		cmp qword[rdi], NULL
		je .fin
		mov rbx, rdi
		mov rdi, dato
		mov rsi, [rbx + nodo_char]
		call printf
		
	.fin:
		pop r12
		pop	rbx
		pop rbp
		ret
		
	;void imprimirOracion(lista* list);    RDI = list
	imprimirOracion:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		
		lea rbx, [rdi + lista_prim]
	.ciclo:		
		cmp qword[rbx], NULL
		je .fin
		mov r12, [rbx]
		mov rdi, r12
		call imprimirPalabra
		lea rbx, [r12 + nodo_prox]
		cmp qword[rbx], NULL
		je .ciclo
		mov rdi, espacio
		call printf
		jmp .ciclo
	.fin:
		pop r12
		pop rbx
		pop rbp
		ret

	;void imprimirParrafo(lista_de_lista* l)     RDI = l
	imprimirParrafo:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		lea rbx, [rdi + lista_list_prim]
		cmp qword[rbx], NULL
		je .fin
		mov r12, [rbx]
		mov rdi, r12
		call imprimirOracion
	.fin:
		pop r12
		pop rbx
		pop rbp
		ret
	
	
	
	
	
	
