;---------------------------------------------------------------------------
;int strlen(string mensaje)
;calcula la longitud de la cadena <mensaje> y devuelve un valor entero
;recibe <mensaje> en eax y devuelve longitud en eax

strlen:
	push	ebx		;coloca a ebx en la pila
	mov	ebx,eax		;ebx=eax
sigChar:
	cmp	byte[eax],0	;compara el contenido de eax con null
	jz	finStrlen	;si el contenido de eax=0 salta a finStrlen
	inc	eax		;sino eax=eax+1
	jmp	sigChar		;vuelve a comparar el siguiente caracter
finStrlen:
	sub	eax,ebx
	pop	ebx
	ret

;---------------------------------------------------------------------------
;printStr(string mensaje)
;imprime la cadena <mensaje> en pantalla
;recibe la cadena a imprimir en eax

printStr:
	push	edx		;ingreso edx a la pila
	push	ecx		;ingreso ecx a la pila
	push	ebx		;ingreso ebx en la pila
	push	eax		;ingreso eax en la pila
	call	strlen		;llama a la longitud de cadena
	mov	edx,eax		;mover el tamaño que no dio el strlen
	pop	eax		;extrae el ultimo valor de la pila y la coloco en  eax
	mov	ecx, eax
	mov	ebx,1
	mov	eax,4
	int	80h
	pop	ebx
	pop	ecx
	pop	edx
	ret

;---------------------------------------------------------------------------
;printStrLn(string mensaje)
;imprime la cadena <mensaje> en la pantalla y agrega un salto de linea
; recibe la cadena a imprimir en eax

printStrln:
	call	printStr	;imprime en pantalla la cadena que recibe
	push	eax		;almacena eax en al pila
	mov	eax,0Ah		;estoy imprimiendo el enter
	push	eax		;meto el enter en la pila
	mov	eax,esp		;eax es igual al inicio de la pila
	call	printStr	;llamada a imprimir en pantalla
				;el contenido de esp es la cadena
	pop	eax
	pop	eax		;para devolver el valor correcto
	ret

;---------------------------------------------------------------------------
; void iprint(int numero)
;lee entrada por teclado
; recibe la longitud a leer y el espacio reservado para la lectura
iprint:
	push	eax		;almacena eax en la pila
	push	ecx		;almacena ecx en la pila
	push	edx		;almacena edx en la pila
	push	esi		;almacena el registro de segmento en la pila, registro source
	push	edi
	mov	edi, 	0
	mov	ecx,	0

	test   eax, eax
	js     negar		;si es negativo

cicloDiv:
	inc	ecx
	mov	edx, 0
	mov	esi, 10
	idiv	esi		;los resudios siempre son mas pequeños del valor contra el que se divide, y aqui estamos dividiendo
	add	edx, 48  	;ahora solo lo coloco para que si sea numero
	push	edx
	cmp	eax,0
	jnz	cicloDiv

        cmp    edi, 1
        je     imprime_negativo

cicloImp:
	dec	ecx		;decrementar el ecx
	mov	eax,	esp	;el esp es el puntero que apunta a la posicion superior de la pila
	call	printStr
	pop	eax
	cmp	ecx,0
	jnz	cicloImp
        jmp    terminar

negar:
        mov    edi, 1
        neg    eax
        jmp    cicloDiv

imprime_negativo:
        push   45d
        inc    ecx
        jmp    cicloImp

terminar:
        pop    edi
        pop    esi
        pop    edx
        pop    ecx
        pop    eax
        ret

;---------------------------------------------------------------------------
;void iprintLn(imprime un numero)

iprintln:
	call	iprint
	push	eax
	mov	eax,0Ah
	push	eax
	mov	eax, esp
	call	printStr
	pop	eax
	pop	eax
	ret

;--------------------------------------------------------------------
;funcion para convertir cadena a entero
;int  atoi (int numero)

atoi:
    push   ecx		        ;almaceno datos en pila
    push   esi
    push   ebx

    mov    esi, eax             ;copio el puntero del numero a convertir a esi
    mov    eax, 0	        ;eax = 0
    mov    ecx, 0	        ;ecx = 0
    xor    edi, edi	        ;edi lo usare como bandera

    cmp    byte [esi], 45       ; si es negativo
    je     .negativo

.evaluar:
    xor    ebx, ebx		;ebx = 0
    mov    bl, [esi + ecx]	;muevo un byte a la parte baja de ebx
    cmp    bl, 10		;enter
    je     .invalido
    cmp    bl, 0		;caracter vacio
    jz     .invalido
    cmp    bl, 48     		; si el codigo ascii esta debajo de 0
    jl     .error
    cmp    bl, 57		; si esta despues del 9
    jg     .error

    sub    bl, 48		;convierto la parte baja de ebx en decimal
    add    eax, ebx		;sumo ebx al valor entero en eax
    mov    ebx, 10		;muevo el valor decimal a ebx
    mul    ebx			;multiplico eax por ebx para colocar el valor en su lugar
    inc    ecx			;incrementanto contador
    jmp    .evaluar		;llamada recursiva

.negativo:
    inc    ecx
    mov    edi, 1     		; indico que es negativo
    jmp    .evaluar


.negar:
    neg    eax
    mov    edi, 0     		; negar el contenido de eax en caso de ser negativo
    jmp    .terminar

.error:
    mov    edi, 1		;bandera indicando si hay error
    jmp    .terminar

.invalido:
    mov    ebx, 10
    div    ebx
    cmp    edi, 1
    je     .negar

.terminar:
    pop    ebx
    pop    esi
    pop    ecx
    ret

;---------------------------------------------------------------------------

;void salir()
salir:
	mov	ebx,0
	mov	eax,1
	int	80h
	ret

;---------------------------------------------------------------------------
