; a,b,c,d - byte
; 12. 2-(c+d)+(a+b-c)

bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
a db 1
b db 2
c db 3
d db 4

segment code use32 class=code
start:
    mov bl, [a] ; BL = a = 1
    add bl, [b] ; BL = a+b = 1+2 = 3
    sub bl, [c] ; BL = (a+b)-c = 3-3 = 0
    mov al, [c] ; AL = c = 3
    add al, [d] ; AL = c+d = 3+4 = 7
    add bl, al  ; BL = (c+d)+(a+b-c) = 7+0 = 7
    mov al, 2   ; AL = 2
    sub al, bl  ; AL = 2-(c+d) = 2-7 = -5
    push dword 0
    call [exit]