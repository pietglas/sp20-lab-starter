.globl map

.text
main:
    jal ra, create_default_list
    add s0, a0, x0  # a0 = s0 is head of node list

    #print the list, followed by a newline
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    # prepare arguments
    add a0, s0, x0  # load the address of the first node
    la a1, square   # load the address of the function in question

    # issue the call to map
    jal ra, map

    # print the list, followed by a newline
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    addi a0, x0, 10
    ecall #Terminate the program

map:
    # Prologue: Make space on the stack and back-up registers
    addi, sp, sp, -8
    sw s0, 0(sp)
    sw ra, 4(sp)
mapHelper:
    beq a0, x0, done    # If we were given a null pointer (address 0), we're done.

    add s0, a0, x0  # Save address of this node in s0
    add s1, a1, x0  # Save address of function in s1
    lw a0, 0(s0)    # load the value of the current node into a0
 
    jalr ra, s1, 0  # Call the function on that value.
    
    sw a0, 0(s0)    # store returned value back into the node
    lw a0, 4(s0)    # Load address of the next node into a0
    add a1, s1, x0  # Put address of the function back into a1

    j mapHelper
done:
    # Epilogue: Restore register values and free space from the stack
    lw s0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8

    jr ra # Return to caller

square:
    mul a0 ,a0, a0
    jr ra

create_default_list:    # creates a linked list a0 -> 9->8->7...->0
    addi sp, sp, -12
    sw  ra, 0(sp)   # save return address on stack
    sw  s0, 4(sp)
    sw  s1, 8(sp)
    li  s0, 0       # pointer to the last node we handled
    li  s1, 0       # number of nodes handled
loop:   #do...
    li  a0, 8       # a0 = 8
    jal ra, malloc  # get memory (8 bytes) for the next node, to which a0 points
    sw  s1, 0(a0)   # node->value = i
    sw  s0, 4(a0)   # node->next = last
    add s0, a0, x0  # last = node
    addi    s1, s1, 1   # i++
    addi t0, x0, 10
    bne s1, t0, loop    # ... while i!= 10
    lw  ra, 0(sp)
    lw  s0, 4(sp)
    lw  s1, 8(sp)
    addi sp, sp, 12
    jr ra

print_list:
    bne a0, x0, printMeAndRecurse
    jr ra       # nothing to print if a0 is the nullptr
printMeAndRecurse:
    add t0, a0, x0  # t0 gets current node address
    lw  a1, 0(t0)   # a1 gets value in current node
    addi a0, x0, 1      # prepare for print integer ecall
    ecall
    addi    a1, x0, ' '     # a0 gets address of string containing space
    addi    a0, x0, 11      # prepare for print string syscall
    ecall
    lw  a0, 4(t0)   # a0 gets address of next node
    jal x0, print_list  # recurse. We don't have to use jal because we already have where we want to return to in ra

print_newline:
    addi    a1, x0, '\n' # Load in ascii code for newline
    addi    a0, x0, 11
    ecall
    jr  ra

malloc:
    addi    a1, a0, 0   # a1 = a0
    addi    a0, x0, 9   
    ecall               # allocate a1 bytes on heap, return ptr to 0(a0)
    jr  ra
