.data
source:
    .word   3, 1, 4, 1, 5, 9, 0
dest:
    .word   0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
main:
    addi t0, x0, 0  # t0 = 0 (variable k)
    addi s0, x0, 0  # s0 = 0 (variable sum)
    la s1, source   # s1 points to source
    la s2, dest     # s2 points to dest
loop:
    slli s3, t0, 2  # s3 = t0 << 2 (set offset source; if t0 = 1, s3 = 4)
    add t1, s1, s3  # t1 = s1 + s3 (offset t1, which points to source)
    lw t2, 0(t1)    # t2 = t1 (get proper elt from source)      
    beq t2, x0, exit    # if t2 == 0, exit
    add a0, x0, t2  # a0 = t2 (set argument func)
    addi sp, sp, -8 # allocate space for two words on stack
    sw t0, 0(sp)    # store t0 on stack
    sw t2, 4(sp)    # store t2 on stack
    jal func        # jump to func
    lw t0, 0(sp)    # load t0 from stack
    lw t2, 4(sp)    # load t2 from stack
    addi sp, sp, 8  # clean up the stack
    add t2, x0, a0  # t2 = a0, return value of square
    add t3, s2, s3  # t3 = s2 + s3  (offset t3, which points to dest)
    sw t2, 0(t3)    # t3 = t2   (set dest at t3 equal to t2)
    add s0, s0, t2  # s0 += t2  (increment sum)
    addi t0, t0, 1  # ++t0  (increment k)
    jal x0, loop    # i.e. j loop
func: 
    add t0, a0, x0  # t0 = a0
    add t1, a0, x0  # t1 = a0
    addi t0, t0, 1  # ++t0
    addi t2, x0, -1 # t2 = -1
    mul t1, t1, t2  # t1 *= t2
    mul a0, t0, t1  # a0 = t0 * t1 ( = -a0 * (a0 + 1))
    jr ra           # return to ra
exit:
    addi a0, x0, 1  # prints a1
    add a1, x0, s0  # set a1 = sum
    ecall # prints a1
    addi a0, x0, 10
    ecall # exit