; 19. Given a word A, form the double word B:
; bits 28-31 of B are 1;
; bits 24-25 and 26-27 of B are the bits 8-9 of A
; bits 20-23 of B are the bits 0-3 of A inversed;
; bits 16-19 of B are 0;
; bits 0-15 of B are identical with the bits 16-31 of B.

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
        mov EBX, 11110000000000000000000000000000b ; makes bits 28-31 equal to 1
        and AX, 0000001100000000b ; separates bits 8-9
        cwde ; converts the word from AX to dword in EAX
        shl EAX, 16 ; moves bits 8-9 to 24-25
        or EBX, EAX ; puts the bits EBX
        shl EAX, 2 ; moves bits 8-9 from 24-25 to 26-27
        or EBX, EAX ; puts the bits in EBX
        mov AX, [A] ; AX = 0110101000010010b
        and AX, 0000000000001111b ; separates bits 0-3
        xor AX, 0000000000001111b ; reverse bits 0-3
        cwde ; converts the word from AX to double word in EAX
        shl EAX, 20 ; moves bits 0-3 to 20-23
        or EBX, EAX ; puts the bits EBX
        shr EBX, 16 ; moves bits 16-31 to 0-15
        mov AX, BX ; makes a copy in BX
        shl EBX, 16 ; returns the bits back to 16-31
        mov BX, AX ; makes bits 0-15 identical to bits 16-31 by placing the copy
        mov [B], EBX ; forms B
        push dword 0
        call [exit]
        