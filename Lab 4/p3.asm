; 31. Se dau cuvintele A, B si C. Sa se formeze cuvantul D ca suma a numerelor reprezentate de:
; biţii de pe poziţiile 1-5 ai lui A
; biţii de pe poziţiile 6-10 ai lui B
; biţii de pe poziţiile 11-15 ai lui C

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
        and AX, 0000000000111110b ; izolam bitii 1-5
        shr AX, 1 ; facem numarul format de bitii 1-5
        mov BX, AX ; punem primul numar in BX = 9h
        mov AX, [B] ; AX = B = 3495h
        and AX, 0000011111000000b ; izolam bitii 6-10
        shr AX, 6 ; facem numarul format de bitii 6-10
        add BX, AX ; adunam al doilea numar la BX = 1Bh
        mov AX, [C] ; AX = C = 2756h
        and AX, 1111100000000000b ; izolam bitii 11-15
        shr AX, 11 ; facem numarul format de bitii 11-15
        add BX, AX ; adunam al treilea numar la BX = 1Fh
        mov [D], BX ; punem rezultatul in D = 1Fh
        push dword 0
        call [exit]
        