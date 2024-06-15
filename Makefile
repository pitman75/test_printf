GCC_DIR = ~/.local/xPacks/riscv-none-elf-gcc/xpack-riscv-none-elf-gcc-13.2.0-2/bin
TOOL_NAME = riscv-none-elf-
GCC = gcc
AS  = as
OBJDUMP = objdump
OBJCOPY = objcopy
STRIP = strip
RESULT_FILE = hello
SYSCALLS_FILE = syscalls
PUTC_FILE = putc
PUTS_FILE = puts
START_FILE = _start
MARCH = rv32i_zicsr
MABI = ilp32
LINKER_SCRIPT = link
GCC_FLAGS = -static -nostartfiles --specs=nosys.specs -mrelax
SPIKE_DIR = ~/bin/

all:
	$(GCC_DIR)/$(TOOL_NAME)$(AS) -march=$(MARCH) -mabi=$(MABI) $(PUTC_FILE).S -o $(PUTC_FILE).o
	$(GCC_DIR)/$(TOOL_NAME)$(AS) -march=$(MARCH) -mabi=$(MABI) $(PUTS_FILE).S -o $(PUTS_FILE).o
	$(GCC_DIR)/$(TOOL_NAME)$(AS) -march=$(MARCH) -mabi=$(MABI) $(START_FILE).S -o $(START_FILE).o
	$(GCC_DIR)/$(TOOL_NAME)$(GCC) -march=$(MARCH) -mabi=$(MABI) $(GCC_FLAGS) -T $(LINKER_SCRIPT).ld $(START_FILE).o $(RESULT_FILE).c $(SYSCALLS_FILE).c $(PUTC_FILE).o $(PUTS_FILE).o -o $(RESULT_FILE)
#	$(GCC_DIR)/$(TOOL_NAME)$(STRIP) $(RESULT_FILE)
	$(GCC_DIR)/$(TOOL_NAME)$(OBJDUMP) -D $(RESULT_FILE) > $(RESULT_FILE).objdump
	$(GCC_DIR)/$(TOOL_NAME)$(OBJCOPY) -O verilog --verilog-data-width 4 -j .text.init -j .text --gap-fill=0x00 $(RESULT_FILE) $(RESULT_FILE)_rom_init.tmp
	grep -v "^@" $(RESULT_FILE)_rom_init.tmp > $(RESULT_FILE)_rom_init.mem
	rm -f $(RESULT_FILE)_rom_init.tmp
	$(GCC_DIR)/$(TOOL_NAME)$(OBJCOPY) -O verilog --verilog-data-width 4 -j .rodata -j .srodata.cst8 -j .eh_frame -j .data -j .sdata -j .bss -j .sbss --gap-fill=0x00 --pad-to 0x20008000 $(RESULT_FILE) $(RESULT_FILE)_ram_init.tmp
	grep -v "^@" $(RESULT_FILE)_ram_init.tmp > $(RESULT_FILE)_ram_init.mem
	rm -f $(RESULT_FILE)_ram_init.tmp
	$(SPIKE_DIR)spike  --isa=RV32I_zicsr --priv=m -m0x20000000:0x8000,0x20100000:0x1000,0x80000000:0x100000 -d --debug-cmd=spike.cmd -l --log=$(RESULT_FILE)_spike_run.txt $(RESULT_FILE)

clean:
	rm -f $(RESULT_FILE).objdump
	rm -f $(RESULT_FILE).bin
	rm -f $(RESULT_FILE).data
	rm -f $(RESULT_FILE)_rom_init.mem
	rm -f $(RESULT_FILE)_ram_init.mem
	rm -f $(RESULT_FILE)
	rm -f $(RESULT_FILE)_spike_run.txt
	rm -f *.o
