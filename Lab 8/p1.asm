; Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor.
; Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date). 

bits 32
global start         
 
; declare external functions needed by our program 
extern exit, printf, scanf            
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicating to the assembler that the printf fct can be found in the msvcrt.dll library
import scanf msvcrt.dll      ; similar for scanf
 
; our data is declared here  
segment data use32 class=data 
    a resw 2
    b resw 2
    result resd 1
    format  db "%d", 0
 
; our code starts here 
segment code use32 class=code 
    start: 
        ; citirea lui a
        push dword a
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ; citirea lui b
        push dword b
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ; calculeaza a*b si il pune in result
        mov ax, word[a]
        mul word[b]
        mov [result], eax
        
        push    dword 0       
        call    [exit]