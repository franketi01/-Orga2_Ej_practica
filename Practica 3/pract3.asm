
global SumarVectores
global promedio4
global sumar
global mult4
global test
global memreserv

section .rodata
	max255: DB 225,255,255,255,255,255,255,255
	
	m4: DD 0xfffc, 0xfffc, 0xfffc, 0xfffc
	
	uno: DQ 1, 1

section .text
	;void SumarVectores(char *vectorA, char *vectorB, char *vectorResultado, int dimension)
	SumarVectores:  ; RDI = A, RSI = B , RDX = c, RCX  = dimension
		push rbp
		mov rbp, rsp
		
		shr rcx, 3
		movups xmm7, [max255]
		.ciclo:
			movdqu xmm1, [rdi]
			movdqu xmm2, [rsi]
			
			movdqu xmm3, xmm1
			paddb xmm3, xmm2
			
			movdqu [rdx], xmm3
			
			add rdi, 16
			add rsi, 16
			add rdx, 16
			loop .ciclo	
		
		pop rbp
		ret
	
	;void promedio4(int* a, short n)  
	promedio4:				;RDI = a, SI = n
		push rbp
		mov rbp, rsp
		
		pxor xmm0, xmm0
		movdqu xmm1, [rdi]
		
		phaddd xmm1, xmm0
		phaddd xmm1, xmm0
		
		cvtdq2pd xmm1, xmm1
		cvtsi2sd xmm2, rsi
		divpd xmm1, xmm2
		movdqu xmm0, xmm1
		
		pop rbp
		ret
		
	sumar:
		push 4
		push 6
		call sumarN
		pop r9
		pop r8
		ret
		
	sumarN:
		 xor rax, rax
		 add rax, [rsp + 8]
		 add rax,[rsp + 16]
		 ret
		 
		 
	;void mult4(int* v, int n);	 
	mult4:					;RDI = v, ESI = n
		push rbp
		mov rbp, rsp
	
		shr rsi, 2
		mov ecx, esi
		movups xmm2, [m4]
		movups xmm3, [uno]

	.ciclo:
		movups xmm1, [rdi]
		pand xmm1, xmm2
		por xmm1, xmm3
		movups [rdi], xmm1
		add rdi, 16
		loop .ciclo
		
		pop rbp
		ret
		
	test:
		push rbp
		mov rbp, rsp
		movapd xmm1,  [rdi]
		
		movapd [rdi], xmm1
		
		pop rbp
		ret
	
	;int* memreserv(int n, int* a)
	memreserv:				; EDI = n, RSI = a
		
		
		mov rcx, rdi
		shl rdi, 2
		sub rsp, rdi
		mov edx, 0
		mov rax, rsp

	.ciclo:
		cmp rdx, rcx 
		je .fin
		mov r8d, dword[rsi]
		mov dword[rsp], r8d
		add rsp, 4
		add rsi, 4
		inc edx
		jmp .ciclo
	.fin:
		ret
