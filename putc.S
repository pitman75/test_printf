.text
.globl __io_putchar

__io_putchar:   addi    sp, sp, -8
        sw      a0, 0(sp)
        sw      ra, 4(sp)
        li      t1, 0x20100000
        sb      a0, 0(t1)
        lw      a0, 0(sp)
        lw      ra, 4(sp)
        addi    sp, sp, 8
        ret
