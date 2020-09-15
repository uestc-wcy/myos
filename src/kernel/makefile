all:
	gcc -c -o main.o main.c
	ld main.o -Ttext 0xc0001500 -e main -o ../../bin/kernel.bin 