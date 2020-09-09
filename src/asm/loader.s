%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR

    mov byte [gs:0x00],'1'
    mov byte [gs:0x01],0xa4