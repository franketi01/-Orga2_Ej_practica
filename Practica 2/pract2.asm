global maximo
global sumaTodos
global productoEscalar
global suma
global productoInterno
global iesimo
global buscar
global agregarAd
global agregarAt
global eliminarApariciones
global eliminarRepetidos
global eliminarLista
global agregarOrdenado

extern malloc
extern free

%define NULL 0
%define nodo_t_dato 0
%define nodo_t_prox 8
%define lista_prim 0

section .data

section .text
	maximo:
		;RDI = v
		;SI = n 
		
		push rbp
		mov rbp, rsp
		
		xor rcx, rcx
		mov cx, si
		dec cx
		mov r8, [rdi]
		lea rdi, [rdi + 8]
	.ciclo:
		cmp [rdi], r8
		jle .continuo
		mov r8, [rdi]
	.continuo:
		lea rdi, [rdi + 8]
		loop .ciclo
		mov rax, r8
		pop rbp
		ret

	sumaTodos:
		push rbp
		mov rbp, rsp
		
		xor rcx, rcx
		mov rax, 0
		mov cx, si
		.ciclo:
			add rax, [rdi]
			lea rdi, [rdi + 8]
			loop .ciclo
		
		pop rbp
		ret

	productoEscalar:
		;RDI = v
		;ESI = k
		;DX = n
		;RCX = w
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		
		mov rbx, rcx
		xor rcx, rcx
		xor rax, rax
		mov cx, dx
		mov eax, esi
		.ciclo:
			mov r12,[rdi]
			mul r12
			mov [rbx], r12
			lea rdi, [rdi + 8]
			add rbx, 8 
			loop .ciclo
			
		pop r12
		pop rbx
		pop rbp
		ret

	suma:
		;RDI = v, RSI = w, DX = n
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		
		xor rcx, rcx
		mov cx, dx
		.ciclo:
			mov rbx,[rsi]
			add [rdi], rbx
			lea rdi, [rdi + 8]
			lea rsi, [rsi + 8] 
			loop .ciclo
		
		pop rbx
		add rsp, 8
		pop rbp
		ret	

productoInterno:
		;RDI = v, RSI = w, DX = n
		push rbp
		mov rbp, rsp
		push rbx
		push r12	
			
		xor r12, r12
		xor rax, rax
		xor rcx, rcx
		mov r12, 0
		mov cx, dx
		.ciclo:
			mov ebx, [rdi]
			mov eax, [rsi]
			mul ebx
			add r12d, eax
			add rdi, 4
			add rsi, 4
			loop .ciclo
		xor rax, rax
		mov rax, r12
		
		pop r12
		pop rbx
		pop rbp
		ret

;long iesimo(lista l, unsigned long i)
iesimo:
	;RDI = lista, RSI = i
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	xor rax, rax
	xor rcx, rcx
	mov rbx, [rdi + lista_prim]					;rbx = lista->primero/nodo
	mov rcx, rsi
	.ciclo:
		lea r12, [rbx + nodo_t_prox]
		mov rbx, [r12]
		loop .ciclo
	mov rax, [rbx + nodo_t_dato]
	
	pop r12
	pop rbx
	pop rbp
	ret

;int buscar(lista l, long n)
buscar:
	;RDI = l, RSI = n
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	xor rax, rax
	xor r12, r12
	
	mov r12, 0
	mov rbx, [rdi + lista_prim]
	.ciclo:
	cmp rbx, NULL
	je .fin
	cmp [rbx + nodo_t_dato], rsi
	je .fin
	inc r12
	mov rbx, [rbx + nodo_t_prox]
	jmp .ciclo
	.fin:
	cmp rbx, NULL
	je .bye
	mov rax, r12
	.bye:
	pop r12
	pop rbx
	pop rbp
	ret

