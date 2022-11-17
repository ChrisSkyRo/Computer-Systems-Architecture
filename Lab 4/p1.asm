; 10. Replace bits 0-3 of the byte B with the bits 8-11 of the word A.

bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    A dw 101000010010b
    B db 00100101b

segment code use32 class=code
    start:
        mov AX, [A]
        shr AX, 8 ; AX = 1010b
        mov BX, [B] ; BX = 0010 0101b
        and BX, 11110000b ; BX = 0010 0000b
        or BX, AX ; BX = 0010 1010b
        mov [B], BX ; B = 0010 1010b
        push dword 0
        call [exit]
        