# File Name: upperFollowsLower.asm.
# Author:  Jonathan Masih , Saif Ullah 
# Version:  Fall 2021
# Purpose:  Makes an char array filled with random upppercase
#           and lowercase letters, then checks how many times 
#           there is a lowercase letter Followed by an Uppercase letter
.text
main:
#Calling getRandomCharArray
la $a0 , charsArray
la $a1 , lengthCharsArray
jal getRandomCharArray

#printing out the array
addi $t0, $zero, 1  #loop variable
lw $t1, lengthCharsArray
la $t2, charsArray   #pointer for the array
#printing out first bracket
li $v0, 4
la $a0, firstBracket
syscall

arrayPrintLoop:
beq $t0, $t1, arrayPrinted
li $v0, 11
lb $a0, ($t2)
syscall
li $v0, 4
la $a0, comma
syscall
addi $t0, $t0, 1
addi $t2, $t2, 1
j arrayPrintLoop

arrayPrinted:
li $v0, 11
lb $a0, ($t2)
syscall
li $v0, 4
la $a0, secondBracket
syscall

#Calling countUpperFollowsLower
la $a0 , charsArray
li $a1 , 0
lw $s0 , lengthCharsArray
#subi $s0 , $s0 , 1  # sub 1 from length not to reach index out of bound

move $a2, $s0
move $v0 , $zero
jal countUpperFollowsLower
move $s1 , $v0            # storing retunr value in $s1
#Printing countUpperFollowsLower return value
li $v0 , 4 
la $a0 , upperFollowsLower
syscall
li $v0 , 1
la $a0 , ($s1)
syscall


endProgram:
    addiu $v0, $zero, 10
    syscall



###################################################################
# Function: getRandomCharArray
# Purpose: Fills an ASCII character array of the specified
# length. Each entry in the array is a random ASCII
# character in [a � z, A � Z] chosen with equal
# probability.
# Arguments: $a0 <-- The address of the first value in the array.
# $a1 <-- The length of the array.
# Returns: nothing
###################################################################
getRandomCharArray:

# $t0<----$a0 The address of the first value in the array.
# $t0 temporary pointer
# $t1<----$a1 The length of the array.
la $t0 , ($a0)
lw $t1 , ($a1)
# $t2 loop variable  
addi $t2 , $t2 , 0

fillArrayLoop:

beq $t2 , $t1 , arrayFilled
addi $a0, $zero, 3
addi $a1, $zero, 25
addi $v0, $zero, 42
syscall
#generating random number from 1-26 and putting it in $t3
addi $t3, $a0, 0
#store lowercase letters in $t4
addi $t4, $t3, 97
#store uppercase letters in $t5
addi $t5, $t3, 65

#generate a number from 0-1; 1=lowercase and 0=uppercase 
addi $a0, $zero, 3
addi $a1, $zero, 2
addi $v0, $zero, 42
syscall
beq $a0, $zero, upperCaseLetter
sb $t4, ($t0)
addi $t0, $t0, 1
addi $t2, $t2, 1
j fillArrayLoop

upperCaseLetter:
sb $t5, ($t0)
addi $t0, $t0, 1
addi $t2, $t2, 1
j fillArrayLoop

arrayFilled:
jr $ra




###################################################################
# Function: countUpperFollowsLower
# Purpose: Recursively returns the number of times an uppercase
# ASCII character immediately follows a lowercase ASCII
# character in the input array.
# Arguments: $a0 <-- The address of the first value in the array.
# $a1 <-- The current index into the array.
# $a2 <-- The length of the array.
# Returns: $v0 <-- The number of times an uppercase ASCII character
# immediately follows a lowercase ASCII character in the
# input array.
###################################################################
countUpperFollowsLower:
#storing return address of main
addi $sp , $sp , -4
sw $ra , 0($sp)
move $t1 , $a2
subi $t2 ,$t1  , 1
beq $a1 , $t2 , return
lb $t0 , ($a0)   # $t0 register for storing elements from a array to check

#Check if lowercasr or uppercase
bgt $t0 , 90 , lowerCase
j jumploop

lowerCase:
addi $a0 , $a0 ,1 # if lowercase letter then check the next one if it is UpperCase
lb $t0 , ($a0)
subi $a0 , $a0 , 1 
bgt $t0 , 90 , jumploop  #next char is also lower
addi $v0 , $v0, 1    # next char is uppercase then add $v0 1 to counter

jumploop:
addi $a0 , $a0 , 1
addi $a1 , $a1 , 1
jal countUpperFollowsLower

return:  
lw $ra, 0($sp)    
addi $sp, $sp, 4        
jr $ra	

.data 
	charsArray: .byte 0:25
	lengthCharsArray: .word 25
	firstBracket: .asciiz "["
	secondBracket: .asciiz "]"
	comma: .asciiz ", "
	upperFollowsLower: .asciiz "\nCount of upper follows lower: "
