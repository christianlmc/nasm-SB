;nasm -felf64 teste-2.asm && ld teste-2.o && ./a.out
SYS_EXIT equ 60;

%macro return 0
mov       rax, SYS_EXIT           ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

%macro print_int 1
    mov rax, %1
    call _printRAXDigit
%endmacro

global    _start
section   .text
_start:
    ;do{
    ;   rcx++
    ;}while(rcx < rdc)
    mov rbx, 2
    mov rcx, 5
    print_int rbx
    ;DO
    ;%push do    
    jmp _ctx_init_loop     ;jump para um label de contexto ($) 'init_loop'
    _ctx_start_loop:           ;label de contexto ($) 'start_loop'
        push rax 
    ;ENDDO
    ; stack = 
    ; rax = 2
    ; rbx = 3
    ; rcx = 5
        
        
        add rbx, 1  
    ;WHILE  
    ;%ifctx do
        pop rax
        cmp rbx, rcx
        ;j%-2 %%end_loop
        jge _while_end_loop
        jmp _ctx_start_loop
        _ctx_init_loop:
            mov rax, rbx
            jmp _ctx_start_loop
        _while_end_loop:
            ;%pop
    ;%endif
    ;ENDWHILE
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