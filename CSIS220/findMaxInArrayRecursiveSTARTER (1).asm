# Program File:  findMaxInArrayRecursive.asm
# Author:        Saif Ullah and Parker Fellows
# Version:       
# Purpose:       Recursively find the largest value in 
#                an array stored in memory.
# Precondition:  The array has at least one value.
.text
main:
    # $s0 <—- address of the first value in array
    # $s1 <-— addressed of the last value in array    
    # YOUR CODE HERE
    la $s0, array
    la $s1, array
    lw $t0, arrayLength
    mul $t1, $t0, 4
    add $s1, $s1, $t1
    subi $s1, $s1, 4
    
    # find the maximum value in the array
    # Set the arguments before 
    # calling the function
    # YOUR CODE HERE
    add $a0, $zero, $s0
    add $a1, $s1, $zero
    jal findMaxRecursive		
    
    # Print the answer
    # $s2 <-- answer
    add $s2, $zero, $v0
    la $a0, answer
    jal utilPrintString		
    add $a0, $zero, $s2
    jal utilPrintInt
    jal utilPrintNewLine
    
    # End the program
    jal utilEndProgram

################################################################
# Purpose:        Recursively find the largest
#                 value in the array
# Arguments:      $a0 <— address of the first value in the array
#                 $a1 <—- address of the last value in the array
# Return values:  $v0 <-- the maximum value
################################################################
findMaxRecursive:
    # push array pointers and return address
    # YOUR CODE HERE
    subi $sp, $sp, 12		
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $ra, 8($sp)
    
    # base case:
    # if array pointers are equal, $v0 <-- ($a0)
    # YOUR CODE HERE
    seq $t0, $a0, $a1
    lw $v0, ($a0)	
    bnez $t0, return # meaning the array pointers are equal

    # Recursive step    
    # array pointers are not equal
    # If the value at $a0 < the value at $a1, move $a0.
    # Otherwise, move $a1.
    # YOUR CODE HERE
    lw $t1, ($a0)    #comparing the values at each location to deicde which pointer to move in the array and dong recursive step
    lw $t2, ($a1)
    bge $t1, $t2, moveUpper
    addi $a0, $a0, 4
    j recursiveStep
    
    moveUpper:
    subi $a1, $a1, 4
    
    recursiveStep:
    jal findMaxRecursive
    
    
    
    # restore $a0, $a1 from the stack
    # YOUR CODE HERE
    lw $a0, 0($sp)
    lw $a1, 4($sp)

return:
    # max value at ($a0)
    # Restore the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    # YOUR CODE HERE
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    #only in return
    jr $ra		

.data
    answer:       .asciiz "\nAnswer: "
    array:        .word 11, 4, 3, 5, 22
    arrayLength:  .word 5
    
.include "utils.asm"
