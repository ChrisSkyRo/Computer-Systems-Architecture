; 19. Given 2 lists of bytes A and B, make the list of bytes R that only contains the even and the negative elements from the two lists.  
 
bits 32  
 
global start         

extern exit 
import exit msvcrt.dll

segment data use32 class=data 
    A db 2h, 1h, 3h, -3h, -4h, 2h, -6h 
    B db 4h, 5h, -5h, 7h, -6h, -2h, 1h 
    len equ $-A 
    d times len db 0 ; allocate the space for the destination array that can have a maximum length of len A + len B

segment code use32 class=code 
    start: 
        mov ECX, len
        mov ESI, 0 
        mov EBX, 0 ; the position at which we insert the value in the destination array
        jecxz Finish 
        Repeating: 
            mov AL, [A + ESI] 
            add AL, 0 ; sets the flags
             
            jns EndLoop ; jump if not negative
             
            shr AL, 1 ; jump if odd 
            jc EndLoop
            
            mov [d+EBX], AL 
            inc EBX 
                 
            EndLoop:     
                inc ESI 
        loop Repeating 
        Finish:
        push    dword 0       
        call    [exit] 