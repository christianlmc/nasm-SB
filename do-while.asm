SYS_EXIT equ 60

;nasm -felf64 do-while.asm && ld do-while.o && ./a.out

%macro DO 0                 ;define uma macro chamada DO com 0 parametros
    %push do                ;joga o 'do' na pilha de contexto
        ;jmp %$init_loop     ;jump para um label de contexto ($) 'init_loop'
    %$start_loop:           ;label de contexto ($) 'start_loop'
    ;    push rax            ;empilha o valor de rax para a pilha
%endmacro                   ;finaliza a macro

;while (a < b)

;a = 2, b = 5

;DO
;a++
;WHILE a, l, b
%macro WHILE 3
    %ifctx do
    ;    pop rax
        cmp %1, %3
        j%-2 %%end_loop
        jmp %$start_loop
        ;%$init_loop:
            ;mov rax, %1
        ;    jmp %$start_loop
        %%end_loop:
            %pop
    %endif
%endmacro

%macro print_int 1
    push rax
    mov rax, %1
    call _printRAXDigit
    pop rax
%endmacro

%macro return 0
mov       rax, SYS_EXIT                 ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

global    _start

section   .text

_start:   
    mov rax, 2
    mov rbx, 5
    DO
        inc rax
        print_int rax

    WHILE rax, l, rbx
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
message:  db        "Hello, World", 10      ; note the newline at the end
digit: db 0,10
