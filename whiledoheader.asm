SYS_EXIT equ 60;
;nasm -f elf whiledoheader.asm -o whiledoheader.o
;gcc -m32 -c -o tstwhile.o tstwhile.c 
%macro return 0
mov       eax, SYS_EXIT           ; system call for exit
xor       edi, edi                ; exit code 0 
syscall
%endmacro

%macro WHILE 3
    %push while
    %ifctx while
    %$initloop:
        mov eax, %1
        mov ebx, %3
        cmp eax, ebx
        j%-2 %$endloop

    %endif        
%endmacro

%macro DO 0
    %ifctx while
    jmp %$initloop
    %$endloop:
        %pop
    %endif
%endmacro

section .text
global run_while

run_while:

    pusha
    
    ;mov ebp, esp

    mov eax, [ebp+8]
    mov ebx, [ebp+12]
    WHILE eax, l, ebx
        inc eax
        ;print_int rax
    DO

    ;xor edx, edx

    popa
    mov eax,0

    leave

    ;leave
    ret




