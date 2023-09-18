# File Name:  reverseStringSTARTER.asm
# Author:  Saif Ullah, Anthony Russo, and Collin McDonough
# Version:  
# Purpose:  To copy the values in another array and print the array in reverse
.text
main: 
    # $a0 <--length of the array
    # $a1 <-- address of the array
    lw $a0, arrayLength
    la $a1, array
    jal printArray
      
newSpace:
    addi $v0, $zero, 4
    la $a0, newLine
    syscall
    
endOfArray:
    # $s0 <--length of the array
    # $s1 <-- address of the array
    lw $s0, arrayLength
    la $s1, array
    mul $s5, $s0, 4
    mflo $s5
    add $s2, $s1, $s5
    subi $s2, $s2, 4
    
    # $s4 <-- address of the array
    la $s3, revArray
    add $s4, $s3, $s5
    subi $s4, $s4, 4
    
beginSwap:
    blt $s2, $s1, endSwap

    # swap values at $s1 and $s2 
    lw $s6, ($s2) 
    lw $s7, ($s1) 
    sw $s7, ($s4) 
    sw $s6, ($s3) 
    
    # move pointers in 
    addi $s1, $s1, 4 
    subi $s2, $s2, 4
    addi $s3, $s3, 4 
    subi $s4, $s4, 4 
  
    j beginSwap 
    
endSwap: 
   #Print the reversed array and a newline. 
    la $a1, revArray 
    add $a0, $zero, $s0  
    jal printArray


endProgram2: 
     addi $v0, $zero, 10 
     syscall 

###########################################################
# Function Name: printArray
# Purpose: To print the numbers in the array given.
#
# Arguments: $a0 address of the array
#            $a1 length of array
###########################################################
printArray:
    addi $t0, $zero, 0
    add $t1, $zero, $a1
    
beginLoop:
    beq $t0, $a0, endLoop
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    j beginLoop
    
endLoop:
    add $t1, $zero, $a1
    addi $t2, $zero, 0
    
begPrintLoop:
    beq $t2, $t0, endProgram
    lw $a0, ($t1)
    addi $v0, $zero, 1
    syscall
    addi $v0, $zero, 4
    la $a0, space
    syscall
    addi $t2, $t2, 1
    addi $t1, $t1, 4
    j begPrintLoop
    
endProgram:
    jr $ra

.data
      array:         .word 1,2,3,4,5,6,7
      revArray:      .word -1:7
      arrayLength:   .word 7
      newLine:      .asciiz "\n"
      space:        .asciiz " "