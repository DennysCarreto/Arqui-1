; realiza las cuatro operaciones basicas
; Dennys

%include	'stdio.asm'

SECTION	.data
	msg1	db	'ingrese el primer numero', 0h
	msg2	db	'ingrese el segundo numero', 0h
	msg3	db	'suma: ', 0h
	msg4	db	'resta: ', 0h
	msg5	db	'multiplicacion: ', 0h
	msg6	db	'division: ', 0h

SECTION .bss
	num1:	resb	2
	num2:	resb	2

SECTION	.text
	global	_start
	_start:
		mov	eax, msg1	 ;ingreso de datos
		call	printStrLn
		mov	edx, 2
		mov	ecx, num1
		mov	ebx, 0
		mov	eax, 3
		int	80h

		mov	eax, msg2
		call	printStrLn
		mov     edx, 2
                mov     ecx, num2
                mov     ebx, 0
                mov     eax, 3
                int     80h

		mov	eax, msg3	;suma
		call	printStr
		mov	eax, num1
		call	convertirInt
		mov	ebx, eax
		mov	eax, num2
		call	convertirInt
		add	eax, ebx
		call	iprintLn

                mov     eax, msg4       ;resta
                call    printStr
                mov     eax, num1
                call    convertirInt
                mov     ebx, eax
                mov     eax, num2
                call    convertirInt
                sub     eax, ebx
                call    iprintLn

                mov     eax, msg5       ;multiplicacion
                call    printStr
                mov     eax, num1
                call    convertirInt
                mov     ebx, eax
                mov     eax, num2
                call    convertirInt
                imul	ebx, eax
                call    iprintLn

                mov     eax, msg6       ;division
                call    printStr
                mov     eax, num1
                call    convertirInt
                mov     ebx, eax
                mov     eax, num2
                call    convertirInt
                idiv    ebx
                call    iprintLn



		call	salir
