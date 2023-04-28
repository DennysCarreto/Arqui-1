; Dennys
; Multtiplicacion ciclica
%include 'stdio32.asm'

section .data
    msg db 'Ingresar base y exponete> (base exponente)": ', 0
    base_times db 'x', 0
    result_msg db 'Resultado: ', 0
    buffer db 16            ; almacenar en memoria

section .bss
    base        resd 1  ; base
    exp    resd 1       ; exponente
    result resd 1       ; resultado

section .text
    global _start

_start:
    ; Imprimir mensaje
    mov eax, 4  
    mov ebx, 1  
    mov ecx, msg
    mov edx, len
    int 80h 

    ; Leer la entrada del usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, base
    mov edx, 1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, exp
    mov edx, 1
    int 0x80

    ; Convertir la entrada de la línea de comandos a valores enteros
    mov eax, base
    sub eax, 48
    mov ebx, 10
    mul ebx
    mov ebx, eax

    mov eax, exp
    sub eax, 48
    mov ecx, 10
    mul ecx

    ; Calcular la potencia utilizando multiplicación cíclica
    mov ecx, eax  ; contador del ciclo (exponente)
    mov eax, ebx  ; valor de la base
    mov ebx, resultado  ; valor inicial del resultado

ciclo:
    test cl, 1  ; verificar si el bit menos significativo del exponente es 1
    jz no_multiplicar
    mul ebx  ; multiplicar el resultado actual por la base
    mov ebx, eax  ; almacenar el resultado en ebx
    mov eax, resultado  ; almacenar el valor original del resultado en eax

no_multiplicar:
    mul eax  ; elevar al cuadrado el valor de la base
    mov ebx, eax  ; almacenar el resultado en ebx
    mov eax, resultado  ; almacenar el valor original del resultado en eax
    shr ecx, 1  ; desplazar el exponente hacia la derecha
    jnz ciclo  ; repetir el ciclo mientras el exponente sea mayor que cero

    ; Escribir el resultado en pantalla
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 4
    int 80h

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    call endP