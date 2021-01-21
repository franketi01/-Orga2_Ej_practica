%define NULL 0

%define node_size 28
%define offset_node_varID 0
%define offset_node_id 4
%define offset_node_count 8
%define offset_node_high 12
%define offset_node_low 20

%define mgr_size 36
%define offset_mgr_id 0
%define offset_mgr_nId 4
%define offset_mgr_vId 8
%define offset_mgr_true 12
%define offset_mgr_false 20
%define offset_mgr_dic 28

%define obbd_size 16
%define offset_obbd_mgr 0
%define offset_obbd_root 8

extern free
extern malloc

extern is_constant, is_true, dictionary_add_entry, obdd_mgr_get_next_node_ID

global obdd_mgr_mk_node
obdd_mgr_mk_node:			;RDI = mgr, RSI = var, RDX = high, RCX = low
	push rbp
	mov rbp, rsp
	sub rsp, 8
	push rbx
	push r12
	push r13
	push r14
	push r15

	mov rbx, rdi
	mov r12, rsi
	mov r13, rdx
	mov r14, rcx
	mov rdi, [rdi + offset_mgr_dic]
	call dictionary_add_entry
	mov r15, rax
	mov rdi, node_size
	call malloc
	mov dword[rax + offset_node_varID], r15d
	mov r15, rax
	mov rdi, rbx
	call obdd_mgr_get_next_node_ID
	mov dword[r15 + offset_node_id], eax
	mov qword[r15 + offset_node_high], r13
	cmp r13, NULL
	je .ir_low
	inc dword[r13 + offset_node_count]
.ir_low:
	mov qword[r15 + offset_node_low], r14
	cmp r14, NULL
	je .fin
	inc dword[r14 + offset_node_count]
.fin:	
	mov rax, r15 
	mov dword[rax + offset_node_count], 0

	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	add rsp, 8
	pop rbp
	ret

global obdd_node_destroy
obdd_node_destroy:			;RDI=node
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	mov rbx, rdi
	cmp dword[rbx + offset_node_count], 0
	jne .fin
	cmp qword[rbx + offset_node_high], NULL
	je .ir_low
	mov r12, [rbx + offset_node_high]
	dec dword[r12 + offset_node_count]
	mov qword[rbx + offset_node_high], NULL
	mov rdi, r12
	call obdd_node_destroy
.ir_low:
	mov r12, [rbx + offset_node_low]
	dec dword[r12 + offset_node_count]
	mov qword[rbx + offset_node_low], NULL
	mov rdi, r12
	call obdd_node_destroy
.fin:
	mov dword[rbx + offset_node_varID], 0
	mov dword[rbx + offset_node_id], 0
	mov rdi, rbx
	call free

	pop r12
	pop rbx
	pop rbp
	ret

global obdd_create
obdd_create:		;RDI=mgr , RSI=root
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	mov rbx, rdi
	mov r12, rsi
	mov rdi, obbd_size
	call malloc
	mov qword[rax + offset_obbd_mgr], rbx
	mov qword[rax + offset_obbd_root], r12 
	pop r12
	pop rbx
	pop rbp
	ret

global obdd_destroy
obdd_destroy:				;RDI = root
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	mov rbx, rdi
	cmp qword[rdi + offset_obbd_root], NULL
	je .terminar
	mov rdi, [rbx + offset_obbd_root]
	call obdd_destroy
	mov qword[rbx + offset_obbd_root], NULL
.terminar:
	mov qword[rbx + offset_obbd_mgr], NULL
	mov rdi, rbx
	call free
	pop r12
	pop rbx
	pop rbp
	ret

global obdd_node_apply
obdd_node_apply:
ret

global is_tautology
is_tautology:			;RDI=mgr, RSI=root 
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14

	mov rbx, rdi
	mov r12, rsi
	call is_constant
	cmp eax, 0
	je .else
	mov rdi, rbx
	mov rsi, r12
	call is_true
	jmp .fin
.else:
	mov rdi, rbx
	mov rsi, [r12 + offset_node_high]
	call is_tautology
	mov r13, rax
	mov rdi, rbx
	mov rsi, [r12 + offset_node_low]
	call is_tautology
	and rax, r13
.fin:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

global is_sat
is_sat:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14

	mov rbx, rdi
	mov r12, rsi
	call is_constant
	cmp eax, 0
	je .else
	mov rdi, rbx
	mov rsi, r12
	call is_true
	jmp .fin
.else:
	mov rdi, rbx
	mov rsi, [r12 + offset_node_high]
	call is_sat
	mov r13, rax
	mov rdi, rbx
	mov rsi, [r12 + offset_node_low]
	call is_sat
	or rax, r13
.fin:
	pop r14
	pop r13
	pop r12
	pop rbx
	ret

global str_len
str_len:			
	push rbp   			 
	mov rbp, rsp
	xor rax, rax
.ciclo:
	cmp byte[rdi], 0
	je .fin
	inc rdi
	inc rax
	jmp .ciclo
.fin:
	inc rax
	pop rbp
	ret

global str_copy
str_copy:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	mov rbx, rdi
	call str_len
	mov rdi, rax
	call malloc
.ciclo:
	cmp byte[rbx], 0
	je .fin
	mov byte[rax], bl
	inc rax
	inc rbx
	jmp .ciclo
.fin:
	mov byte[rax], 0
	pop r12
	pop rbx
	pop rbp
	ret

global str_cmp
str_cmp:
	push rbp
	mov rbp, rsp
	
	xor rax, rax
.ciclo:
	cmp byte[rdi], 0
	je .sin_byte
	cmp byte[rsi], 0
	je .mayor
	mov r8b, [rdi]
	cmp r8b, [rsi]
	jl .menor
	jg .mayor
	inc rdi
	inc rsi
	jmp .ciclo
.sin_byte:
	cmp byte[rsi], 0
	je .fin
.menor:
	or rax, 1
	jmp .fin
.mayor:
	or rax, -1
.fin:	
	pop rbp
	ret

