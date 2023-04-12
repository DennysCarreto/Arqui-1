; Autor: Dennys
; Fecha de creación: 11/04/23 
; Proyecto1. Calculadora con envío de parámetros (algebraica de 2 valores)
%include 'stdio32.asm'

SECTION .data
    msg1 db 'Ingrese el primer valor: ', 0
    msg2 db 'Ingrese el segundo valor: ', 0
    resultado db 'El resultado es: %d', 10, 0
    error_division db 'Error: División por cero', 10, 0

SECTION  .bss
    valor1 resb 5
    valor2 resb 5

SECTION  .text
    global _start

_start:
    ; =========  Mensaje 1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 23
    int 80h

    ; ====== tomar valor ingresado por el usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, valor1
    mov edx, 5
    int 80h

    ; ========== Mensaje 2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 24
    int 80h

    ; ====== Tomar valor ingresado por el usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, valor2
    mov edx, 5
    int 80h