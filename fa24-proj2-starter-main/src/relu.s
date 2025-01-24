.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    li t0 1 #i
    blt a1 t0 error # If the length of the array is less than 1,
    
loop_start:
    li t0 0 # index t0 init as 0
    
loop_continue:
    bge t0 a1 loop_end # if  t0 >= a1 loop_end,else continue
    slli t1 t0 2    # t1 = t0*4
    add t2 t1 a0    #t2 = a0+t1
    lw t3 0(t2)     #t3 = *t2
    addi t0 t0 1    # t0++
    blt t3 x0 zero
    j loop_continue

loop_end:


    # Epilogue


    jr ra
    #this function terminates the program with error code 36
    
zero:
    sw x0 0(t2)
    j loop_continue
    
error:
    li a0 36 
    j exit
