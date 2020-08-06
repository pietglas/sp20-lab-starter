.data           # set data in memory
.word 2, 4, 6, 8        # some unnamed array?
n: .word 9      # label set in memory (to 9)

.text
main:   add     t0, x0, x0
        addi    t1, x0, 1
        la      t3, n
        lw      t3, 0(t3)       # sets counter for fibonacci for-loop to 9
fib:    beq     t3, x0, finish  # calculate fibonacci until t3 = 0
        add     t2, t1, t0
        mv      t0, t1
        mv      t1, t2
        addi    t3, t3, -1
        j       fib
finish: addi    a0, x0, 1
        addi    a1, t0, 0       # print 9th fibonacci number
        ecall # print integer in a1
        addi    a0, x0, 10
        ecall # terminate ecall