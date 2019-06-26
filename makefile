all:
	nasm -felf64 while-do.asm && ld while-do.o && ./a.out