# File:	utilsSTARTER.asm
# Author:  Prof. White
# Modified by:   Jonathan Masih and Saif Ullah
# Version:  Fall 2021
#
# Subprogram Index
#    utilEndProgram - Call syscall with a server 10 to exit the program
#    utilPrintNewLine - Print a new line character (\n) to the console
#    utilPrintInt - Print a string with an integer to the console
#    utilPrintString - Print a string to the console
#    utilPromptInt - Prompt the user with a given string, read integer and return it
#    utilPrintSpace - Prints a single space to the console
################################################################
# Subprogram:  utilEndProgram
# Purpose:  exits the program with service 10
# Arguments:  none
# Return values: none
################################################################
.text
  utilEndProgram:
    addiu $v0, $zero, 10
    syscall

################################################################
# Subprogram:  utilPrintNewLine
# Purpose:  prints a newline to the console
# Arguments:  none
# Return values: none
################################################################
.text
  utilPrintNewLine:
    addiu $v0, $zero, 4
    la $a0, newline
    syscall 
    jr $ra
.data
   newline:   .asciiz "\n"

################################################################
# Subprogram:  utilPrintInt
# Purpose:  prints the input integer to the console
# Arguments:  $a0 <-- The integer to be printed
# Return values: none
################################################################
.text
  utilPrintInt: 
    addiu $v0, $zero, 1
    syscall
    jr $ra

################################################################
# Subprogram:  utilPrintString
# Purpose:  prints the input string to the console
# Arguments:  $a0 <-- the address of the string to be printed
# Return values: none
################################################################
.text
  utilPrintString: 
    addiu $v0, $zero, 4
    syscall
    jr $ra
    
################################################################
# Subprogram:  utilPromptInt
# Purpose:  prompts the user for an integer, reads in the integer,
#           and returns the integer
# Arguments:  $a0 <-- the address of the string to be printed
# Return values: $v0 <-- the integer entered by the user
################################################################
.text
  utilPromptInt: 
    addiu $v0, $zero, 4
    syscall
    addiu $v0, $zero, 5
    syscall
    jr $ra            
    
################################################################
# Subprogram:  utilPrintSpace
# Purpose:  Prints a single space to the console
# Arguments:  $a0 <-- the address of the space to be printed
# Return values: 
################################################################
.text
  utilPrintSpace: 
    addiu $v0, $zero, 4
    la $a0 , space
    syscall
    jr $ra            
    .data 
    space: .asciiz " "
        
    
    
