# Program File:  Example5.asm
# Author: Adam Leonard & Saif Ullah
# Version: Fall 2021
# Purpose: To take in a lower bound and upper bound and a third integer, x, and print all of the multiples of x within
#the bounds
.text

main: 	
    #Prompts for the lower bound
    ori $v0, $zero, 4
    la $a0, LowerBound
    syscall
    ori $v0, $zero, 5
    syscall
    or $s0, $zero, $v0
    
    #Promts for the Upper Bound
    ori $v0, $zero, 4
    la $a0, UpperBound
    syscall
    ori $v0, $zero, 5
    syscall
    or $s1, $zero, $v0
    
    #Prompts for X
    ori $v0, $zero, 4
    la $a0, X
    syscall
    ori $v0, $zero, 5
    syscall
    or $s2, $zero, $v0
    
    #Printing for the multiples
    ori $v0, $zero, 4
    la $a0, Final
    syscall
    
    ori $v0, $zero, 1
    add $a0, $s2, $zero
    syscall
    
    ori $v0, $zero, 4
    la $a0, In
    syscall
    
    ori $v0, $zero, 1
    add $a0, $s0, $zero
    syscall
    
    ori $v0, $zero, 4
    la $a0, comma
    syscall
    
    ori $v0, $zero, 1
    add $a0, $s1, $zero
    syscall
    
    ori $v0, $zero, 4
    la $a0, Brack1
    syscall
    

    #Temp variable
    add $t7, $s0, $zero
loop:
    ble $t7, $s1, body
    j end
    
body:
    div $t0, $t7, $s2
    mfhi $t1
    beq $t1, $zero, printMultiple
    add $t7, $t7, 1
    
    j loop

printMultiple:
    ori $v0, $zero, 1
    add $a0, $zero, $t7
    syscall
    
    ori $v0, $zero, 4
    la $a0, space
    syscall

    add $t7, $t7, 1
    j loop

end:
    ori $v0, $zero, 10
    syscall

.data
    UpperBound:  .asciiz "Enter the upper bound:  "
    LowerBound:  .asciiz "\nEnter the lower bound:  "
    X: .asciiz "Enter x: "
    Final: .asciiz "\nThe multiples of "
    In: .asciiz " in ["
    comma: .asciiz ", "
    Brack1: .asciiz "] are : "
    space: .asciiz " "	
