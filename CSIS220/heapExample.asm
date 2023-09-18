# File:  HeapExample.asm
# Author:  Prof. White
# Version: Fall 2021
# Purpose:  Allocate two blocks of memory, 
#           put the integers 77 and 78 into it,
#           print out the integers.
.text
main:     
    # Allocate two blocks of memory
    # 8 bytes long in the heap segment
    # $v0 <-- the top of the heap
    addiu $v0, $zero, 9    
    addiu $a0, $zero, 8    
    syscall                
    
    # Save the pointer to the heap in $s0
    add $s0, $zero $v0     
        
    # Store value 77 on the heap
    addi $s1, $zero, 77              
    sw $s1, 0($s0)
    
    # Store the value 78 on the heap
    addi $s1, $s1, 1
    sw $s1, 4($s0)
        
    # Get the values on the heap
    # and print them
    addiu $v0, $zero, 1             
    lw $a0, 0($s0)         
    syscall           
    addiu $v0, $zero, 4
    la $a0, space
    syscall
    addiu $v0, $zero, 1             
    lw $a0, 4($s0)
    syscall    

    # End the program
    addiu $v0, $zero, 10   
    syscall 
    
.data
    space: .asciiz " "      
