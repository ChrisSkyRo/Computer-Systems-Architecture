; a - byte, b - word, c - double word, d - qword - signed
; 19.(d+a)-(c-b)-(b-a)+(c+d)
bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db -10h
    b dw -123h
    c dd 12345678h
    d dq 12345678ABCDh
    
segment code use32 class=code
    start:
        ; edx:eax = d
        mov eax, dword[d]
        mov edx, dword[d+4]
        add al, byte[a]         ; edx:eax = d+a = 12345678ABBDh
        mov ebx, dword[c]       ; ebx = c
        sub bx, word[b]         ; ebx = c-b = 1234579Bh
        sub eax, ebx            ; edx:eax = (d+a)-(c-b) = 123444445422h
        mov bx, word[b]         ; bx = b
        movsx cx, byte[a]
        sub bx, cx              ; bx = b-a = -113h = FEEDh
        sub ax, bx              ; edx:eax = (d+a)-(c-b)-(b-a) = 123444445535h
        ; ecx:ebx = d
        mov ebx, dword[d]
        mov ecx, dword[d+4]
        add ebx, dword[c]       ; ecx:ebx = c+d = 123468AD0245h
        ; edx:eax = (d+a)-(c-b)-(b-a)+(c+d) = 2468ACF1577Ah
        add eax, ebx
        adc edx, ecx
        push dword 0
        call [exit]