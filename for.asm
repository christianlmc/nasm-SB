; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 for.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------
; Fonte: https://cs.lmu.edu/~ray/notes/nasmtutorial/
SYS_EXIT equ 60         ;equ faz um #DEFINE igual no C (aqui ta definindo SYS_EXIT como 60)

%macro DO 0             ;define uma macro chamada DO com 0 parametros
%push do                ;joga o 'do' na pilha de contexto
    jmp %$init_loop     ;jump para um label de contexto ($) 'init_loop'
%$start_loop:           ;label de contexto ($) 'start_loop'
    push rax            ;empilha o valor de rax para a pilha
%endmacro               ;finaliza a macro

;DO
; algumacoisa
;FOR 0, l, 4, 1
;for(i = 0; i < 4; i++)
%macro FOR 4                    ;define uma macro chamada FOR com 4 parametros
    %ifctx do                   ;verifica se o contexto eh do (na pilha de contexto)
        pop rax                 ;desempilha o valor de rax da pilha
        add rax, %4             ;adiciona rax com o 4o argumento
        cmp rax, %3             ;compara o rax com o argumento 3
        j%-2 %%end_loop         ;compara o inverso do argumento 2
        jmp %$start_loop        ;pula para o label de contexto ($) 'start_loop' do contexto do
        %$init_loop:            ;label de contexto ($) 'init_loop'
            mov rax, %1         ;move o parametro 1 para o rax
            jmp %$start_loop    ;pula para a label de contexto ($) 'start_loop'
        %%end_loop:             ;label local da macro 'end_loop'
            %pop                ;pop no contexto (sai do contexto 'do')
    %endif                      ;fim do ifctx do
%endmacro                       ;finaliza a macro

%macro print_int 1
    mov rax, %1
    call _printRAXDigit
%endmacro

%macro return 0
mov       rax, SYS_EXIT                 ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

global    _start
section   .text

_start:   
    DO
        print_int rax
    FOR 0, ne, 10, 1
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