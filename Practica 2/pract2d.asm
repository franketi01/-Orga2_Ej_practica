%define NULL 0

%define conj_size 8
%define offset_prim 0 

%define nodo_size 16
%define offset_long 0
%define offset_sig 8
 
extern malloc
extern free

global crear_conj, esta, agregarElemento, borrar_todo, borrarElemento
global interseccion, union_c, promedio

section .text
	
	crear_conj:
		push rbp
		mov rbp, rsp
		
		mov rdi, conj_size
		call malloc
		mov qword[rax + offset_prim], NULL
		
		pop rbp
		ret
	
	esta:				;RDI = conj, RSI = elem
		push rbp
		mov rbp, rsp
		
		xor rax, rax
		lea r8, [rdi + offset_prim]
	.ciclo:	
		cmp qword[r8], NULL
		je .fin
		mov r8, [r8]
		cmp rsi, [r8 + offset_long]
		je .encontre
		lea r8, [r8 + offset_sig]
		jmp .ciclo
	.encontre:
		or rax, 1
	.fin:
		pop rbp
		ret
	
	agregarElemento:	;RDI = cj, RSI = dato
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14

		mov rbx, rdi
		mov r12, rsi
		call esta
		cmp rax, 1
		je .fin
		mov rdi, nodo_size
		call malloc
		mov qword[rax + offset_long], r12
		mov qword[rax + offset_sig], NULL
		lea r13, [rbx + offset_prim]
		xor r14, r14	
	.ciclo:
		cmp qword[r13], NULL	
		je .primero_ultimo
		mov r13, [r13]
		cmp r12, [r13 + offset_long] 
		jl .menor_igual
		mov r14, r13
		lea r13, [r13 + offset_sig]
		jmp .ciclo
	.menor_igual:
		mov qword[r14 + offset_sig], rax
		mov qword[rax + offset_sig], r13
		jmp .fin
	.primero_ultimo:
		mov qword[r13], rax
	.fin:	
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	borrar_todo:		;RDI = conj
		push rbp
		mov rbp, rbp
		push rbx
		push r12
		
		mov rbx, rdi
		mov r12, [rbx + offset_prim]
	.ciclo:
		cmp r12, NULL
		je .fin
		mov rdi, r12
		mov r12, [r12 + offset_sig]
		call free
		jmp .ciclo
	.fin:
		mov rdi, rbx
		call free
		pop r12
		pop rbx
		pop rbp
		ret

	borrarElemento:		;RDI = cj, RSI = dato
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14
		
		mov rbx, rdi
		mov r12, rsi
		call esta
		cmp rax, 0
		je .fin
		xor r14, r14
		mov r13, [rbx + offset_prim]
	.ciclo:
		cmp qword[r13 + offset_long], r12
		je .encontre
		mov r14, r13
		mov r13, [r13 + offset_sig]
		jmp .ciclo
	.encontre:
		mov r8, [r13 + offset_sig]
		cmp r14, NULL
		je .nuevo_prim
		mov qword[r14 + offset_sig], r8
		jmp .delete
	.nuevo_prim:
		mov qword[rbx + offset_prim], r8
	.delete:
		mov rdi, r13
		call free
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	interseccion:		;RDI = c, RSI = c1
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14
		
		mov rbx, rdi
		mov r12, rsi
		mov r13, [rbx + offset_prim]
	.ciclo:
		cmp r13, NULL	
		je .fin
		mov rdi, r12
		mov rsi, [r13 + offset_long]
		call esta
		cmp rax, 0
		je .quito_elem
		mov r13, [r13 + offset_sig]
		jmp .ciclo
	.quito_elem:
		mov r14, [r13 + offset_sig]
		mov rdi, rbx
		mov rsi, [r13 + offset_long]
		call borrarElemento
		mov r13, r14
		jmp .ciclo
	.fin:	
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	union_c:					;RDI = c, RSI = c1
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14

		mov rbx, rdi
		mov r12, rsi
		mov r13, [rsi + offset_prim]
	.ciclo:
		cmp r13, NULL
		je .fin
		mov rdi, rbx
		mov rsi, [r13 + offset_long]
		mov r14, rsi
		mov r13, [r13 + offset_sig]
		call esta
		cmp rax, 0
		je .agrego
		jmp .ciclo
	.agrego:
		mov rdi, rbx
		mov rsi, r14
		call agregarElemento
		jmp .ciclo
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	promedio:			;RDI = c
		push rbp
		mov rbp, rsp
		push rbx
		push r12

		xor rax, rax
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		pxor xmm2, xmm2
		mov rbx, rdi 

		pop r12
		pop rbx
		pop rbp
		ret		