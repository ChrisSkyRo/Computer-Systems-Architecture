; Se citesc din fisierul numere.txt mai multe numere (pare si impare).
; Sa se creeze 2 siruri rezultat N si P astfel: N - doar numere impare si P - doar numere pare. Afisati cele 2 siruri rezultate pe ecran. 

bits 32 

global start        

extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import printf msvcrt.dll
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll

%include "iseven.asm"
%include "printarray.asm"

segment data use32 class=data
    nume_fisier db "numere.txt", 0  ; numele fisierului care va fi deschis
    mod_acces db "r", 0          ; modul de deschidere a fisierului - 
                                 ; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    len equ 100                  ; numarul maxim de elemente citite din fisier.                            
    text times len db 0          ; sirul in care se va citi textul din fisier  
    formatPare db "Numerele pare sunt: ", 0
    formatImpare db "Numere impare sunt: ", 0
    format db "%d ", 0
    ten dd 10
    lenPare dd 0
    lenImpare dd 0
    numerePare times len dd 0
    numereImpare times len dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; apelam fopen pentru a deschide fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4                 ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        mov ecx, eax    ; numarul de caractere din fisier este numarul de pasi
        mov esi, text   ; sirul sursa
        
        mov ebx, 0
        
        Repeating:
            lodsb
            
            cmp al, ' '
            
            jne AddDigit
            
            push dword ebx
            call isEven
            
            cmp eax, 0
            
            je NumarPar
            
            NumarImpar:
                mov edi, numereImpare
                add edi, [lenImpare]
                mov [edi], ebx
                mov al, byte[lenImpare]
                add al, 4
                mov [lenImpare], al
            
            mov ebx, 0
            
            jmp endLoop
            
            NumarPar:
                mov edi, numerePare
                add edi, [lenPare]
                mov [edi], ebx
                mov al, byte[lenPare]
                add al, 4
                mov [lenPare], al
            
            mov ebx, 0
            
            jmp endLoop
            
            AddDigit:
                sub al, '0'
                mov dl, al
                mov eax, ebx
                mul byte[ten]
                add al, dl
                mov ebx, eax
                
            endLoop:
        loop Repeating
        
        ; testare ultimul numar
        push dword ebx
        call isEven
        
        cmp eax, 0
        
        je UltimulNumarPar
            
        UltimulNumarImpar:
            mov edi, numereImpare
            add edi, [lenImpare]
            mov [edi], ebx
            mov al, byte[lenImpare]
            add al, 4
            mov [lenImpare], al
        
        jmp endUltimul
        
        UltimulNumarPar:
            mov edi, numerePare
            add edi, [lenPare]
            mov [edi], ebx
            mov al, byte[lenPare]
            add al, 4
            mov [lenPare], al
        
        endUltimul:
        
        
        ; afiseaza numerele pare
        push formatPare
        call [printf]
        add esp, 4
        
        mov esi, numerePare
        mov ecx, [lenPare]
        
        push format
        call ModuleLoop
        
        push ten        ; codul ascii pt newline
        call [printf]
        add esp, 4
        ; afiseaza numerele impare
        push formatImpare
        call [printf]
        add esp, 4
        
        mov esi, numereImpare
        mov ecx, [lenImpare]
        
        push format
        call ModuleLoop
        
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       
        
    
    
    
    
    