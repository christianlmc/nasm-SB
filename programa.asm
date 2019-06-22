; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------
; Fonte: https://cs.lmu.edu/~ray/notes/nasmtutorial/

%macro DO 0
 %push do
    jmp %$init_loop
%$start_loop:
    push rax
%endmacro

%macro FOR 4
 %ifctx do
    pop rax
    add rax, %4
    cmp rax, %3
    j%-2 %%end_loop
    jmp %$start_loop
%$init_loop:
    mov rax, %1
    jmp %$start_loop
%%end_loop:
 %pop
 %endif
%endmacro

global    _start
section   .text

_start:   
    DO
        mov       rax, 1                  ; system call for write
        mov       rdi, 1                  ; file handle 1 is stdout
        mov       rsi, message            ; address of string to output
        mov       rdx, 13                 ; number of bytes
        syscall                           ; invoke operating system to do the write
    FOR 0, l, 100, 1
    mov       rax, 60                 ; system call for exit
    xor       rdi, rdi                ; exit code 0 
    syscall

section   .data
message:  db        "Hello, World", 10      ; note the newline at the end