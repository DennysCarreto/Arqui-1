; posicion x, y de texto en pantalla
; Imprime el mensaje centrado en pantalla
%include 'stdio32.asm'

SECTION .data
        msg     db      'Hola, mucho gusto', 0h
        posxy   db      1Bh, '[12;32H', 0h
        strCls  db      1Bh,'[2J', 1Bh, '[3J', 0h
        strFin  db      1Bh, '[24;1H', 0h

SECTION .text
        global _start

_start:
        mov     eax, strCls
        call    printStr

        mov     eax, posxy
        call    printStrLn

        mov     eax, msg
        call    printStr

        call    endP