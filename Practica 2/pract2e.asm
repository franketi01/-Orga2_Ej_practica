%define NULL 0
%define ofs_nodo_valor 0
%define ofs_nodo_prox 8
%define ofs_hash_array 0

%define hash_size 160
%define nodo_size 16

extern malloc
extern free

global crear_hash, esta, borrar_todo, agregar, borrar

section .text

crear_hash:
	push rbp
	mov rbp, rsp
	
	mov rdi, hash_size
	call malloc
	mov rcx, 20
	mov r10, rax
.ciclo:
	mov qword[r10], NULL
	add r10, 8
	loop .ciclo
	pop rbp
	ret
	
esta:				;RDI = hash, RSI = long
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14

	mov rbx, rdi
	mov r12, rsi
	mov rdi, rsi
	call pos_array
	mov r14, rax
	xor rax, rax
	mov r13,[rbx + 8*r14]
.ciclo:
	cmp r13, NULL
	je .fin
	cmp qword[r13 + ofs_nodo_valor], r12
	je .encontre
	mov r13, [r13 + ofs_nodo_prox]
	jmp .ciclo
.encontre:
	or rax, 1
.fin:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

agregar:			;RDI = hash, RSI = ln
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14

	mov rbx, rdi
	mov r12, rsi
	mov rdi, rsi
	call pos_array
	mov r13, rax
	lea r14, [rbx + 8*rax]
.ciclo:		
	cmp qword[r14], NULL
	je .add_nodo
	mov r14, [r14]
	cmp qword[r14 + ofs_nodo_valor], r12
	je .fin
	lea r14, [r14 + ofs_nodo_prox]
	jmp .ciclo
.add_nodo:
	mov rdi, nodo_size
	call malloc
	mov qword[rax + ofs_nodo_prox], NULL	
	mov qword[rax + ofs_nodo_valor], r12
	mov [r14], rax
.fin:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

borrar:					;RDI = hash, RSI = long
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	mov rbx, rdi
	mov r12, rsi
	mov rdi, rsi
	call pos_array
	lea r13, [rbx + 8*rax]
.ciclo:	
	cmp qword[r13], NULL
	je .fin
	mov r14, [r13]
	cmp [r14 + ofs_nodo_valor], r12
	je .delete_nodo
	lea r13, [r14 + ofs_nodo_prox]
	jmp .ciclo
.delete_nodo:
	mov rdi, r14
	mov r14, [rdi + ofs_nodo_prox]
	mov [r13], r14
	call free
.fin:	
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

borrar_todo:		;RDI = hash
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	mov rbx, rdi
	xor r12, r12
.ciclo:
	cmp r12, 20
	je .fin
	cmp qword[rbx + 8*r12], NULL
	je .siguiente
	mov rdi, [rbx + 8*r12]
	mov qword[rbx + 8*r12], NULL
	call borrar_aux
.siguiente:
	inc r12
	jmp .ciclo
.fin:
	mov rdi, rbx
	call free
	
	pop r12
	pop rbx
	pop rbp
	ret

borrar_aux:					;RDI = nodo
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	mov rbx, rdi
	mov r12, [rbx + ofs_nodo_prox]
	call free
	cmp r12, NULL
	je .fin
	mov rdi, r12
	call borrar_aux
.fin:	
	pop r12
	pop rbx
	pop rbp
	ret

pos_array:					;RDI = long
	push rbp
	mov rbp, rsp
	xor rax, rax
	add rdi, 1000
.ciclo:
	cmp rdi, 100
	jl .fin
	sub rdi, 100
	inc rax
	jmp .ciclo
.fin:
	pop rbp
	ret


