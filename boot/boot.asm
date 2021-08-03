[org 0x7c00]
[bits 16]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

mov bp, 0x9000
mov sp, bp

mov ax, 19
int 0x10

call load_kernel_into_memory

call switch_to_pm
jmp $

load_kernel_into_memory:
    pusha
    mov bx, KERNEL_OFFSET
    mov dh, 1
    mov dl, [BOOT_DRIVE]
    call disk_read
    popa
    ret

[bits 32]
begin_pm:
    call execute_kernel
    jmp $

execute_kernel:
    call KERNEL_OFFSET
    jmp $

%include "boot/disk/disk_read.asm"
%include "boot/pm/gdt.asm"
%include "boot/pm/switch_to_pm.asm"
%include "boot/print/print_nl.asm"
%include "boot/print/print_string.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55
