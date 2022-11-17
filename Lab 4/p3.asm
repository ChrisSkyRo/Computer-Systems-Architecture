; 31. Given the words A, B and C, form the double word D as a sum of numbers represented by:
; bits 1-5 of A
; bits 6-10 of B
; bits 11-15 of C

bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    A dw 0110101000010010b
    B dw 0011010010010101b
    C dw 0010011101010110b
    D resw 1

segment code use32 class=code
    start:
        mov AX, [A] ; AX = A = 6A12h
        and AX, 0000000000111110b ; separates bits 1-5
        shr AX, 1 ; forms the first number with bits 1-5 of A
        mov BX, AX ; puts the first number in BX = 9h
        mov AX, [B] ; AX = B = 3495h
        and AX, 0000011111000000b ; separates bits 6-10
        shr AX, 6 ; forms the second number with bits 6-10 of B
        add BX, AX ; adds the second number to the first BX = 1Bh
        mov AX, [C] ; AX = C = 2756h
        and AX, 1111100000000000b ; separates bits 11-15
        shr AX, 11 ; forms the third number with bits 11-15 of C
        add BX, AX ; adds the third number to the sum BX = 1Fh
        mov [D], BX ; places the result in D = 1Fh
        push dword 0
        call [exit]
        