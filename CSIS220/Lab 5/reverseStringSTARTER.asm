# File Name:  reverseStringSTARTER.asm
# Author:  Saif Ullah, Anthony Russo, and Collin McDonough
# Version:  
# Purpose:  To use the stack to reverse a string
#           input by the user.
.text
main: 
    # $s0 <-- buffer
    # $s1 <-- character pushed or popped
    # $s2 <-- temporary pointer to the buffer
    
    # prompt the user for a string
    addi $v0, $zero, 4
    la $a0, prompt
    syscall
    
    # input the string into the buffer
    lw $t0, bufferSize
    addi $v0, $zero, 8
    la $a0, buffer
    add $a1, $zero, $t0
    syscall
    
    # initialize the stack by
    # pushing a null value to signal 
    # the bottom of the stack
    sub $sp, $sp, 4
    sb $zero, 0($sp)
        
    # $s0 <-- buffer
    # $s2 <-- buffer
    la $s0, buffer 
    la $s2, buffer 

    # push each character onto the stack
beginPushLoop:

    # $s1 <-- the next character in the buffer
    lb $s1, ($s2)
    
    # while we have not reached the end of the string
    beq $s1, $zero, endPushLoop
    
    # push the character onto the stack
    sub $sp, $sp, 4
    sb $s1, 0($sp)
           
    # $s2 <-- the next character in the buffer
    addi $s2, $s2, 1
    
    j beginPushLoop  
    
endPushLoop:    
  
    # $s2 <-- the beginning of the buffer
    add $s2, $zero, $s0
      
    # pop chars from stack back into the buffer    
beginPopLoop:
      
    # $s1 <-- pop a character from the stack
    lb $s1, ($sp)
    addi $sp, $sp, 4
      
    # while we have not reached the bottom of the stack
    beq $s1, $zero, endPopLoop
      
    # store the string in the buffer
    sb $s1, ($s2)

    # go to the next place in the buffer
    addi $s2, $s2, 1

    j beginPopLoop           

endPopLoop:
  
    # print the reversed string
    li $v0, 4        
    la $a1, buffer
    syscall

    # end program
endProgram:
    li $v0, 10
    syscall   
    
.data
    buffer:      .byte ' ':128
    bufferSize:  .word 128
    prompt:      .asciiz "Enter a string:  "       
