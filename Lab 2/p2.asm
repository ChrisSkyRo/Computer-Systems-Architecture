; a,b,c,d - word
; 12. d-(a+b)-(c+c)

bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
a dw 1
b dw 2
c dw 3
d dw 4

segment code use32 class=code
start:
    mov ax, [a] ; AX = a
    add ax, [b] ; AX = a+b = 1+2 = 3
    mov bx, [c] ; BX = c
    add bx, [c] ; BX = c+c = 3+3 = 6
    sub ax, bx  ; AX = (a+b)-(c+c) = 3-6 = -3
    mov bx, [d] ; BX = d
    sub bx, ax  ; BX = d-(a+b)-(c+c) = 4-(-3) = 7
    push dword 0
    call [exit]