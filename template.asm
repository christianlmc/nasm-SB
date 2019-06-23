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
    ;CODE HERE

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