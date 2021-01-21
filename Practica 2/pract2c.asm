%define offset_clave 0
%define offset_sig 8
%define offset_izq 16
%define offset_der 24

%define offset_raiz 0

%define NULL 0
%define size_nodo 32

extern malloc
extern free

global crear_dicc, significado, agregarPalabra

section .text	

	crear_dicc:
		push rbp
		mov rbp, rsp

		mov rdi, 8
		call malloc
		mov qword[rax + offset_raiz], NULL

		pop rbp
		ret

	;char* significado(dicc d, char *clave);
	significado:		;RDI = d, RSI = clave 
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		
		xor rax, rax
		lea rbx, [rdi + offset_raiz]
		mov r12, rsi
	.ciclo:
		cmp qword[rbx], NULL
		je .fin
		mov rbx, [rbx]
		mov rdi, r12
		mov rsi, [rbx + offset_clave]
		call esIgual
		cmp rax, 0
		je .encontre 
		mov rdi, r12
		mov rsi, [rbx + offset_clave]
		call esMayor
		cmp rax, 0
		je .menor
		lea rbx, [rbx + offset_der]
		jmp .ciclo
	.menor:
		lea rbx, [rbx + offset_izq]
		jmp .ciclo
	.encontre:
		mov rax,[rbx + offset_sig]
	.fin:	
		pop r12
		pop rbx
		pop rbp
		ret

	
	;void agregarPalabra(dicc *d, char *clave, char *significado)
	agregarPalabra:				;RDI = d, RSI = clave, RDX = significado
		push rbp
		mov rbp, rsp
		push rbx         		
		push r12
		push r13
		push r14
			
		mov rbx, rdi			;RBX = RDI = d
		mov r12, rsi			;R12 = RSI = clave
		mov r13, rdx			;R13 = RDx = significado
		lea r14, [rbx + offset_raiz]  ; R14 = &nodo-raiz
		cmp qword[r14], NULL
		je .agregar
	.ciclo:
		mov r14, [r14]
		mov rdi, r12
		mov rsi, [r14 + offset_clave]
		call esMayor
		cmp rax, 0
		je .esMenor
		mov rdi, r12
		mov rsi, [r14 + offset_clave]
		call esIgual
		cmp rax, 0
		je .esMayor
		mov rdi, [r14 + offset_sig]
		mov qword[r14 + offset_sig], r13
		
		jmp .fin
	.esMayor:
		lea r14, [r14 + offset_der]
		jmp .verif
	.esMenor:
		lea r14, [r14 + offset_izq]
	.verif:
		cmp qword[r14], NULL
		jne .ciclo
	.agregar:
		mov rdi, 32
		call malloc
		mov [rax + offset_clave], r12
		mov [rax + offset_sig], r13
		mov qword[rax + offset_izq], NULL
		mov qword[rax + offset_der], NULL
		mov qword[r14], rax
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	esMayor:		;RDI = clave1, RSI = clave2
		push rbp
		mov rbp, rsp
		xor rax, rax
		cmp rsi, rdi
		jg  .fin
		mov rax, 1
	.fin:
		pop rbp
		ret
		
	esIgual:		;RDI = clave1, RSI = clave2
		push rbp
		mov rbp, rsp
		xor rax, rax
		cmp rdi, rsi
		jnz .fin
		mov rax, 1
	.fin: 
		pop rbp
		ret

	copiar_string:		;RDI = clave
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		mov rbx, rdi
		xor rdi, rdi
		xor r12, r12
	.ciclo:
		cmp byte[rbx + rdi], 0
		je .cont_str
		inc rdi
		jmp .ciclo
	.cont_str:	
		cmp rdi, 0
		je .fin
		inc rdi
		call malloc
		xor r8, r8
	.ciclo_2:
		cmp byte[rbx], 0
		je .fin
		mov r12b, [rbx]
		mov byte[rax + r8], r12b
		inc rbx
		inc r8
		jmp .ciclo_2 	
	.fin:
		pop r12
		pop rbx
		pop rbp
		ret