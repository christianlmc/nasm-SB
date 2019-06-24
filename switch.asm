SYS_EXIT equ 60;
Jack    EQU 1
Queen   EQU 2
King    EQU 3


%macro return 0
mov       rax, SYS_EXIT           ; system call for exit
xor       rdi, rdi                ; exit code 0 
syscall
%endmacro

%macro print_int 1
    mov rax, %1
    call _printRAXDigit
%endmacro

%macro SWITCH 1
%push switch            
%assign __curr 1
    mov rax, %1
    jmp %$loc %+ __curr
%endmacro

%macro CASE 1
%ifctx switch
    %$loc %+ __curr:
    %assign __curr __curr+1
    mov rbx, %1
    cmp rax, rbx
    jne %$loc %+ __curr
%endif
%endmacro

%macro DEFAULT 0
%ifctx switch
    %$loc %+ __curr:
%endif
%endmacro

%macro BREAK 0
    jmp %$endswitch
%endmacro

%macro ENDSWITCH 0
    %ifctx switch
    %$endswitch:
    %pop
    %endif
%endmacro

global    _start
section   .text
_start:
    ;CODE HERE
    mov rdx, 3

   SWITCH card
   CASE Jack
       add rdx, Jack
       BREAK
   CASE Queen
       add rdx, Queen
       BREAK
   CASE King
       add rdx, King
       BREAK
   DEFAULT
       add rdx, [card]
   ENDSWITCH

    print_int rdx
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
card    db  2   ;card_variable
message:  db        "Hello, World", 10      ; note the newline at the end
digit: db 0,10
