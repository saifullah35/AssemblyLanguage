# File Name: recursivePrintPattern.asm
# Author:  Jonathan Masih , Saif Ullah 
# Version:  Fall 2021
# Purpose:  Recursively prints the specified pattern for the given
#           input by the user.
.text
main:

# getting the  length and puts in $s0
li $v0,  4
la $a0 , promptForLength
syscall
li $v0, 5
syscall
addi $s0 , $v0 ,0   

#getting the Height and puts in $s1
li $v0, ,4
la $a0 , promptForHeight
syscall
addi $v0, $zero, 5
syscall
addi $s1 , $v0 ,0   
#add one to height so loop varible can start at 1 
#and print loop vaible for height 
addi $s3 , $s1 , 1

#Loop to print the patterns for each Height
addi $s2 , $zero , 1 #loop vaieble
#print loop
patternPrintLoop:
beq $s2 , $s3, patternsPrinted
#print word height and then call  printPattern
li $v0, ,4
la $a0 , Height
syscall
li $v0, ,1
addi $a0 , $s2 , 0
syscall
li $v0, ,4
la $a0 , newLine
syscall
move $a0 , $zero
move $a1 , $zero
move $a2 , $s0
move $a3 , $s2
jal printPattern
addi $s2 , $s2 ,1
j patternPrintLoop
patternsPrinted:

# End program
endProgram:
    addiu $v0, $zero, 10
    syscall



###################################################################
# Function: printPattern
# Purpose: Recursively prints the specified pattern for the given
# inputs.
# Arguments: $a0 <-- The current column to print.
# $a1 <-- The current row to print.
# $a2 <-- The number of columns in the completed pattern
# (the length).
# $a3 <-- The number of rows in the completed pattern
# (the width).
# Returns: nothing
###################################################################
printPattern:
#storing return address of main and current 
addi $sp , $sp , -4
sw $ra , 0($sp)
#base case
beq $a1 , $a3 , return

#if current row to print is less then number of rows in
#in the completed pattern / 2
# print pattern \\// else print pattern //\\
div $t0 , $a3 , 2
mflo $t0
bge $a1 , $t0 , PrintOtherPattern 
beq $a0 , $a2 , printNewLine             #check if col completed and then prints newLine and increments the row
div $t1 , $a2 , 2
mflo $t1
bge $a0 , $t1, printForwardSlash
add $t2 , $zero , $a0        #before print storing $a0 into $t2
li $v0 ,4
la $a0 ,backSlash
syscall
add $a0 , $zero , $t2        #restoring $a0 before print
addi $a0 , $a0 , 1  # Increment current col to print
j recursiveCall

printForwardSlash:
add $t2 , $zero , $a0    #before print storing $a0 into $t2
li $v0,4
la $a0 ,forwardSlash
syscall
add $a0 , $zero , $t2        #restoring $a0 before print
addi $a0 , $a0 , 1  # Increment current col to print
j recursiveCall


printNewLine:
li $v0, 4
la $a0 , newLine
syscall
addi $a1 , $a1 ,1
addi $a0 , $zero , 0
j recursiveCall

PrintOtherPattern:
beq $a0 , $a2 , printNewLine2            #check if col completed and then prints newLine and increments the row
div $t1 , $a2 , 2
mflo $t1
bge $a0 , $t1, printBacklash
add $t2 , $zero , $a0        #before print storing $a0 into $t2
li $v0 ,4
la $a0 ,forwardSlash
syscall
add $a0 , $zero , $t2        #restoring $a0 before print
addi $a0 , $a0 , 1  # Increment current col to print
j recursiveCall

printBacklash:
add $t2 , $zero , $a0    #before print storing $a0 into $t2
li $v0,4
la $a0 ,backSlash
syscall
add $a0 , $zero , $t2        #restoring $a0 before print
addi $a0 , $a0 , 1  # Increment current col to print
j recursiveCall


printNewLine2:
li $v0, 4
la $a0 , newLine
syscall
addi $a1 , $a1 ,1
addi $a0 , $zero , 0
j recursiveCall



recursiveCall:
jal printPattern
return:  
lw $ra, 0($sp)    
addi $sp, $sp, 4        
jr $ra	

.data 
promptForLength: .asciiz "What length should be used? "
promptForHeight: .asciiz "What maximum height should be used? "
Height: .asciiz "Height "
newLine: .asciiz "\n"
backSlash: .asciiz "\\"
forwardSlash: .asciiz "/"
