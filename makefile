BIN_PATH = bin/
BOCHS_PATH = bochs/
BOOT_SRC_PATH = src/boot/
KERNEL_SRC_PATH = src/kernel/

DISK_NAME = hd30M.img

NASM = nasm
CC = gcc

BOOT_BIN = $(patsubst %.s,$(BIN_PATH)%.bin,$(notdir $(wildcard $(BOOT_SRC_PATH)*.s)))

all:$(BOOT_BIN)
	cd $(KERNEL_SRC_PATH);make
$(BOOT_BIN):$(BIN_PATH)%.bin:$(BOOT_SRC_PATH)%.s
	$(NASM) -I $(BOOT_SRC_PATH) -o $@ $<

install:
	sudo dd if=$(BIN_PATH)mbr.bin of=$(BOCHS_PATH)$(DISK_NAME) bs=512 count=1 conv=notrunc
	sudo dd if=$(BIN_PATH)loader.bin of=$(BOCHS_PATH)$(DISK_NAME) bs=512 count=4 seek=2 conv=notrunc
	sudo dd if=$(BIN_PATH)kernel.bin of=$(BOCHS_PATH)$(DISK_NAME) bs=512 count=200 seek=9 conv=notrunc