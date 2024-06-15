# The printf testcase

The simplest baremetal test case for testing printf on RISC-V RV32I_Zicsr core. To be sure that our program works well the set of sources send output bytestream to a special address in RAM. Testbench should capture and write to a file. Also the same as program will emulate by spike with generation of run log. Run logs from testbench and from spike to be compired.

Configuration of sources:

 - Flash for program start address: 0x80000000
 - Flash for program size         : 0x100000
 - RAM for data start address      : 0x20000000
 - RAM for data size               : 0x6000
 - Output byte stream address      : 0x20100000

It use *xpack-riscv-none-elf-gcc* to build baremetal program, other tools of gcc to build files for RAM/Flash.

Result of work

![test_result_hello](https://github.com/pitman75/test_printf/assets/12179612/9b9cd75b-de3c-4969-a72a-617c502fc911)