;void agregarAd(lista* l, long n)
agregarAd:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r12
	push r13
	
	mov rbx, rdi
	mov r13, rsi
	mov r12, [rdi + lista_prim]
	mov rdi, 16
	call malloc
	mov [rax + nodo_t_dato], r13
	mov [rax + nodo_t_prox], r12
	mov [rbx + lista_prim], rax 
	
	pop r13
	pop r12
	pop rbx
	add rsp, 8
	pop rbp
	ret
	
;void agregarAt(lista* l, long n)
agregarAt:	;RDI = l, RSI = n
	 push rbp
	 mov rbp, rsp
	 push rbx
	 push r12
	 push r13
	 push r14
	 
	 mov rbx, rdi
	 mov r14, rsi
	 lea r12, [rbx + lista_prim] 
	.ciclo: 
	 cmp qword[r12], NULL
	 je .agregar
	 mov r13, [r12]
	 lea r12, [r13 + nodo_t_prox]
	 jmp .ciclo
	 .agregar:
	 mov rdi, 16
	 call malloc
	 mov qword[rax + nodo_t_dato], r14 
	 mov qword[rax + nodo_t_prox], NULL
	 mov [r12], rax
	 
	 pop r14
	 pop r13
	 pop r12
	 pop rbx
	 pop rbp 
	 ret 

;void eliminarApariciones(lista* l, long n)
	eliminarApariciones:	; RDI = lista, RSI = n
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14
	
		lea rbx, [rdi + lista_prim]
		mov r12, rsi
		.ciclo:
			cmp qword[rbx], NULL
			je .fin
			mov r13, [rbx]
			cmp qword[r13 + nodo_t_dato], r12
			jne .seguir
			mov rdi, r13
			mov r14, [r13 + nodo_t_prox]
			mov [rbx], r14
			call free
			jmp .ciclo
		.seguir:
			lea rbx, [r13 + nodo_t_prox]
			jmp .ciclo
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

;void agregarOrdenado(lista* l, lista* l1) 
agregarOrdenado:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		
		lea rbx, [rdi]
		lea r12, [rsi] 
	.ciclo:	
		cmp qword[rbx], NULL
		je .fin
		mov r13, [rbx]
		cmp qword[r12], NULL
		je .fin
		
	.fin:
		pop r12
		pop rbx
		pop rbp
		ret
	
;void eliminarLista(lista* l)	  
eliminarLista:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		
		mov rbx, rdi
		lea r12, [rbx + lista_prim]
		cmp qword[r12], NULL
		je .fin
		mov r13, [r12]
		.ciclo:
			cmp r13, NULL
			je .fin
			mov rdi, r13
			mov r13, [rdi + nodo_t_prox]
			call free
			jmp .ciclo		
	.fin:
		mov rdi, rbx
		call free
		
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

;void eliminarRepetidos(lista* list)
eliminarRepetidos:     ;RDI = list
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14
		
		mov rbx, rdi
		lea r12, [rbx + lista_prim]
	.ciclo:
		cmp qword[r12], NULL
		je .fin
		mov r13, [r12]
		mov rdi, rbx
		mov rsi, [r13 + nodo_t_dato]
		call cantApariciones
		cmp rax, 0x00001
		jle .salta
		mov rdi, rbx
		mov rsi, [r13 + nodo_t_dato]
		call eliminarApariciones
		lea r12, [rbx + lista_prim]
		jmp .ciclo
	.salta:
		lea r12, [r13 + nodo_t_prox]
		jmp .ciclo
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret
	  
cantApariciones: ;RDI = lista, RSI = n_dato
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14
		
		xor rax, rax
		lea rbx, [rdi + lista_prim]
		mov r12, rsi
	.ciclo:	
		cmp qword[rbx], NULL
		je .fin
		mov r13, [rbx]
		cmp qword[r13 + nodo_t_dato], r12
		jne .seguir
		inc rax 
	.seguir:
		lea r14, [r13 + nodo_t_prox]
		mov rbx, r14
		jmp .ciclo
	.fin:
		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret
