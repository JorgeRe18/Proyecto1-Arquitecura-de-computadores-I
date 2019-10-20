section .bss
	digitSpace resb 100
	digitSpacePos resb 8
	;;var resb 8


section .text
	global _start

_start:
	
	call _Parametros

	call _Pot		;Llama función de calculo de potencias
	xor rax, rax

	mov rax, r10		;antes r9
	call _printRAX

	mov rax, 60
	mov rdi, 0
	syscall


_Parametros:
	mov r13, 4		;Numero de muestras
	mov rax, 360		;Grados Total del Circulo

	idiv r13		;Divide los grados del circulo entre numero de muestras
	mov r14, r13		;Numero de muestras se mueve a r14
	xor r13, r13
	mov r13, rax		;Se copia a si mismo para multiplicarse y calcular potencia

	ret

_Pot:				;Calcula la potencia n de un numero
	mov r7, 1		;Indice de potencia (iteraciones del exponente)

	call _Pot2
	xor rax, rax
	mov rax, r13

	;call _Pot4

	;call _Pot6

	ret

_Pot2:				;Calcula la potencia 2

	imult r13


	cmp r7,1
	jne _Pot2

	mov r10, rax
	xor rax, rax
	call _Pot4

_Pot4:	
	inc r7			;Calcula la potencia 4
	imult r13

	cmp r7,4
	jne _Pot4

	mov r10,rax
	xor rax,rax

	call _Pot6

_Pot6:				;Calcula la potencia 6
	inc r7
	imult r13

	cmp r7,6
	jne _Pot6

	mov r10,rax
	xor rax,rax

	ret

_printRAX:
	mov rcx, digitSpace
	mov rbx, 10
	mov [rcx], rbx
	inc rcx
	mov [digitSpacePos], rcx

_printRAXLoop:
	mov rdx, 0
	mov rbx, 10
	div rbx
	push rax
	add rdx, 48
	
	mov rcx, [digitSpacePos]
	mov [rcx], dl
	inc rcx
	mov [digitSpacePos], rcx
	
	pop rax
	cmp rax, 0
	jne _printRAXLoop

_printRAXLoop2:
	mov rcx, [digitSpacePos]
	
	mov rax, 1
	mov rdi, 1
	mov rsi, rcx
	mov rdx, 1
	syscall
	
	mov rcx, [digitSpacePos]
	dec rcx
	mov [digitSpacePos], rcx

	cmp rcx, digitSpace
	jge _printRAXLoop2

	ret
