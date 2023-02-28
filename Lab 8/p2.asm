; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de vocale si sa se afiseze aceasta valoare.
; Numele fisierului text este definit in segmentul de date. 

bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import printf msvcrt.dll
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "p2.txt", 0  ; numele fisierului care va fi deschis
    mod_acces db "r", 0          ; modul de deschidere a fisierului - 
                                 ; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    len equ 100                  ; numarul maxim de elemente citite din fisier.                            
    text times len db 0          ; sirul in care se va citi textul din fisier  
    format db "In fisier sunt %d vocale", 0
    
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
        mov ebx, 0      ; numaram vocalele in ebx
        
        Repeating:
            ; punem caracterul curent in al
            lodsb    
            ; test vocala
            cmp al, 'a'
            je vowel
            cmp al, 'E'
            je vowel
            cmp al, 'i'
            je vowel
            cmp al, 'O'
            je vowel
            cmp al, 'u'
            je vowel
            cmp al, 'A'
            je vowel
            cmp al, 'e'
            je vowel
            cmp al, 'I'
            je vowel
            cmp al, 'o'
            je vowel
            cmp al, 'U'
            je vowel
            ; daca am ajuns aici nu e vocala
            notVowel:
                jmp endLoop
            vowel:
                inc ebx
            
            endLoop:
        loop Repeating
        
        ; afisam numarul de vocale
        push dword ebx
        push dword format
        call [printf]
        add esp, 4*2
        
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       