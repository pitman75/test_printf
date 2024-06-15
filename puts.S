.text
.globl puts

puts:   addi    sp, sp, -8
        sw      a0, 0(sp)
        sw      ra, 4(sp)
        li      t1, 0x20100000
loop:   lb      t0, 0(a0)
        beq     t0, x0, end
        sb      t0, 0(t1)
        addi    a0, a0, 1
        j loop
end:    lw      a0, 0(sp)
        lw      ra, 4(sp)
        addi    sp, sp, 8
        ret
