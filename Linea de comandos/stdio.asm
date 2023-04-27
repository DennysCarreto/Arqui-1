;archivo de inclusion de funciones de entrada-salida estandar
;Dennys
;-----------------------------------------------------------------------------
;calcula la longitud de la cadena "mensaje" y devuelve un valor entero
;recibe "mensaje" en eax y devuelve longitud en eax

strlen:
	push	ebx		;coloca a ebx en la pila
	mov	ebx, eax	;ebx = eax
sigChar:
	cmp	byte[eax], 0	;compara el contenido de eax con NULL
	jz	finstrlen	;salta al final de la funcion
	inc	eax		;incrementa en 1 la direccion
	jmp	sigChar		;vuelve al inicio de bloque
finstrlen:
	sub	eax, ebx
	pop	ebx
	ret

;-----------------------------------------------------------------------------
;printStr(string mensaje)
;Impreime la cadena "mensaje" en pantalla
;recibe "mensaje" en eax

printStr:
	push	edx		;inserto edx en la pila
	push	ecx		;inserto ecx en la pila
	push	ebx		;inserto ebx en la pila
	push	eax		;inserto eax en la pila
	call	strlen		;llama a longitud de cadena
	mov	edx, eax	;edx = eax
	pop	eax		;extrae el ultimo valor de la pila (eax) en eax
	mov	ecx, eax	;mueve la cadena a ecx
	mov	ebx, 1
	mov	eax, 4
	int	80h
;regreso los registros a su valor inicial
	pop	ebx
	pop	ecx
	pop	edx
	ret
;-----------------------------------------------------------------------------
;printStrLn(string mensaje)
;imprime la cadena "mensaje" en pantalla y agrega un salto de linea
;recibe la cadena a imprimir en eax
printStrLn:
	call	printStr	;imprime en pantalla la cadena que recibe
	push	eax		;almacena eax en la pila
	mov	eax, 0Ah
	push	eax		;coloca eax en la pila '0Ah'
	mov	eax, esp	;eax=tope de la pila
	call	printStr	;llamada a imprimir en pantalla
				;el contenido de esp es la cadena
	pop eax
	pop eax
	ret
;-----------------------------------------------------------------------------
;void iprint(int numero)
;impresion de numeros enteros en pantalla

iprint:
	push	eax		;almacena eax en la pila
	push	ecx		;almacena ecx en la pila
	push	edx		;almacena edx en la pila
	push	esi		;almacena esi en la pila
	mov	ecx, 0		;contador de bytes a imprimir
cicloDiv:
	inc	ecx		;ecx++
	mov	edx, 0		;edx=0
	mov	esi, 10		;esi=10
	idiv	esi		;eax = eax / esi y residuo en edx
	add	edx, 48		;edx = edx + 48 equivalente en ascii
	push	edx		;almacena el codigo ascii en la pila
	cmp	eax, 0		;verifica si eax == 0
	jnz	cicloDiv	;si no es cero salta a cicloDiv
cicloImp:
	dec	ecx		;ecx--
	mov	eax, esp	;eax = esp (el puntero de pila)
	call	printStr
	pop	eax		;extrae el último valor de la pila en eax
	cmp	ecx, 0		;verifica si ecx == 0
	jnz	cicloImp;	si no es cero salta a cicloImp
	pop	esi
	pop	edx
	pop	ecx
	pop	eax
	ret
;-----------------------------------------------------------------------------
;Conversor de caracteres numericos a variables de tipo entero
;Recibe la cadena en eax

convertirInt:
	push	ebx
	push	ecx
	push	esi
	mov	ecx, 1
	mov	esi, eax
        mov     ebx, 0          ;ebx = 0

cicloMul:
        movzx   eax, byte[esi]
        inc     esi
        sub     al, '0'
        imul    ebx, 10
        add     ebx, eax
        dec     ecx
        jnz     cicloMul
        mov     eax, ebx
	pop	esi
	pop	ebx
	pop	ecx
        ret

;-----------------------------------------------------------------------------
;void iprintLn(int numero)
;Impresion de numeros enteros con fin de linea

iprintLn:
	call	iprint		;llamada de impresion de numeros
	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call	printStr
	pop	eax
	pop	eax
	ret
;-----------------------------------------------------------------------------
;void salir()

salir:
	mov	ebx, 0
	mov	eax, 1
	int	80h
	ret
