# File Name:  Sum of Squares
# Author:  Jonathan Masih , Saih Ullah 
# Version:  Fall 2021
# Purpose:  Fills an array with 1,000 integers and then 
#           gets the number of intergers that are diviable 
#           by 1, 2, 3, ... 10 and then prints then
.text
main:


## Calling  fillRandomIntegers
la $a0 , values
la $a1 , valuesLength
jal fillRandomIntegers


### TESTING getFrequencies
#la $a0 , testArray
#lw $a1,  testaeeaylength 
#la $a2 , frequenciesArray
#lw $a3, frequenciesArraylength
#jal getFrequencies

#Calling the getFrequency function with arguments
la $a0 , values
lw $a1,  valuesLength

la $a2 , frequenciesArray
lw $a3, frequenciesArraylength

jal getFrequencies

#Print the final results
la $a0, frequenciesArray
lw $a1,  frequenciesArraylength

jal printFrequencies

# End program
endProgram:
    addiu $v0, $zero, 10
    syscall
     
###################################################################
# Function: fillRandomIntegers
# Purpose: Fill an array with random integers in [1, 100].
# Arguments: $a0 <-- The address of the first value in the array.
# $a1 <-- The length of the array.
# Returns: nothing
###################################################################    
fillRandomIntegers:
# $t0<----$a0 The address of the first value in the array.
# $t0 temporary pointer
# $t1<----$a1 The length of the array.
la $t0 , ($a0)
lw $t1 , ($a1)
# $t2 loop variable  
addi $t2 , $t2 , 0

fillArrayLoop:

beq $t2 , $t1 , arrayFilled
addi $a0, $zero, 3 # 3 is the seed; could be any integer
addi $a1, $zero, 99
addi $v0, $zero, 42
syscall
#$t3 ? random integer in [1, 100]
addi $t3, $a0, 1
sw $t3 , ($t0)
#incrment $t0 to next avaible space 
addi $t0 , $t0 , 4
addi $t2 , $t2 , 1

j fillArrayLoop
#Once the array is filled jump back to jal + 4 @ main
arrayFilled:
jr $ra



###################################################################
# Function: getFrequencies
# Purpose: Count the number of values in the input integer array
# that are evenly divisible by 1,2, 3, ..., 10. Store the
# count of each in the input frequencies array.
# Arguments: $a0 <-- The address of the first value in the
# integer array.
# $a1 <-- The length of the integer array.
# $a2 <-- The address of the first value in the
# frequencies array.
# $a3 <-- The length of the frequencies array.
# Returns: nothing
###################################################################
getFrequencies:
# $t0<----$a0 The address of the first value in the array.
# $t0 temporary pointer
# $t1<----$a1 The length of the array.

la $t0 , ($a0)
add $t1 , $zero , $a1
la $t2 , ($a2)     # $t2 <--- The address of the first value in the frequencies array.
add $t3 , $zero , $a3   #  $t3 <---- The length of the frequencies array.

addi $t4 , $t4 , 1 # loop for frequencies array
addi $t5 , $t5 , 0 #  Num of evenly divisible 
addi $t7 , $t7 , 0 # loop for values array

frequencieyLoop:

beq $t4 , 11 , FrequenciesArrayFilled
la $t0 , ($a0)
addi $t7 , $zero , 0                                    #rest $t7 before the next check
addi $t5 , $zero, 0                                               #rest $t5 before the next check
                       
intgerValuesLoop:
beq $t7 , $t1 , wholeIntgerChecked 
lw $t6 , ($t0)                                              #t6 will be used as to load values from valuesarray
div $t6 , $t4
mfhi $t6                                                    #$t7 remainder of qotient 
bne $t6 , 0 , notDivisible
addi $t5 , $t5 , 1
addi $t0, $t0 ,4
addi $t7 , $t7 , 1

j intgerValuesLoop

notDivisible:
addi $t0, $t0 ,4
addi $t7 , $t7 , 1

j intgerValuesLoop

wholeIntgerChecked:
sw $t5 , ($t2)
addi $t4, $t4 ,1 
addi $t2, $t2 ,4
 
j frequencieyLoop

FrequenciesArrayFilled:
jr $ra


###################################################################
# Function: printFrequencies
# Purpose: Prints the values in the input frequencies array
# formatted as shown in the example program run.
# Arguments: $a0 <-- The address of the first value in the
# frequencies array.                                               
# $a1 <-- The length of the frequencies array.                    
# Returns: nothing                                                
###################################################################
printFrequencies:
#loop variabel to print 1-10
addi $t0, $zero, 1
#$t1 <-- $a0; address of first value in frequency array
la $t1,($a0)

beginPrintLoop:
beq $t0, 11, return
#print the number before colon, keep looping until it reaches 10
addi $v0, $zero, 1
add $a0, $zero, $t0
syscall

li $v0, 4
la $a0, colon
syscall

li $v0, 1
lw $a0, ($t1)
syscall 

li $v0, 4
la $a0, newLine
syscall

addi $t0, $t0, 1
addi $t1, $t1, 4

j beginPrintLoop

return:
jr $ra

.data
       values: .word 0:1000
       valuesLength: .word 1000
       frequenciesArray: .word 0:10
       frequenciesArraylength: .word 10
       colon: .asciiz ": "
       newLine: .asciiz "\n"
       #testArray: .word 10:1000
       #testaeeaylength: .word 1000
