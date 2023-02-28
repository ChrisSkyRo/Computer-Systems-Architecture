; 8. Given an array of dwords, get the array formed from the lower bytes of the higher words of the dword which are palindromes in base 10.


bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s dd 12345678h, 1A2C3C4Dh, 98FCDC76h   
    len equ ($-s)/4    
    d times len db 0 
    copy db 0
    ten db 10

; our code starts here
segment code use32 class=code
    start:
        mov esi, s+(len-1)*4  
        mov edi, d+len-1    
        std               
        mov ecx, len        
        
        Repeating:
        lodsd              
        shr eax, 16          
        mov byte[copy], al 
        mov eax, 0
        mov al, byte[copy]
        mov ebx, 0    
        
            Palindrome:
            mov dl, al
            mov al, bl   
            mul byte[ten]  
            
            mov bl, al   
            mov al, dl  
            
            div byte[ten]
            add bl, ah  
            cmp al, 0
            jne Palindrome
            
        mov al, byte[copy]  
        cmp bl, al 
        jne Nope        
        stosb                
        Nope:
        loop Repeating
        
        push    dword 0    
        call    [exit]  
