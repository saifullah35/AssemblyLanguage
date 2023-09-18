# File:  TestUtilArrayListInteger.asm
# Author:  Jonathan Masih , Saif Ullah
# Modified by:  Jonathan Masih and Saif Ullah
# Version:  
# Purpose:  To test utilArrayListInteger 
############## Macros #################
# 
.eqv SVC_PRINT_INT 1
.eqv SVC_PRINT_STR 4
.eqv SVC_ALLOC_HEAP 9
.eqv SVC_END_PROGRAM 10
# Push the contents of the argument register
# to the stack 
.macro push($register)
	addi $sp, $sp, -4
	sw $register, ($sp)
.end_macro

# Pop the content from stack onto argument register
.macro pop($register)
	lw $register, ($sp)
	addi $sp, $sp, 4
	
.end_macro

# Print the string at address $var
.macro printStringVar($var)
	push($a0)
	push($v0)
	
	la $a0, $var
	li $v0, SVC_PRINT_STR
	syscall 
	
	pop($v0)
	pop($a0)
.end_macro

# Print the integer stored at register
.macro printIntReg($register)
	push($a0)
	push($v0)
	
	add $a0, $zero, $register
	li $v0, SVC_PRINT_INT
	syscall 
	
	pop($v0)
	pop($a0)
.end_macro



# End program
.macro endProgram
	li $v0, SVC_END_PROGRAM
	syscall
.end_macro
############# End Macros ##############
.text
main:
  # Create an ArrayList of size 5 {1, 2, 4, 8, 16}
    # $s0 <-- address of first value in arrayList
    # $s1 <-- address of last value in arrayList
    # $t0 <-- next value to enter into arrayList
    # $t1 <-- offset
    # $t2 <-- loop counter
    la $s0, array
    add $s1, $zero, $s0
    addi $t0, $zero, 1
    addi $t1, $zero, 0
    addi $t2, $zero, 5
    
beginLoop:
    beqz $t2, endLoop
    sw $t0, array($t1)
    add $t0, $t0, $t0
    addi $t1, $t1, 4
    addi $t2, $t2, -1
    j beginLoop
endLoop:
    add $s1, $s1, $t1
    addi $s1, $s1, -4
  
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2
    
# Test utilALISize for size 5
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    jal utilALISize
    
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    addi $t2, $zero, 5
    la $a0, errorSize
    bne $v0, $t2, endProgram
    
  # Test utilALISet
  # change {1, 2, 4, 8, 16} to {-1, -2, -4, -8, -16}
  # $s3 <-- the offset
   #$s4 <-- the expected value
   #$s5 <-- maximum index
   #$s6 <-- current index
    add $s3, $zero, $zero
    add $s5, $zero, 4
    add $s6, $zero, $zero
  testUtilALISetLoop:
    add $a0, $zero, $s0
    add $a1, $zero, $s6
    lw $a2, array($s3)
    sub $a2, $zero, $a2
    add $s4, $zero, $a2
    jal utilALISet
    
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    lw $t2, array($s3)
    la $a0, errorSet
    bne $s4, $t2, endProgram
    addi $s3, $s3, 4
    addi $s6, $s6, 1
    ble $s6, $s5, testUtilALISetLoop
    
  # Test utilALIRemove 
  # change {-1, -2, -4, -8, -16} to {-2, -4, -8, -16}
    # $s3 <-- value expected to be removed ($v0)
    # $s4 <-- address of last value in arrayList ($v1)
    addi $s3, $zero, -1
    add $s4, $s1, -4
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $a2, $zero, $zero
    jal utilALIRemove

    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    add $s1, $zero, $v1
    la $a0, errorRemove
    bne $v0, $s3, endProgram
    bne $v1, $s4, endProgram

  # change {-2, -4, -8, -16} to {-2, -8, -16}
    addi $s3, $zero, -4
    add $s4, $s1, -4
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    addi $a2, $zero, 1
    jal utilALIRemove

    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    add $s1, $zero, $v1
    la $a0, errorRemove
    bne $v0, $s3, endProgram
    bne $v1, $s4, endProgram

  # change {-2, -8, -16} to {-2, -8}
    addi $s3, $zero, -16
    add $s4, $s1, -4
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    addi $a2, $zero, 2
    jal utilALIRemove

    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    add $s1, $zero, $v1
    la $a0, errorRemove
    bne $v0, $s3, endProgram
    bne $v1, $s4, endProgram
    
  # Test utilALIClear for size 0
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    jal utilALIClear
    add $s1, $zero, $v0
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    jal utilALISize
    
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $s2, $zero, $v0
    jal printCurrentArray
    add $v0, $zero, $s2

    la $a0, errorClear   
    bne $v0, $zero, endProgram
 
#Test utilALIAdd 
#$s0 <-- address of first value in arrayList
# $s1 <-- address of last value in arrayList
#adding 5 to empty arraylist shouuld print 
#[5]  
  
