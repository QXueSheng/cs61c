.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    li t0 1
    blt a2 t1 error_36
    blt a3 t1 error_37
    blt a3 t1 error_37 #If the stride of either array is less than 1,
#     this function terminates the program with error code 37

    li t6 0 # t6 num of jump num
     li t2 0 # t2 store sum
loop_start:
     
     add t0 t6 a3 # t1 = t0 +a3
     add t1 t6 a4 #t2
     slli t0 t0 2
     slli t1 t1 2 # t1*=4
 
    add t0 a0 t0 # t1 = a0 +t1 
    add t1 a1 t1 
    lw t0 0(t0) #t0 = a0[t0]
    lw t1 0(t1) #t1 = a1[t1]
    mul t3 t0 t1 # t3 store the  current result
    add t2 t2 t3 # t2 += t3
    bge t6 a2 loop_end # if t6 >= a2 ,end loop else t6 < a2 ,continue loop
    addi t6 t6 1
    j loop_start

loop_end:
    add a0 t2 x0 # return result 

    # Epilogue


    jr ra

error_36:
    li a0 36 
    j exit
    
error_37:
    li a0 37
    j exit