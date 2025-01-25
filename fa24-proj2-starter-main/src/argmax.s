.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li t1 1
    bge a1 t1 loop_start #if a1 >= t1 startloop else
    li a0 36
    j exit

loop_start:
    li t0 0 # t0 will be used as the index

    add t3 x0 t0        # t3 store the max index init as 0
    lw t4, 0(a0)               #  t4 store the max value  init as  the first value from the array a0
    
loop_continue:
    bge t0 a1 loop_end # If index >= length, exit the loop
    slli t1, t0, 2             # Multiply index by 4 to get byte offset (since int = 4 bytes) t1 = 4 * t0
    add t2, a0, t1             # t2 points to a0[t0]
    lw t5 0(t2)                             # Load the current element a0[t0] at t5
     
    blt t4 t5 change_max # if t4 < t5
    
    addi t0 t0 1
    j loop_continue
    
loop_end:
    # Epilogue
    add a0 x0 t3
    jr ra
    
change_max:
    add t3 x0 t0        # t3 store the max index 
    add t4 x0 t5               #  t4 store the max value 
    addi t0 t0 1
    j loop_continue
    
    