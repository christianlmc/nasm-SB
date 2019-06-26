SYS_EXIT equ 60;
;nasm -felf while-do.asm && ld while-do.o && ./a.out
%macro return 0
mov       eax, SYS_EXIT           ; system call for exit
xor       edi, edi                ; exit code 0 
syscall
%endmacro

%macro print_int 1
    push eax
    mov eax, %1
    call _printEAXDigit
    pop eax
%endmacro

%macro WHILE 3
    %push while
    %ifctx while
    %$initloop:
        cmp %1, %3
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

global    while_do
section   .text
while_do:
;Codigo copia
    push ebp
    mov ebp, esp
    push ebx
    push ecx

    mov ebx, [ebp+8]
    mov eax, ebx
    cmp eax, 42
    ;WHILE
    pop ebx
    mov esp, ebp
    pop ebp
;endcodigo 
    mov eax, 0
    mov ebx, 5
    push ebp

    WHILE eax, l, ebx
        inc eax
        print_int eax
    DO

    return

_printEAXDigit:
    push eax
    push edi
    push esi
    push edx

    add eax, 48
    mov [digit], al
    mov eax, 1
    mov edi, 1
    mov esi, digit
    mov edx, 2
    syscall

    pop edx
    pop esi
    pop edi
    pop eax
    ret
section   .data
message:  db        "Hello, World", 10  
digit: db 0,10
