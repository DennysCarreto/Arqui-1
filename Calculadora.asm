
; Calculadora que Suma/Resta/Multiplica y Divide
; Dennys Carreto


SECTION	 .data
	[msg1	db	10, 'Calculadora', 10,0]
	[lmsg1	equ	$-msg1]				; aqui me lee el msg1

	[msg2	db	10, 'Ingrese Primer munero: ',0]
	[lmsg2	equ	$-msg2]

	[msg3	db	'Ingrese Segundo Numero:',0]
	[lmsg3	equ	$-msg3]

	[msg4	db	10, '1. Suma',10,0]
	[lmsg4	equ	$-msg4]

	[msg5	db	'2. Resta',10,0]
	[lmsg5	equ	$-msg5]

	[msg6	db	'3. Multiplicacion',10,0]
	[lmsg6	equ	$-msg6]

	[msg7	db	'4. Division', 10,0]
	[lmsg7	equ	$.msg7]

	[msg8	db	'5. Salir', 10,0]
	[lmsg8	equ	$-msg8]

	[msg9	db	'Elija una Opcion: ' ,0]
	[lmsg9	equ	$-msg9]

	msg10	db	10, 'El Resultado es: ',0
	lmsg10	equ	$-msg10

	msg11	db	10, 'La Opcion esta Incorrecta', 10,0
	lmsg11	equ	$-msg11


SECTION  .bss
	; Aqui se reserva espacio en la memoria para que almacene  los valores que se ingresen
	opcion:		resb	2
	num1:		resb	2
	num2:		resb	2
	resultado:	resb	2

SECTION	 .text
	global _start

_start: 
	; Se imprime msg1
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg1
	mov	edx, lmsg1
	int	80h

	; Se imprime msg2
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg2
	mov	edx, lmsg2
	int	80h

	;Aqui se Obtiene el primer numero
	mov	eax, 3
	mov	ebx, 0
	mov	ecx, num1
	mov	edx, 2
	int	80h

	;Se imprime el msg3
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg3
	mov	edx, lmsg3
	int	80h

	;Aqui se Obtiene el segundo Numero
	mov	eax, 3
	mov	ebx, 0
	mov	ecx, num2
	mov	edx, 2
	int	80h

	;Se imprime msg4
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg4
	mov	edx, lmsg4
	int	80h

	;Se imprime el msg5
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg5
	mov	edx, lmsg5
	int	80h

	;Se imprime el msg6
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg6
	mov	edx, lmsg6
	int	80h

	;Se imprime el msg7
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg7
	mov	edx, lmsg7
	int	80h

	;Se imprime el msg8
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg8
	mov	edx, lmsg8
	int	80h

	;Se imprime el msg9
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg9
	mov	edx, lmsg9
	int	80h

	;Aqui se obtiene la opcion que elija el usuario
	mov	ebx, 0
	mov	ecx, opcion
	mov	edx, 2
	mov	eax, 3
	int	80h

	mov	Ah, [opcion]		;Se mueve la opcion elejida a el registro Ah
	sub	Ah, '0'			;aqui se convierte el numero ingresado a decimal

	cmp	Ah, 1			;aqui se compara el valor ingresado para saber que operacion realizr
	je	suma

	cmp	Ah, 2			;aqui se compara el valor ingresado para saber que opercion realizar
	je	Resta

	cmp	Ah, 3			;aqui se compara el valor ingresado para saber que operacion realiza
	je	Multiplicacion

	cmp	Ah, 4			;aqui se compara el valor ingresado para saber que operacion realiza
	je	Division

	cmp	Ah, 5			;aqui se compara el valor ingrasado para saber que operacion realiza
	je	Salir

	;si el valor ingresado no cumple entonces que muestre el msg11
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg11
	mov	edx, lmsg11
	int	80h

	jmp	salir

;-----------------------Sumar-----------------------------------

	Suma:
		;Aqui se moveran los numeros que se ingreso a los registros Al y Bl
		mov	al, [num1]
		mov	bl, [num2]

		;Aqui se convierten los numeros ingresados a decimal
		sub	al, '0'
		sub	bl, '0'

		;Aqui se suman los registros Al y Bl
		add	al, bl

		;Aqui se convierten el resultado de la suma de decimal a binario
		add	al, '0'

		;Aqui movemos el reultado a un espacio de la memoria
		mov	[resultado], al

		;Se imprime el msg10
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, msg10
		mov	edx, lmsg10
		int	80h

		;Aqui se imprime el resultado
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, resultado
		mov	edx, 2
		int	80h

		;Se finaliza el programa
		jmp	salir

;-----------------------------Resta-----------------------------------------

	Resta:
		;Aqui se mueve los numeros ingresados a los registros Al y Bl
		mov	al, [num1]
		mov	bl, [num2]

		;Aqui se convierten los valores ingresados de bin a decimal
		sub	al, '0'
		sub	bl, '0'

		;Aqui se restan los  registros Al y Bl
		sub	al, bl

		;Aqui se convierten el resultado de la resta de decimal a bin
		add	al, '0'

		;Aqui se mueve el resultado a un espacio reservado en la memoria
		mov	[resultado], al

		;Se imprime el msg10
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, msg10
		mov	edx, lmsg10
		int	80h

		;Aqui se imprime el resultado
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, resultado
		mov	edx, 1
		int	80h

		;se finaliza el programa
		jmp	salir

;----------------------------Multiplicacion--------------------------------------

	Multiplicacion:
		;Aqui movemos los numeros ingresados a los registros Al y Bl
		mov	al, [num1]
		mov	bl, [num2]

		;Aqui se convierten los numeros ingresadsos de bin a decimal
		sub	al, '0'
		sub	bl, '0'

		;Aqui se multiplica Ax igual a Al por Bl, ax=al*bl
		mul	bl

		;se convierte el resultado de la resta de decimal a bim
		add	ax, '0'

		;Aqui movemos el resultado a un espacio reservado en la memoria
		mov	[resultado], ax

		;Se imprimen el msg11
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, msg11
		mov	edx, lmsg11
		int	80h

		;Aqui se imprime el resultado
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, resultado
		mov	edx, 1
		int	80h

		;se finaliza el programa
		jmp	Salir

;----------------------------Division-------------------------------------------------

	Dividir:
		;Aqui movemos los numeros ingresados a los registros Al y Bl
		mov	al, [num1]
		mov	bl, [num2]

		;Aqui se iguala a cero los registros Dx y Ah
		mov	dx, 0
		mov	ah, 0

		;Aqui se convierten los numeros ingresados de bin a decimal
		sub	al, '0'
		sub	bl, '0'

		;Aqui se Dividen Al = Ax / Bl, Ax = Ah Al
		div	bl

		;Se convierte el resultado de la resta de decimal a bin
		add	ax, '0'

		;Aqui se mueve el resultado en un espacio reservdo  de la memoria
		mov	[resultado], ax

		;Se imprime el msg11
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, msg11
		mov	edx, lmsg11
		int	80h

		;Se imprime el resultado
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, resultado
		mov	edx, 1
		int	80h

		; se finaliza el programa
		jmp	Salir

;-------------------------------Codigo para salir-----------------------------------------------------

	Salir:
		;Se imprime el msg8
		mov	eax, 4
		mov	ebx, 1
		mov	ecx, msg8
		mov	edx, lmsg8
		int	80h

		;se finaloiza el programa
		mov	eax, 1
		mov	ebx, 0
		int	80h

