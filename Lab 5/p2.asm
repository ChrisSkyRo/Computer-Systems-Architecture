; 25. Given two strings S1 and S2, create a string D that contains all elements from S1 that don't appear in S2.

bits 32 

global start        

extern exit
import exit msvcrt.dll 
segment data use32 class=data
    S1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    S2 db 'a', '4', '5'
    len equ S2-S1
    len2 equ $-S2
    d times len db 0 ; allocate the space for the destination array that can have a maximum length of len A + len B

; our code starts here
segment code use32 class=code
    start:
        mov ECX, len
        mov ESI, 0
        mov EBX, 0 ; the index for the second loop
        mov EAX, 0
        jecxz Finish
        Repeating:
            cmp EBX, len2 ; checks if it's done iterating through S2 without finding equal elements
            
            je InsertElement
            
            jmp Compare
            
            InsertElement:         ; inserts and element in the destination string
                mov EDX, [S1+ESI]
                mov [d+EAX], EDX
                inc EAX
            
            ResetEBX:              ; resets second loop
                mov EBX, 0
                inc ESI
            
            Compare:                ; checks equality
                mov EDX, [S1+ESI]
                cmp DL, [S2+EBX]
                
            je ResetEBX
            
            cmp ESI, len ; keeps looping if there are elements left
            
            ja EndLoop
            
            jmp ContinueLoop
            
            EndLoop:
                mov ECX, 0
            
            ContinueLoop:
                inc EBX      ; increments the index of the second string
                inc ECX      ; increments ECX for an infinite loop
                
        loop Repeating
        Finish: ;terminarea programului
        push    dword 0      
        call    [exit]
