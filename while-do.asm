SYS_EXIT equ 60;
;nasm -felf64 while-do.asm && ld while-do.o && ./a.out
%macro return 0
mov       rax, SYS_EXIT           ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

%macro print_int 1
    push rax
    mov rax, %1
    call _printRAXDigit
    pop rax
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

global    _start
section   .text
_start:
    mov rax, 0
    mov rbx, 5

    WHILE rax, l, rbx
        inc rax
        print_int rax
    DO

    return

_printRAXDigit:
    push rax
    push rdi
    push rsi
    push rdx

    add rax, 48
    mov [digit], al
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall

    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret
section   .data
message:  db        "Hello, World", 10  
digit: db 0,10
