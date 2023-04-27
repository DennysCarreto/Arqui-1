; Dennys
; RPN por linea de comandos
;---------------------------------------------------------------------

%include "stdio.asm"

SECTION .data
    msg            db "Caracter desconocido ", 0h
    num            db "Error ", 0h
    expresion      db "Expresion no valida ", 0h

SECTION .bss

    cadena resw 500          ; expresion a calcular---------------------

SECTION .text
        global _start
_start:
    mov    ebp, esp
    xor    ecx, ecx          ; indice de evaluacion
    mov    ebx, 2
;--------------------------------------------------------------------------------------
evaluar:
    mov    eax, [ebp + ebx * 4]    ; si tiene numero negativo
    cmp    byte [eax + 1], 0
    jnz    evaluarNumero
    cmp    byte [eax], 43          ; compara el caracter con +
    je     sumar
    cmp    byte [eax], 45          ; compara el caracter con -
    je     restar
    cmp    byte [eax], 47          ; compara el caracter con /
    je     dividir
    cmp    byte [eax], 120         ; compara el caracter con x
    je     multiplicar
    cmp    byte [eax], 48          ; compara el caracter con codigo de los numeros
    jl     error
    cmp    byte [eax], 57
    jg     error
;-----------------------------------------------------------------------------------------
evaluarNumero:
    ; funcion que analiza el numero y agrega numero a la pila
    ; si edi es 1, muestra error, de lo contrario agrega el dato a la pila
    xor    edi, edi
    call   atoi
    cmp    edi, 1	                ;compara con edi, si recibe un error
    je     errorNumero
    mov    [cadena + ecx * 4], eax
    inc    ecx
;-------------------------------------------------------------------------------------------
ciclofinal:
    inc    ebx
    cmp    ebx, [ebp]
    jle    evaluar
    jmp    analizar
;---------------------------------------------------------------------------------------------
sumar:
    cmp    ecx, 2                       ;compara ecx a 2, si es menor la expresion no es valida
    jl     no_valida                    ;salto a expresion no valida
    dec    ecx
    mov    esi, [cadena + ecx * 4]      ;primer valor
    dec    ecx
    mov    eax, [cadena + ecx * 4]      ;segundo valor
    add    eax, esi	                ;ejecuta la suma
    ; despues de hacer la operacion ingresa a esi el resultado, llama a ciclo de impresion de resultado
    mov    [cadena + ecx * 4], eax
    inc    ecx
    jmp    ciclofinal
;--------------------------------------------------------------------------------------------
restar:
    cmp    ecx, 2                       ;compara ecx a 2, si es menor la expresion no es valida
    jl     no_valida                    ;salto a expresion no valida
    dec    ecx
    mov    esi, [cadena + ecx * 4]      ;primer valor
    dec    ecx
    mov    eax, [cadena + ecx * 4]      ;segundo valor
    sub    eax, esi		        ;ejecuta la resta
    ; despues de hacer la operacion ingresa a esi el resultado, llama a ciclo de impresion de resultado
    mov    [cadena + ecx * 4], eax
    inc    ecx
    jmp    ciclofinal
;-------------------------------------------------------------------------------------------
multiplicar:
    cmp    ecx, 2                       ;compara ecx a 2, si es menor la expresion no es valida
    jl     no_valida                    ;salta a expresion no valida
    dec    ecx
    mov    esi, [cadena + ecx * 4]      ;primer valor
    dec    ecx
    mov    eax, [cadena + ecx * 4]      ;segundo valor
    imul   eax, esi             	;ejecuta la multiplicacion
    ; despues de hacer la operacion ingresa a esi el resultado, llama a ciclo de impresion de resultado
    mov    [cadena + ecx * 4], eax
    inc    ecx
    jmp    ciclofinal
;----------------------------------------------------------------------------------------------
dividir:
    cmp    ecx, 2                       ;compara ecx a 2, si es menor la expresion no es valida
    jl     no_valida                    ;salta a expresion no valida
    dec    ecx
    mov    esi, [cadena + ecx * 4]      ;primer valor
    dec    ecx
    mov    eax, [cadena + ecx * 4]      ;segundo valor
    div    si		                ;ejecuta la division
    ; despues de hacer la operacion ingresa a esi el resultado, llama a ciclo de impresion de resultado
    mov    [cadena + ecx * 4], eax
    inc    ecx
    jmp    ciclofinal
;-----------------------------------------------------------------------------------------------
errorNumero:
    mov    eax, num
    call   printStr		;imprime mensaje de error en numero
    jmp    fin
;----------------------------------------------------------------------------------------------
error:
    push   eax		        ;salta a esta etiqueta en caso de ingresar un operador no valido
    mov    eax, msg
    call   printStr
    jmp    fin
;----------------------------------------------------------------------------------------------
no_valida:
    mov    eax, expresion
    call   printStrln
    jmp    fin
;-----------------------------------------------------------------------------------------------
analizar:
    ; si hay mas de un valor almacenado 1 2 3 +
    cmp    ecx, 1
    jne    no_valida
    ; extrae el resultado e imprime
    sub    ecx, 1
    mov    eax, [cadena + ecx * 4]
    call   iprintln
;--------------------------------------------------------------------------------------------------
fin:
    call   salir
