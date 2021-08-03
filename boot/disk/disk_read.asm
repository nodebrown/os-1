[bits 16]
disk_read:
    pusha 
    push dx
    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    int 0x13
    jc disk_read_error
    pop dx
    cmp dh, al
    jne disk_read_sector_error
    popa
    ret
disk_read_error:
    call print_nl
    mov bx, DISK_READ_ERROR_MSG 
    call print_string
    jmp $

disk_read_sector_error:
    call print_nl
    mov bx, DISK_READ_SECTOR_MSG
    call print_string
    jmp $


DISK_READ_ERROR_MSG: db "Error reading disk!...", 0
DISK_READ_SECTOR_MSG: db "Error : sectors are not fully read!...", 0
