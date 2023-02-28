%ifndef _ISEVEN_ASM
%define _ISEVEN_ASM

; testeaza daca numarul e par
    isEven:
        mov eax, [esp+4]
        shr eax, 1
        jc Odd
        mov eax, 0
        jmp checkEnd
        Odd:
            mov eax, 1
        checkEnd:
        ret 4
        
%endif
