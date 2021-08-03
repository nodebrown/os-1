all: os-image

os-image: boot/bootloader kernel/kernel
	cat boot/bootloader kernel/kernel > os-image

boot/bootloader: boot/boot.asm
	nasm boot/boot.asm -f bin -o boot/bootloader

kernel/kernel: kernel/kernel.bin kernel/kernel_entry.bin
	/opt/cross/bin/i686-elf-ld -o kernel/kernel -Ttext 0x1000 kernel/kernel_entry.bin kernel/kernel.bin kernel/*.o --oformat binary

kernel/kernel.bin: kernel/kernel.c
	/opt/cross/bin/i686-elf-gcc -ffreestanding -c kernel/kernel.c -o kernel/kernel.bin

kernel/kernel_entry.bin: kernel/kernel_entry.asm
	nasm kernel/kernel_entry.asm -f elf -o kernel/kernel_entry.bin

start: os-image
	qemu-system-x86_64 os-image

clean: kernel/*.bin kernel/kernel boot/bootloader
	rm -f kernel/*.bin kernel/kernel boot/bootloader 

