; creador Dennys
; fecha; 15/03/2023
; Ingreso de datos y almacenamiento en memoria para impresion en pantalla

%include 'stdio32.asm'

SECTION .data
    msg1    db  'Por favor ingrese su nombre: ', 0h
    msg2    db  'Hola, ', 0h

; Declaracion de variable
SECTION .bss
    nombre: resb    255           ; declaracion: resevab + cantidad(bytes)


SECTION .text
    global _start

_start:
        mov     eax, msg1
        call    printStr

        mov     edx,     255         ; Numero maximo de bytes a lee
        mov     ecx,     nombre      ; Nombre de variable a leer
        mov     ebx,     0           ; Leer desde STDIN fiel
        mov     eax,     3           ; Invocacion de SYS_READ (Kernel opcode 3)
        int     80h

        mov     eax,    msg2
        call    printStr

        mov     eax,    nombre
        call    printStrLn

        call    endP
