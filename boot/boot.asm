bits 16
org 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti
    
    mov si, loading_msg
    call print
    
    ; Load the kernel to 0x1000:0x0000 (physical address 0x10000)
    mov ax, 0x1000
    mov es, ax
    xor bx, bx
    
    mov ah, 0x02    ; Read sector
    mov al, 4       ; Read 4 sectors (2KB)
    mov ch, 0       ; Cylinder 0
    mov cl, 2       ; Starting from sector 2
    mov dh, 0       
    int 0x13
    jc disk_error
    
    mov si, loaded_msg
    call print
    
    ; go to kernel
    jmp 0x1000:0x0000

disk_error:
    mov si, error_msg
    call print
    cli
    hlt

print:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print
.done:
    ret

loading_msg: db "Loading kernel...", 0x0D, 0x0A, 0
loaded_msg:  db "Kernel loaded. Jumping...", 0x0D, 0x0A, 0
error_msg:   db "Disk error!", 0

times 510-($-$$) db 0
dw 0xAA55