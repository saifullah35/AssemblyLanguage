# File:  stringPattern.asm
# Author:  Saif Ullah & Spencer Moon
# Version:  
# Purpose:  Print the number of A's before the letter B and number
#           of C's after the letter B. This number depends on what the user 
#           enters and must be greater than 0

.text

main:
	#Prompts the user for an integer greater than 0
	promptLoop:
		addi $v0, $zero, 4
		la $a0, prompt
		syscall
		
		addi $v0, $zero, 5
		syscall
		
		add $s0, $v0, $zero
		
		bgtz $s0, printPattern
		
		addi $v0, $zero, 4
		la $a0, errorMessage
		syscall
		
		j promptLoop
		
	#Calls the pattern function
	printPattern:
		add $a0, $s0, $zero
		jal pattern
	
	#Ends the program
	endProgram:
	addi $v0, $zero, 10
	syscall

################################################################
#   Function:  pattern
#    Purpose:  prints a pattern
#    Arguments:  $a0 <-- n
# Return value:  none
################################################################
pattern:
	
	#Checks if the base case condition has been met
	blez $a0, baseCase
	
	#Saves n in $t0
	add $t0, $a0, $zero
	
	#Print A
	addi $v0, $zero, 4
	la $a0, letterA
	syscall
	
	j recursiveCase
	
	#The base case when n = 0
	baseCase:
		#Print B
		addi $v0, $zero, 4
		la $a0, letterB
		syscall
		jr $ra
	
	#The recursive case when n > 0
	recursiveCase:
		addi $a0, $t0, -1
		addi $sp, $sp, -4
		sw $ra, ($sp)
		jal pattern
		
		#Print C
		addi $v0, $zero, 4
		la $a0, letterC
		syscall
	
	#Returns
	return:
		lw $ra, ($sp)
		addi $sp, $sp, 4
		jr $ra

.data
	prompt: .asciiz "Enter a value for n: "
	errorMessage: .asciiz "\nError: n must be greater than 0\n"
	letterA: .asciiz "A"
	letterB: .asciiz "B"
	letterC: .asciiz "C"
	

