CC=c99
CFLAGS= -Wall -Wextra -pedantic -O0 -ggdb -lm
NASM=nasm
NASMFLAGS=-f elf64 -g -F DWARF

all: pract2 pract2b pract2c pract2d pract2e

pract2: pract2.c pract2.o
		$(CC) $(CFLAGS) $^ -o $@

pract2b: pract2b.c pract2b.o
		$(CC) $(CFLAGS) $^ -o $@

pract2c: pract2c.c pract2c.o
		$(CC) $(CFLAGS) $^ -o $@

pract2d: pract2d.c pract2d.o
		$(CC) $(CFLAGS) $^ -o $@

pract2e: pract2e.c pract2e.o
		$(CC) $(CFLAGS) $^ -o $@

pract2.o: pract2.asm
		  $(NASM) $(NASMFLAGS) $< -o $@

pract2b.o: pract2b.asm
		   $(NASM) $(NASMFLAGS) $< -o $@

pract2c.o: pract2c.asm
		   $(NASM) $(NASMFLAGS) $< -o $@

pract2d.o: pract2d.asm
		   $(NASM) $(NASMFLAGS) $< -o $@

pract2e.o: pract2e.asm
		   $(NASM) $(NASMFLAGS) $< -o $@

clean:
		rm -f *.o
		rm -f pract2 pract2b pract2c pract2d pract2e
