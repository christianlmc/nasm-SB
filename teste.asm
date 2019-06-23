;nasm -felf64 teste.asm && ld teste.o && ./a.out
;MACRO de 0 a 10
;for(i = 0; i < 10; i++)
SYS_EXIT equ 60;

global    _start
section   .text
_start: 
    jmp _init_loop_1

    _start_loop_1:
        push rax

        mov rax, rax

        add rax, 48
        mov [digit], al
        mov rax, 1
        mov rdi, 1
        mov rsi, digit
        mov rdx, 2
        syscall


        pop rax
        add rax, 1
        cmp rax, 10
    jge _FOR_end_loop_1
    jmp _start_loop_1

    _init_loop_1:
    mov rax, 0
    jmp _start_loop_1

    _FOR_end_loop_1:
        mov       rax, SYS_EXIT                 ; system call for exit
        xor       rdi, rdi                ; exit code 0 
        syscall

section   .data
digit: db 0,10