TOP_PATH = $(shell pwd)/
SRC_PATH = $(TOP_PATH)src/
BIN_PATH = $(TOP_PATH)bin/
BOCHS_PATH = $(TOP_PATH)bochs/
ASM_PATH = $(SRC_PATH)asm/

NASM = nasm

ASMS = $(notdir $(wildcard $(ASM_PATH)*.s))
BINS = $(patsubst %.s,$(BIN_PATH)%.bin,$(ASMS))

all:$(BINS)

$(BINS):$(BIN_PATH)%.bin:$(ASM_PATH)%.s
	$(NASM) -I $(ASM_PATH) -o $@ $<

install:
	sudo dd if=$(BIN_PATH)mbr.bin of=$(BOCHS_PATH)hd90M.img bs=512 count=1 conv=notrunc
	sudo dd if=$(BIN_PATH)loader.bin of=$(BOCHS_PATH)hd90M.img bs=512 count=1 seek=2 conv=notrunc