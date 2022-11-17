; 19. Se da un cuvant A. Sa se obtina dublucuvantul B astfel:
; bitii 28-31 ai lui B sunt 1;
; bitii 24-25 si 26-27 ai lui B sunt bitii 8-9 ai lui A
; bitii 20-23 ai lui B sunt bitii 0-3 inversati ca valoare ai lui A ;
; bitii 16-19 ai lui B sunt biti de 0
; bitii 0-15 ai lui B sunt identici cu bitii 16-31 ai lui B.

bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    A dw 0110101000010010b
    B resd 1 ; 1111 1010 1101 0000b = FAD0h

segment code use32 class=code
    start:
        mov AX, [A] ; AX = 0110101000010010b
        mov EBX, 11110000000000000000000000000000b ; facem bitii 28-31 sa fie 1
        and AX, 0000001100000000b ; izolam bitii 8-9
        cwde ; convertim wordul din AX la dword in EAX
        shl EAX, 16 ; mutam biti 8-9 pe 24-25
        or EBX, EAX ; punem bitii in EBX
        shl EAX, 2 ; mutam bitii 8-9 de pe 24-25 pe 26-27
        or EBX, EAX ; punem bitii in EBX
        mov AX, [A] ; AX = 0110101000010010b
        and AX, 0000000000001111b ; izolam bitii 0-3
        xor AX, 0000000000001111b ; inversam bitii 0-3
        cwde ; convertim wordul din AX la dword in EAX
        shl EAX, 20 ; punem bitii 0-3 pe 20-23
        or EBX, EAX ; punem bitii in EBX
        shr EBX, 16 ; punem bitii 16-31 pe 0-15
        mov AX, BX ; facem o copie in BX
        shl EBX, 16 ; punem bitii inapoi pe 16-31
        mov BX, AX ; facem bitii 0-15 identici cu 16-31 punand copia
        mov [B], EBX ; construim B
        push dword 0
        call [exit]
        