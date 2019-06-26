all:
	nasm -felf while-do.asm
	gcc -m32 -c tstwhile.c
	gcc -m32 -o main while-do.o tstwhile.o