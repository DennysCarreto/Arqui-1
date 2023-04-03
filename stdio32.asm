; Compilacion de subrutinas para entradas y salida estandar, arquitectura 32 bits
; ejemplo de archivo de cabecera en lenguaje ensamblador, implementacion de subrutinas


; ---------------calculo de longitud de cadena--------------
; srtLen(eax = cadena) -> eax int n = longitud	; devuelve un entero
strLen:
	push ebx		; insterta el valor de ebx en la pila
	mov ebx, eax	; mueve la direccion de la cadena a ebx


sigChar:
	cmp byte[eax], 0 	; compare el byte de eax ///if msg[eax] == 0
	jz	finLen		; Saltar al fina si se cumple la linea anterior
	inc eax			; eax++ // mover el eax entre la cadena/incrementar
	jmp	sigChar		; siguiente char

finLen:
	sub eax, ebx ; restar eax con ebx y se guarda en eax
	pop ebx			; extrae el valor de la pila
	ret

; ================ Impresion en pantalla
; void printStr(cadena) / cadeana = eax(contiene la cadena)
printStr:
	push	edx		; resguardar los registros
	push	ecx
	push	ebx
	push	eax
	; llamada a calculo de longitud, eax <- strLen(eax = cadena)
	call	strLen ; eax contiene el len
	mov		edx, eax
	pop 	eax		; devolver al registro a
	mov 	ecx, eax
	mov 	ebx, 1
	mov		eax, 4
	int 	80h
; sacar los datos de la pila, en orden inverso de como se fueron ingresando
	pop 	ebx
	pop 	ecx
	pop 	eax
	ret

; ================imprimir cadena con salto de linea==============
; void printStrLn(eax = cadena)
; imprime la cadena en pantalla seguida por la impresion de un salto de linea
printStrLn
	call	printStr
	push	eax
	mov 	eax, 0Ah
	push	eax
	mov 	eax, esp
	call	printStr
	pop		eax
	pop 	ebx 
	ret
; ================Imprimir entero ==============
printInt:
	push	eax
	push 	ecx
	push	edx
	push	esi
	mov		ecx, 0

divLoop:
	inc 	ecx			; Conteo de digitos
	mov 	edx, 0		; Limpiar parte alta del dividendo
	mov		esi, 10		; esi = 10  ; divisor
	idiv	esi			; Division entera entre edx y eax <edx:eax> / esi(10)
	add		edx, 48		; Sumarle 48
	push	edx
	cmp		eax, 0		; compara si es igual a 0
	jnz		divLoop

printLoop:
	dec 	ecx
	mov 	eax, esp
	call 	printStr
	pop		eax
	cmp		ecx, 0
	jnz 	printLoop
	pop		esi
	pop 	edx
	pop		ecx
	pop 	eax
	ret

; ============Imprimir entero con salto de linea ==============
printIntLn
	call 	printInt
	push	eax
	mov 	eax, 0Ah
	push 	eax
	call	printStr
	pop		eax
	pop		eax
	ret

; Final de codigo		----- void endP()
endP:
	mov		ebx, 0	; return 0 / valor que va a retornar
	mov 	eax, 1	; llamar a SYS_EXIT (kernel opcode 1)/ salir/exit
	int 	80h