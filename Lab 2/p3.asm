; a,b,c - byte, d - word
; 12. a*[b+c+d/b]+d

bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
a db 1
b db 2
c db 3
d dw 4

segment code use32 class=code
start:
    mov ax, [d]  ; AX = d
    div byte [b] ; AX = d/b = 4/2 = 2
    add ax, [b]  ; AX = b+d/b = 2+2 = 4
    add ax, [c]  ; AX = b+c+d/b = 3+4 = 7
    mul byte [a] ; AX = a*[b+c+d/b] = 1*7 =7
    add ax, [d]  ; AX = a*[b+c+d/b]+d = 7+4 = 11
    push dword 0
    call [exit]