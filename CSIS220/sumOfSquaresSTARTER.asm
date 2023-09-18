# File Name:  Sum of Squares
# Author:  Saif Ullah, Anthony Russo, and Collin McDonough
# Version:  
# Purpose:  To compute the sum of the squares of 
#           three input integers using the function
#           square(x) and sumOfSquares(x, y, z).
.text
main:
    # Recall: 
    # -caller saves and restores $t0-$t9, $a0-$a3, $v0-$v1
    # -caller can use freely $s0-$s7
 
    # $s0 <-- symbolic address of values
    # $t0 <-- symbolic address of values
    la $s0, values
    la $t0, values
    
    # Get the three input values using a loop
    # and store them at the values symbolic address
getInput:
    beq $s6, 3, calculate
    addi $v0, $zero, 4
    la $a0, prompt
    syscall
    addi $v0, $zero, 5
    syscall
    sw $v0, ($s0)
    addi $s0, $s0, 4
    addi $s6, $s6, 1
    j getInput
    
        
    # Compute the sum of squares
    # by calling the sumOfSquares function
calculate:
    la $s0, values
    lw $a0, ($s0)
    addi $s0, $s0, 4
    lw $a1, ($s0)
    addi $s0, $s0, 4
    lw $a2, ($s0)
    addi $s0, $s0, 4
    jal sumOfSquares
  
    # Print the result
    add $s7, $v0, $zero
    la $a0, answer
    addi $v0, $zero, 4
    syscall
    add $a0, $s7, $zero
    addi $v0, $zero, 1
    syscall
    la $a0, newLine
    addi $v0, $zero, 4
    syscall
  
    # End program
endProgram:
    addiu $v0, $zero, 10
    syscall
    
########################### Functions ############################

  # Recall:
  # callee save and restore $s0-$s7, $ra
  # calee can use freely $t0-$t9, $a0-$a3, $v0-$v1
    
  ############################################################
  # Purpose:  To return the sum of squares of the input
  # Arguments: $a0-$a2 <-- The input integers
  # Returns:  $v0 <-- The sum of squares of the input integers
  ############################################################
  sumOfSquares:
  
    add $t0, $zero, $zero 
    
    # save the return address to the stack
    # also $a0, $a1, $a2, $t0 used in this method
    # --> By convention, they could be changed when
    #     we call the square method
    sub $sp, $sp, 20
    sw $ra, 16($sp)
    sw $a0, 12($sp)
    sw $a1, 8($sp)
    sw $a2, 4($sp)
    sw $t0, 0($sp)

    # Find $a0^2   
    # $a0 already contains the value we want to square
    # call square; $a0^2 is returned in $v0
    jal square
    
    #restore $t0 from the stack since it could have changed
    lw $t0, 0($sp)
    
    #add $v0 to $t0 so $t0 = $a0^2
    add $t0, $zero, $v0
    
    #save $t0 back to the stack (at its same stack location)
    sw $t0, 0($sp)
    
    # Find $a1^2  
    # Get $a1 from the stack and put it in $a0 
    # call square; $a1^2 is returned in $v0
    lw $a0, 8($sp)
    jal square
    
    #restore $t0 from the stack since it could have changed
    lw $t0, 0($sp)
    
    #add $v0 to $t0 so $t0 = $a0^2 + $a1^2
    add $t0, $t0, $v0
    
    #save $t0 back to the stack (at its same stack location)
    sw $t0, 0($sp)
    
    # Find $a2^2  
    # Get $a2 from the stack and put it in $a0 
    # call square; $a2^2 is returned in $v0
    lw $a0, 4($sp)
    jal square
    
    #restore $t0 from the stack since it could have changed
    lw $t0, 0($sp)
    
    #add $t0 to $v0 so $v0 = $a0^2 + $a1^2 + a2^2
    #since we want the final answer to be returned in $v0
    add $v0, $t0, $v0
              
    # restore the return address from the stack
    # remove the stack frame (all values pushed to the stack
    # by this function) from the stack
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra

  ############################################################
  # Purpose:  To return the square of the input
  # Arguments: $a0 <-- The input integer
  # Returns:  $v0 <-- The square of the input integer
  ############################################################
  square:
    #Compute $a0^2, saving the result in $v0
    mul $v0, $a0, $a0
    
    #By convention, this function could also modify $a0-$a3, 
    #$t0-$t9, $v1. To make sure sumOfSquares is using the stack 
    #properly, modify these registers before returning.
    addi $a0, $zero, 999
    addi $a1, $zero, 999
    addi $a2, $zero, 999
    addi $a3, $zero, 999
    addi $t0, $zero, 999
    addi $t1, $zero, 999
    addi $t2, $zero, 999
    addi $t3, $zero, 999
    addi $t4, $zero, 999
    addi $t5, $zero, 999
    addi $t6, $zero, 999
    addi $t7, $zero, 999
    addi $t8, $zero, 999
    addi $t9, $zero, 999
    addi $v1, $zero, 999
    jr $ra
  
.data
    answer:  .asciiz "\nSum of Squares:  "
    newLine: .asciiz "\n"
    prompt:  .asciiz "\nEnter an integer:  "
    values:  .word 0:3
