section .data
    input db 'HOLA',0      ; Cadena de entrada en mayúsculas
    output db 4 dup(0)     ; Cadena de salida en minúsculas
    len equ $ - input      ; Longitud de la cadena de entrada

section .text
    global _start

_start:
    ; Copiar la cadena de entrada a la cadena de salida
    mov ecx, len
    mov esi, input
    mov edi, output
    rep movsb
 
    ; Convertir a minúsculas
    mov ecx, len
    mov esi, output
    xor eax, eax           ; Limpiar el registro eax
convert_loop:
    cmp byte [esi], 0      ; Si hemos llegado al final de la cadena, salir
    je convert_done
    cmp byte [esi], 'A'    ; Si la letra es mayúscula, convertir a minúscula
    jb convert_next
    cmp byte [esi], 'Z'
    ja convert_next
    sub byte [esi], 32     ; Restar 32 para convertir a minúscula
convert_next:
    inc esi
    loop convert_loop
convert_done:
    ; Imprimir la cadena de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
