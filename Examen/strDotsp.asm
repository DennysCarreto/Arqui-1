; Dennys
; Llenar espacio en blanco con un punto '.'

%include 'stdio32.asm'

SECTION .data
    msg     db      'Esta es la cadena de ejemplo', 0h
    dest    db      32

SECTION .text
    global _start

_start: 
    mov     esi, src    ; dirección de la cadena 
    mov     edi, dest  
    mov     ecx, 32     ; número de caracteres a copiar en el registro  

copy_loop:
    mov     al, [esi]     ; cargamos el siguiente byte de la cadena de origen en AL
    cmp     al, ' '      ; comparar  el espacio en blanco
    je      cambiar    ; si es un espacio en blanco, llama a reemplazar
    mov     [edi], al             ; copiamos el byte actual de origen a destino
    inc     esi            
    inc     edi           
    loop    copy_loop 
    int     80h             ; saltamos al final del programa
    
cambiar:
    mov     byte [edi], '.'     ;reemplazamos si es un punto
    inc     esi          
    inc     edi           
    loop    copy_loop       ; repetimos
    call    endP