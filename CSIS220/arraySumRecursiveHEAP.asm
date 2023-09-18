# File:     arraySumRecursiveStatic.asm
# Purpose:  To print the array stored in static memory (.data),
#           find its sum recursively, and print the sum.
# Author:   Trevor Collins, Saif Ullah
# Version:  Fall 2021
.text
main:

    #Allocate 20 bytes long in the heap segment
    # $v0 <-- the top of the heap
    addiu $v0, $zero, 9  
    lb $a0, offset
    syscall
    add $s1, $zero, $v0
    # Save the pointer to the heap in $s2
    add $s2, $zero, $s1
    
    #Storing array values in heap
    addi $s0, $zero, 1
    sw $s0, 0($s2)
    addi $s0, $s0, -3
    sw $s0, 4($s2)
    addi $s0, $s0, 5
    sw $s0, 8($s2)
    addi $s0, $s0, 1
    sw $s0, 12($s2)
    addi $s0, $s0, -9 
    sw $s0, 16($s2)
    addi $s0, $s0, 14
    sw $s0, 20($s2)
    
    
    
  # find the sum of the array recursively
  add $a0, $zero, $s1
  lb $a1, offset
  add $a1, $a1, $a0
  jal sumArrayRecursive
  
  # save the sum
  add $s0, $zero, $v0
  # print the array
  addiu $v0, $zero, 4
  la $a0, arrayLabel
  syscall

 # la $a0, array
  add $a0, $zero, $s2
  lb $a1, offset
  add $a1, $a1, $a0
  jal printArray
  
  # print the sum
  addiu $v0, $zero, 4
  la $a0, sumLabel
  syscall
  addiu $v0, $zero, 1
  add $a0, $zero, $s0
  syscall
  
  # end program
  addiu $v0, $zero, 10
  syscall
  
  ########################################################
  # Function:  sumArrayRecursive
  # Purpose:  To return the sum of the array found
  #           recursively
  # Arguments:  $a0 <-- the address of the first element 
  #                     in the array
  #             $a1 <-- the address of the last element 
  #                     in the array
  # Return values:  $v0 <-- the sum of the array elements
  ########################################################
sumArrayRecursive:
    addi $sp, $sp, -16
    lw $t0, ($a0)
    sw $t0, -12($sp) # the value to add
    sw $a0, -8($sp)
    sw $a1, -4($sp)
    sw $ra, 0($sp)
    
    # base case:
    # if no elements in array, sum = array[$a0]
    lw $v0, ($a0)
    beq $a0, $a1, return
    
    # if elements in array, 
    # recursive step - move closer to the base case
    addi $a0, $a0, 4		
    jal sumArrayRecursive	

    # compute sum
    # $v0 <-- $v0 + element
    lw $a0, -12($sp)
    add $v0, $v0, $a0

return:
    # Restore the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    lw $ra, 0($sp)              
    addi $sp, $sp, 16
    jr $ra		
    
  #####################################################
  # Function:  printArray
  # Purpose:  To print an array of values
  # Arguments:  $a0 <-- the address of the first element 
  #                     in the array
  #             $a1 <-- the address of the last element 
  #                     in the array
  # Return values:  None
  #####################################################
printArray:
    add $t0, $zero, $a0
    
beginPrintLoop:
    bgt $t0, $a1, endPrintArray
    addiu $v0, $zero, 1
    lw  $a0, ($t0)
    syscall
    addiu $v0, $zero, 4
    la $a0, space
    syscall
    addiu $t0, $t0, 4
    j beginPrintLoop
    
endPrintArray:
    jr $ra
 
 .data
               #sum = 10
  # array:      .word 1, -2, 3, 4, -5, 9
   arrayLabel: .asciiz "\narray:  "
   offset:     .byte 20
   space:      .asciiz " "
   sumLabel:   .asciiz "\nsum:  "
