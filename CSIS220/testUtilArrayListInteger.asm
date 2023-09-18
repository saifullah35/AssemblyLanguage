# File:  TestUtilArrayListInteger.asm
# Author:  Prof. White
# Modified by:  Jonathan Masih and Saif Ullah
# Version:  Fall 2021 
# Purpose:  To test utilArrayListInteger
 
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
  # $s4 <-- the expected value
  # $s5 <-- maximum index
  # $s6 <-- current index
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
    
 # Test utilALIAdd
   
  
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
	
	addi $sp, $sp, -4	
	sw $ra, ($sp)
	#Prints a message
	la $t0, ($a0)
	la $a0, currentArray
	jal utilPrintString
	
	
	loop:
		bgt $t0, $a1, endLoopAndReturn
		lw $a0, ($t0)
		jal utilPrintInt
		jal utilPrintSpace
		addi $t0, $t0, 4
		j loop
		
	endLoopAndReturn:
		jal utilPrintNewLine
		lw $ra, ($sp)
		addi $sp, $sp, 4	        
		jr $ra
		
	
	  
        
.data
  array:  .word 0:100
  currentArray:  .asciiz "The current arrayList contains:\n"
  errorClear: .asciiz "Error with utilALIClear"
  errorRemove: .asciiz "Error with utilALIRemove"
  errorSet: .asciiz "Error with utilALISet"
  errorSize:  .asciiz "Error with utilALISize"
  errorAdd: .asciiz "Error with utilALIAdd"
  success:  .asciiz "All tests successful!"
  
.include "utils.asm"
.include "utilArrayListInteger.asm"
