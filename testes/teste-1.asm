;nasm -felf64 teste-1.asm && ld teste-1.o && ./a.out
SYS_EXIT equ 60;

%macro DO 0
 %push do
    jmp %$init_loop
%$start_loop:
    push rax
%endmacro

%macro WHILE 3
 %ifctx do
    pop rax
    mov rbx, %3
    cmp rax, rbx
    j%+2 %%end_loop
    jmp %$start_loop
%$init_loop:
    mov rax, %1
    jmp %$start_loop
%%end_loop:
 %pop
 %endif
%endmacro

%macro print_int 1
    mov rax, %1
    call _printRAXDigit
%endmacro

%macro return 0
mov       rax, SYS_EXIT           ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

global    _start
section   .text
_start:
    mov rcx, 2
    mov rdx, 5
    print_int rcx    
    DO
        add rcx, 1
    WHILE rcx, ne, rdx
    print_int rcx
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