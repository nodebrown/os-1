all: os-image

os-image: boot/bootloader kernel/kernel
	cat boot/bootloader kernel/kernel > os-image

boot/bootloader: boot/boot.asm
	nasm -f bin boot/boot.asm -o boot/bootloader

kernel/kernel: \
	kernel/kernel_entry.o \
	kernel/kernel.o \
	kernel/display.o \
	kernel/lowlevel.o
	ld -m elf_i386 \
		-Ttext 0x1000 \
		-o kernel/kernel \
		kernel/kernel_entry.o \
		kernel/kernel.o \
		kernel/display.o \
		kernel/lowlevel.o \
		--oformat binary

kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm -f elf32 kernel/kernel_entry.asm -o kernel/kernel_entry.o

kernel/kernel.o: kernel/kernel.c
	gcc -m32 -ffreestanding -fno-pie -fno-pic -c kernel/kernel.c -o kernel/kernel.o

kernel/display.o: kernel/display.c
	gcc -m32 -ffreestanding -fno-pie -fno-pic  -c kernel/display.c -o kernel/display.o

kernel/lowlevel.o: kernel/lowlevel.c
	gcc -m32 -ffreestanding -fno-pic -fno-pic -c kernel/lowlevel.c -o kernel/lowlevel.o

start: os-image
	qemu-system-x86_64 os-image

clean:
	rm -f \
		boot/bootloader \
		os-image \
		kernel/kernel \
		kernel/*.o
