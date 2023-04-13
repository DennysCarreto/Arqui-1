; Dennys
;Convertir a mayuscula la cadena
 	%include	'stdio32.asm'
 SECTION .data
  msg db 'Ingrese letras: ', 0h
  msg3 db 'Converitdo ', 0h
  
  SECTION .bss
    cadena: resb 45 

  SECTION .text
	global _start

_start:
	mov			eax, msg 
	call		printStrLn
	mov			eax,45
	mov         ebx,cadena
	call		inpStr  
	mov         eax, msg3
	call 		printStrLn
	mov         eax, cadena  
    call 		strca
    call     endP