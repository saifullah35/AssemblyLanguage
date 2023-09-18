# File Name: mSet.asm
# Author:  Jonathan Masih , Saif Ullah 
# Version:  Fall 2021
# Purpose:  Get's the user to enter values to put in a array stoped by -1
#           then finds the consecutive entries, where the difference is m 
#           Entered by the user 
.text
main:

## Testing getIntegerArray
la $a0 , values
jal getIntegerArray
addi $s1 , $v0 , 0   #length of the values array
sw $s1 , valuesLength
#Getting stepSize


addi $v0, $zero, 4
la $a0 , promptForStepSize
syscall
addi $v0, $zero, 5
syscall
addi $s0 , $v0 , 0   # getting the step size and puts in $s0
#add a new line
addi $v0, $zero, 4
la $a0 , newLine
syscall

#Calling printing sets
la $a0, values
la $a1, ($s1)
la $s0 , valuesLength
lw $a2, ($s0)
jal printSets
move $s2, $v0

#printing number of sets
addi $v0, $zero, 4
la $a0 , promptForNumberOfSets
syscall
addi $v0, $zero, 1
la $a0 , ($s2)
syscall


  
# End program
endProgram:
    addiu $v0, $zero, 10
    syscall



###################################################################
# Function: getIntegerArray
# Purpose: Prompts the user to enter integer values or -1 to stop.
# Adds the values, in order, to the input array.
# Arguments: $a0 <-- The address of the first value in the array.
# Returns: $v0 <-- The number of integers entered into the array.
###################################################################
getIntegerArray: 
la $t0 , ($a0)    #$t0 address of the first value in the array.
addi $t1 , $zero, 0 #number of integers entered. 


addi $v0, $zero, 4
la $a0, promptForArray
syscall
addi $v0, $zero, 4
la $a0 , newLine
syscall

loopToFillArray:
addi $v0, $zero, 5
syscall
sw $v0, ($t0)
beq $v0 , -1 , return
addi $t1 , $t1 , 1
addi $t0 , $t0 , 4


j loopToFillArray


return:
addi $v0, $zero, 4
la $a0 , newLine
syscall
addi $v0 , $zero , 0
move $v0, $t1 
jr $ra

###################################################################
# Function: printSets
# Purpose: Prints sets of values from the array where the distance
# between consecutive values in the set is equal to the
# step size.
# Arguments: $a0 <-- The address of the first value in the array.
# $a1 <-- The number of values entered into the array.
# $a2 <-- The step size.
# Returns: $v0 <-- The number of sets printed.
###################################################################

printSets:
#$t0 <-- $a0; address of the array
#starts at second value
la $t0,($a0)
addi $t0 , $t0 ,4
#Step size
move $t1 , $a2
#loop Variable 
addi $t2 , $zero , 0
#Register for keeping count of Sets Printed 
addi $t3 , $zero , 0
#Register for checking the difference of values 1st pointer and 2nd pointer
addi $t4 , $t4 , 0

printLoop:

beq $t2, $a1, return2
subi $t0, $t0, 4
#value at first pointer
lw $t5, ($t0)
#value at second pointer
addi $t0, $t0, 4
lw $t6, ($t0)
#finding the difference between the two pointer values
sub $t4, $t5, $t6
blt $t4, 0, posDifference
mul $t4, $t4, -1

posDifference:
bne $t4, $t1, else 
subi $t0, $t0, 4    # if difference = stepSize, it prints
addi $v0, $zero, 1
la $a0 , ($t0)
syscall
j jumpBackToLoop
    
else:
subi $t7, $t7, 2
ble $t7, $t0, jumpBackToLoop
subi $t0, $t0, 8
lw $t5, ($t0)
addi $t0, $t0, 4
lw $t6, ($t0)
sub $t4, $t5, $t6
blt $t4, 0, posDifference2
mul $t4, $t4, -1

posDifference2:
bne $t4, $t1, jumpBackToLoop
addi $v0, $zero, 1
la $a0 , ($t0)
syscall
addi $t3, $t3, 1
addi $v0, $zero, 4
la $a0 , newLine
syscall

jumpBackToLoop:
addi $t0, $t0, 8
addi $t2, $t2, 1
j printSets

return2:
mul $t7, $a1, 4
la $t0, ($a0)
add $t0, $t0, $t7
lw $t5, ($t0)
subi $t0, $t0, 4
lw $t6, ($t0)
sub $t4, $t5, $t7
blt $t4, 0, posDifference3
mul $t4, $t4, -1

posDifference3:
bne $t4, $t1, return3
addi $t1, $t1, 4 
addi $v0, $zero, 1
la $a0 , ($t0)
syscall
addi $t3, $t3, 1

return3:
addi $v0 , $zero , 0
move $v0, $t1 
jr $ra


.data 
       values: .word 0:50
       valuesLength: .byte 0
       newLine: .asciiz "\n"
       promptForArray: .asciiz "Enter the intergers or -1 to stop"
       promptForStepSize: .asciiz "Enter the step size: "
       promptForNumberOfSets: .asciiz "Number of sets printed: "
