SYS_EXIT equ 60;
;nasm -felf64 while-do.asm && ld while-do.o && ./a.out
%macro return 0
mov       rax, SYS_EXIT           ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

%macro print_int 1
    mov rax, %1
    call _printRAXDigit
%endmacro

%macro WHILE 3
    %push while
    %ifctx while
    %$initloop:
        push %1
        push %3
        pop rax
        pop rbx 
        cmp rax, rbx
        jmp %$initloop
        j%-2 %$endloop
    %endif        
%endmacro
; stack = 
; rbx = 0
; rcx = 5

;WHILE %1, %2, %3
; algumacoisa
;DO 
%macro DO 0
    %ifctx while
    jmp %$initloop
    %$endloop:
        pop rax
        pop rax
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
    add rax, 48
    mov [digit], al
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall
    ret
section   .data
message:  db        "Hello, World", 10      ; note the newline at the end
digit: db 0,10