# Program File:  Example4.asm
# Author: Adam Leonard & Saif Ullah
# Version: Fall 2021
# Purpose: To demonstrate the implementation of a while loop using method 2 of lab 3.
.text

main:
    # Instead of reading in values for a, b, and c from the user,
    # we will "initialize these variables" in .data and then
    # load them into the registers.
    # $t0 <-- a; $t1 <-- b; $t2 <-- c
    lw $t0, a
    lw $t1, b
    lw $t2, c
    
    # method 2
loop:
    bgt $t0, $t2, end 
    addi $t0, $t0, 3    # while (a <= c) go to body of loop
    j loop              # goto end of loop
         
end:
    add $t1, $t1, $t0   # b = b + a
    
    # print a, b, c
    addi $v0, $zero, 4
    la $a0, output
    syscall
    addi $v0, $zero, 1
    add $a0, $zero, $t0 # a
    syscall
    addi $v0, $zero, 4
    la $a0, space
    syscall
    addi $v0, $zero, 1
    add $a0, $zero, $t1 # b
    syscall
    addi $v0, $zero, 4
    la $a0, space
    syscall
    addi $v0, $zero, 1
    add $a0, $zero, $t2 # c
    syscall
    
    # End program
    addi $v0, $zero, 10
    syscall
    
.data
    a:  .word 1
    b:  .word 5
    c:  .word 10
    output:  .asciiz "a, b, c:  "
    space: .asciiz " "
