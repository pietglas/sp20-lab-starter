.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)    # no need to save t0 on stack
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    add s0, a0, x0  # save value of which we want to calculate factorial
    addi a0, x0, 1  # set return value to 1
    beq s0, x0, return # if s0 = 0, return 0! = 1
    add t0, x0, x0  # set counter for the loop
factorial_loop:
    addi t0, t0, 1  # update the counter
    mul a0, a0, t0  # update result
    blt t0, s0, factorial_loop    
return:
    jr ra   # return 

