; 32. Given an array of bytes S of length l, create an array D of length l-1 in which the values represent the quotient of every 2 values S(i) and S(i+1) from S.
; S: 1, 6, 3, 1
; D: 0, 2, 3

bits 32 

global start

extern exit
import exit msvcrt.dll 

segment data use32 class=data
    S db 1, 6, 3, 1
    len equ $-S-1
    D times len db 0 ; allocate the space for the destination array that can have a maximum length of len S - 1
    
    
segment code use32 class=code
    start:
        mov ecx, len
        mov esi, 0
        mov edi, 0
        jecxz Finish 
        Repeating:
            mov al, byte[S+esi]
            inc esi
            cbw
            div byte[S+esi]
            mov byte[D+edi], al
            inc edi
        loop Repeating 
        Finish:
        push    dword 0      
        call    [exit]