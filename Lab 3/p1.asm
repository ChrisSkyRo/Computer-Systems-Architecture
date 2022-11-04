; a - byte, b - word, c - double word, d - qword - unsigned
; 19.(d+d)-(a+a)-(b+b)-(c+c)
bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 12h
    b dw 1234h
    c dd 12345678h
    d dq 12345678ABCDh

segment code use32 class=code
    start:
        ; edx:eax = d
        mov eax, dword[d]
        mov edx, dword[d+4]
        ; edx:eax = d+d
        add eax, dword [d]
        adc edx, dword [d+4]; edx:eax = 2468ACF1579Ah
        ; bl = a
        mov bl, byte[a]
        add bl, byte[a]     ; bl = a+a = 24h
        ; edx:eax = (d+d)-(a+a)
        sub al, bl          ; edx:eax = 2468ACF15776h
        ; bx = b
        mov bx, word[b]
        add bx, word[b]     ; bx = b+b = 2468h
        ; edx:eax = (d+d)-(a+a)-(b+b)
        sub ax, bx          ; edx:eax = 2468ACF1330Eh
        ; ebx = c
        mov ebx, dword[c]
        add ebx, dword[c]   ; ebx = c+c = 2468ACF0h
        ; edx:eax = (d+d)-(a+a)-(b+b)-(c+c)
        sub eax, ebx        ; edx:eax = 24688888861Eh
        push dword 0
        call [exit]