add $a0, $zero, $s0
add $a1, $zero, $s1
addi $s2, $zero, 5
add $a2, $zero , $s2 
addi $s3 , $s1 , 4  # address of last value in arrayList after adding a new value
 jal utilALIAdd
 move $s1 , $v0      #New address of last value in arrayList used later for testing
  la $a0, ($s0)
 la $a1, ($s1)
 jal printCurrentArray
 la $a0, errorAdd
 
#Test utilALIAdd 
#adding 5 to arraylist list size 1 shouuld print 
#[5  10]  
  
add $a0, $zero, $s0
add $a1, $zero, $s1
addi $s2, $zero, 10
add $a2, $zero , $s2 
addi $s3 , $s1 , 4  # address of last value in arrayList after adding a new value
 jal utilALIAdd
 move $s1 , $v0      #New address of last value in arrayList used later for testing
  la $a0, ($s0)
 la $a1, ($s1)
 jal printCurrentArray
 la $a0, errorAdd
 
 #Test utilALIAdd 
#adding 5 to arraylist list size 1 shouuld print 
#[5  10 15]  
  
add $a0, $zero, $s0
add $a1, $zero, $s1
addi $s2, $zero, 15
add $a2, $zero , $s2 
addi $s3 , $s1 , 4  # address of last value in arrayList after adding a new value
 jal utilALIAdd
 move $s1 , $v0      #New address of last value in arrayList used later for testing
  la $a0, ($s0)
 la $a1, ($s1)
 jal printCurrentArray
 la $a0, errorAdd
 
#Call contains with the value of the integer that is first in the arraylist
# $v0 should return 1 testing with 5 
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2, $zero , 5
jal utilALIContains
bne $v0 , 1 , errorContainsPrint

#call contains with the value of the integer that is last in the arraylist
# $v0 should return 1 testing with 15 arraylist [5 10 15]
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2, $zero , 15
jal utilALIContains
bne $v0 , 1 , errorContainsPrint


#call contains with the value of an integer that is in the arraylist, but is neither first nor last
# $v0 should return 1 testing with 10  arraylist [5 10 15]
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2, $zero , 10
jal utilALIContains
bne $v0 , 1 , errorContainsPrint

#call contains with a value of an integer that is not in the arraylist
# $v0 should return 0 testing with 20  arraylist [5 10 15]
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2, $zero , 20
jal utilALIContains
bne $v0 , 0 , errorContainsPrint

#call contains with the value of an integer when the arraylist is empty
# $v0 should return 0 testing with 20  arraylist [ }
add $a0, $zero, $s0
add $a1, $zero, $s1
jal utilALIClear
add $s1 , $zero , $v0  # new last address after clearing arrayList
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2, $zero , 20
jal utilALIContains
bne $v0 , 0 , errorContainsPrint
j utilALIContainsPassed

errorContainsPrint:
la $a0,  errorContains
addi $v0,$zero ,SVC_PRINT_STR 
syscall 
j endProgram
utilALIContainsPassed:

#Adding values into array before testing UtilALIGet
#loop varible
#counter     array after this [0 1 2 3]
addi $s2 , $zero , 5
addi $s3 , $zero , 0  #counter
addIntLoop:
beq $s3 , $s2 , endAddLoop
la $a0 , ($s0)
la $a1 , ($s1)
add $a2 , $zero , $s3
jal utilALIAdd
move $s1 , $v0
addi $s3 , $s3 , 1
j addIntLoop
endAddLoop:
jal printCurrentArray

#call get with index 0 of a non-empty arraylist
# should return 1 for $v0 and 0 in $v1
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , 0
jal utilALIGet
bne $v0 , 1 ,getTestFailed
beq $v1 , 0 , getTestPassed1
printStringVar(errorGet)
j  endProgram
getTestFailed:
printStringVar(errorGet)
j  endProgram
getTestPassed1:

#call get with the index of the last value in the arraylist index 3
# should return 1 for $v0 and 3 in $v1
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , 3
jal utilALIGet
bne $v0 , 1 ,getTestFailed2
beq $v1 , 3, getTestPassed2
printStringVar(errorGet)
j  endProgram
getTestFailed2:
printStringVar(errorGet)
j  endProgram
getTestPassed2:

#call get with an index of a value that is neither first nor last in the arraylist index 2
# should return 1 for $v0 and 2 in $v1
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , 2
jal utilALIGet
bne $v0 , 1 ,getTestFailed3
beq $v1 , 2, getTestPassed3
printStringVar(errorGet)
j  endProgram
getTestFailed3:
printStringVar(errorGet)
j  endProgram
getTestPassed3:

