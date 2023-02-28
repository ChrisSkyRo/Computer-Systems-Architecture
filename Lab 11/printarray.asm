%ifndef _PRINTARRAY_ASM
%define _PRINTARRAY_ASM

extern printf
import printf msvcrt.dll

; afiseaza un sir de numere
    printArray:
        ModuleLoop:
            lodsd
            push ecx
            push esi
            
            push eax
            push dword [esp+16]
            call [printf]
            add esp, 8
            
            pop esi
            pop ecx
            sub ecx, 3
        loop ModuleLoop
        ret 4

%endif
