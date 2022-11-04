; a,b,c-byte; e-doubleword; x-qword - unsigned
; 19. (a+a+b*c*100+x)/(a+10)+e*a
bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 9h
    b db 11h
    c db 12h
    e dd 1234h
    x dq 12345678h
    copy dq 0
    
segment code use32 class=code
    start:
        mov al, byte[b]     ; al = b
        mov bl, byte[c]     ; bl = c
        mul bl              ; ax = b*c = 132h
        mov bx, 100         ; bx = 100 = 64h
        mul bx              ; eax = b*c*100 = 7788h
        ; edx:ebx = x
        mov ebx, dword[x]
        mov edx, dword[x+4] 
        ; edx:ebx = b*c*100+x = 124DCE00h
        add ebx, eax
        adc edx, 0
        add bl, byte[a]     ; edx:ebx = a+b*c*100+x = 124DCE09Ch
        add bl, byte[a]     ; edx:ebx = a+a+b*c*100+x = 124DCE12h
        mov eax, ebx        ; edx:eax = a+a+b*c*100+x = 124DCE12h
        mov bl, 10          ; bl = 10
        add bl, byte[a]     ; bl = a+10 = 13h
        movzx ecx, bl       ; ecx = a+10 = 13h
        div ecx             ; eax = (a+a+b*c*100+x)/(a+10) = 00F69F0Eh
        mov ebx, eax        ; ebx = (a+a+b*c*100+x)/(a+10) = 00F69F0Eh
        mov eax, dword[e]   ; eax = e
        movzx ecx, byte[a]  ; ecx = a
        mul ecx            ; edx:eax = e*a = A3D4h
        ; edx:eax = (a+a+b*c*100+x)/(a+10)+e*a = F742E2h
        add eax, ebx
        adc edx, 0
        push dword 0
        call [exit]