#call get with an index of -1 (index out of bounds error)
#since index out of bounds $v0 should return 0
#should print Error index out of bounds
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , -1
jal utilALIGet
beq $v0 , 0 ,getTestPassed4
printStringVar(errorGet)
j  endProgram
getTestPassed4:
printStringVar(indexOutBoundError)
jal utilPrintNewLine

#call get with an index one greater than the last valid index (index out of bounds error)
#since index out of bounds $v0 should return 0
#should print Error index out of bounds
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , 5
jal utilALIGet
beq $v0 , 0 ,getTestPassed5
printStringVar(errorGet)
j  endProgram
getTestPassed5:
printStringVar(indexOutBoundError)
jal utilPrintNewLine

#call get with an index of 0 when the arraylist is empty (index out of bounds error)
#since index out of bounds $v0 should return 0
#should print Error index out of bounds
add $a0, $zero, $s0     #clearing the array for the test
add $a1, $zero, $s1
jal utilALIClear
add $s1 , $zero , $v0  # new last address after clearing arrayList
la $a0 , ($s0)
la $a1 , ($s1)
addi $a2 , $zero , 1
jal utilALIGet
beq $v0 , 0 ,getTestPassed6
printStringVar(errorGet)
j  endProgram
getTestPassed6:
printStringVar(indexOutBoundError)
jal utilPrintNewLine

#Adding values into array before testing utilALIIndexOf
#loop varible
#counter     array after this [0 1 2 3  4 1]
addi $s2 , $zero , 5
addi $s3 , $zero , 0  #counter
addIntLoop1:
beq $s3 , $s2 , endAddLoop1
la $a0 , ($s0)
la $a1 , ($s1)
add $a2 , $zero , $s3
jal utilALIAdd
move $s1 , $v0
addi $s3 , $s3 , 1
j addIntLoop1
endAddLoop1:
la $a0 , ($s0)
la $a1 , ($s1)
add $a2 , $zero , 1
jal utilALIAdd
move $s1 , $v0
la $a0 , ($s0)
la $a1 , ($s1)
jal printCurrentArray


# Calling utilALIIndexOf with a value that occurs only once in the arraylist
# Should return index of first occurence of the specified integer
# should return in $v0 2
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2 , $zero , 2
jal utilALIIndexOf
beq $v0 , 2 , indexOftestPassed1
printStringVar(errorIndexOf)

indexOftestPassed1:
# Calling utilALIIndexOf with a value that occurs multiple times in the arraylist
# Should return indexes of the multiple occurences of the specified integer. first 
# occurences should return in $v0 1
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2 , $zero , 1
jal utilALIIndexOf
beq $v0 , 1 , indexOftestPassed2
printStringVar(errorIndexOf)

indexOftestPassed2:

# Calling utilALIIndexOf with a value that does not occur in the arraylist
# Should return a value of -1 for $v0
add $a0, $zero, $s0
add $a1, $zero, $s1
add $a2 , $zero , 10
jal utilALIIndexOf
beq $v0 , -1 , indexOftestPassed3
printStringVar(errorIndexOf)
indexOftestPassed3:

# Calling utilALILastIndexOf with a value that occurs only once in the arraylist


# Calling utilALILastIndexOf with a value that occurs multiple times in the arraylist


# Calling utilALILastIndexOf with a value that does not occur in the arraylist




# All tests complete!  
    la $a0, success
    
  endProgram:
    jal utilPrintString
    jal utilPrintNewLine
    jal utilEndProgram
    
################################################################
#   Function:  printCurrentArray
#    Purpose:  prints the contents of the current array
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
# Return value:  none
################################################################
printCurrentArray:
la $t0 , ($a0)
la $t1, ($ra)
la $a0, currentArray
jal utilPrintString
PrintLoop:
bgt $t0 , $a1 , returnToMain
lw $a0 , ($t0)
jal  utilPrintInt
jal  utilPrintSpace
addi $t0 , $t0 , 4
j PrintLoop
returnToMain:
jal utilPrintNewLine
la $ra , ($t1)
jr $ra
        
.data
  array:  .word 0:100
  currentArray:  .asciiz "The current arrayList contains:\n"
  errorClear: .asciiz "Error with utilALIClear"
  errorRemove: .asciiz "Error with utilALIRemove"
  errorSet: .asciiz "Error with utilALISet"
  errorSize:  .asciiz "Error with utilALISize"
  errorAdd: .asciiz "Error with utilALIAdd"
  errorContains: .asciiz "Error with utilALIContains"
  errorGet: .asciiz "Error with utilALIGet"
  errorIndexOf: .asciiz "Error with utilALIIndexOf"
  errorLastIndexOf: .asciiz "Error with utilALILastIndexOf"
  errorALIRemoveFirst: .asciiz "Error with utilALIRemoveFirst"
  success:  .asciiz "All tests successful!"
  indexOutBoundError: .asciiz "Index Out of Bounds"
  
  
.include "utils.asm"
.include "utilArrayListInteger.asm"
