; a,b,c,d-byte, e,f,g,h-word
; 12. (a*d+e)/[c+h/(c-b)]
bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
a db 1
b db 2
c db 3
d db 4
e dw 5
f dw 6
g dw 7
h dw 8

segment code use32 class=code
start:
    mov ax, [h]  ; AX = h
    mov bl, [c]  ; BL = c
    sub bl, [b]  ; BL = c-b = 3-2 = 1
    div bl       ; AL = h/(c-b) = 8/1 = 8
                 ; AH = 8%1 = 0
    add al, [c]  ; AL = [c+h/(c-b)] = 3+8 = 11
    mov bl, al   ; BL = [c+h/(c-b)] = 11
    mov al, [a]  ; AL = a
    mul byte [d] ; AX = a*d = 1*4 = 4
    add ax, [e]  ; AX = (a*d+e) = 4+5 = 9
    div bl       ; AL = (a*d+e)/[c+h/(c-b)] = 9/11 = 0
                 ; AH = 9%11 = 9
    push dword 0
    call [exit]