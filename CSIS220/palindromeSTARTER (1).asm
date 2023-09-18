# File Name:  palindromeSTARTER.asm 
# Author:     Saif Ullah and Juan Acosta
# Version:    October 28, 2021
# Purpose:    Prompt the user for a single character and a string.
#             If the user enters more than a single character, use
#             only the first character.
#             Print found if the character appears in the string
#             and not found otherwise.
.text
main:
    
    # $s2 <-- input character
    la $s2, buffer
    lb $s2, ($s2)
    
    # Prompt user for string input
    addi $v0, $zero, 4
    la $a0, prompt
    syscall
    
    # Read the string plus terminator into the buffer
    addi $v0, $zero, 8
    la $a0, buffer
    addi $a1, $zero, 100
    syscall
    
    # We do not know how many characters are in the string the user entered.
    # Locate the end of the string the user entered
    # $s0 <-- the address of the base of array
    # $s1 <-- the address of the base of array; 
    #         temporary used to traverse the array
    la $s0, buffer 
    la $s1, buffer 
    
    
findEndStrLoop:
    # $t0 <-- next character
    # if we are at the terminator, end loop
    # otherwise, go to the next character and continue loop
    lb $t0 ,($s1)  
    beq $t0, 10, findEndStrLoopEnd 
    addi $s1, $s1, 1 
    j findEndStrLoop
    
findEndStrLoopEnd:
    # Move the pointer back to the last character; 
    # do not include the new line character
    # $s0 <-- the address of the base of array
    # $s1 <-- the address of the last character in the array
    addi $s1, $s1, -2
    
    # Look for character in the input string
    # $t1 <-- 0; found = false
    # $t2 <-- current index i
    # t3 <-- inputString[0]
    li $t1, 0            
    add $t2, $zero, $s0  
    lb $t3, ($t2)
    
    add $s1, $s1, 1
    blt $s1, $t2, endIsNotAPalindrome 
   

loop:
    # if we have reached the end of the string, end loop not found
    # otherwise, $t1 <-- 1 if found and 0 otherwise
    #            if found end loop
    #            otherwise, $t2 <-- the address of the next char in input string
    #                       $t3 <-- inputString[i]
    #                       continue loop
    
    lb $t6, ($s1)
    lb $t7, ($s0)
    bne $t6, $t7,endIsNotAPalindrome 
    #Goes to the next character in array  
    addi $s0, $s0, 1
    #Goes to the previous character in array
    sub $s1, $s1, 1
    ble $s1, $s0, endIsAPalindrome          
    lb $t3, ($t2)                
    j loop
    
endIsAPalindrome:
    la $a0, IsAPalindrome
    j endProgram
    
endIsNotAPalindrome:
    la $a0, IsNotAPalindrome
    
endProgram:
    addi $v0, $zero, 4
    syscall
    addi $v0, $zero, 10
    syscall
    
.data
    # space for 100 characters max plus terminator
    # each initialized to null
    buffer:     .byte 0x0:101     
    IsAPalindrome:      .asciiz "\nIs a palindrome\n"
    promptChar: .asciiz "Enter a single character:  "
    prompt:     .asciiz "\nEnter a string of no more than 100 characters:  "
    IsNotAPalindrome:   .asciiz "\nNot a palindrome\n"
