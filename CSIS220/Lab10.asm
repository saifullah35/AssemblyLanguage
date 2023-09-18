# File:     Lab10.asm
#
# Purpose:  To prompt the user for an integer in [1, 50].  If
#           the integer is out of range, print an error message
#           and prompt again.  Let's call the valid integer X.
#
#           Prompt the user for X characters that are letters,
#           one at a time.  If the character is not a letter, 
#           print an error and prompt again.  When X letters are
#           read, print the characters, then, change the case
#           of the characters and print them again.
#
#           The characters must be saved on the heap as they
#           are read in from the console.
#
#           The functions printArray and changeCaseArray must
#           be implemented.  Macros must be included in the
#           file Lab10Macros.asm.
#
# Author:   John Hurley Saif Ullah
# Version:  12/08/2021
.include "Lab10Macros.asm"

.text
  main:
    printStringVar(promptInt)
    li $v0, SVC_READ_INT
    syscall
    
    #Reading in n value
    add $s0, $v0, $zero
    blt $s0, 1, errorRange
    bgt $s0, 50, errorRange
    
    #Allocating to Heap
    li $v0, SVC_ALLOC_HEAP
    add $a0, $s0, $zero
    syscall
    
    # $s1 <-- Pointer to beginning of Heap, $s3 <-- Permanent pointer to beginning
    add $s1, $v0, $zero
    add $s3, $v0, $zero
    add $s2, $v0, $a0
    addi $s2, $s2, -1
    j readChar

retry:
    printStringVar(notCharStr)
    #Reading in char
readChar:
    bgt $s1, $s2, finishChar

    printStringVar(promptChar)
    li $v0, SVC_READ_CHAR
    syscall
    

    blt $v0, 65, retry
    bgt $v0, 122, retry
 
    bgt $v0, 90, doubleCheck
    
continued:

    sb $v0, ($s1)
    addi $s1, $s1, 1
    j readChar
    
 doubleCheck:
    blt $v0, 97, retry
    j continued

finishChar:
    printStringVar(newLine)
    printStringVar(newLine)
    add $a0, $s3, $zero
    add $a1, $s1, $zero

    jal printArray

    printStringVar(newLine)

    jal changeCaseArray

    add $a0, $s3, $zero
    add $a1, $s1, $zero
    jal printArray

    printStringVar(newLine)

    endProgram


errorRange:
     printStringVar(notInRangeStr)
     j main

    
 
  
  #####################################################
  # Function:  printArray
  # Purpose:  To print an array of characters
  # Arguments:  $a0 <-- the first element in the array
  #             $a1 <-- the last element in the array
  # Return values:  None
  #####################################################
  printArray:
    push($a0)
    push($a1)
    add $t0, $a0, $zero

printStep:
    
    
    bgt $t0, $a1, printEnd

    lb $t1, ($t0)
    printCharReg($t1)
    addi $t0, $t0, 1

    j printStep

printEnd:
    pop($a1)
    pop($a0)

    jr $ra
 
  #####################################################
  # Function:  changeCaseArray
  # Purpose:  To change the case of the characters in
  #           the array
  # Precondition:  the array contains only characters
  # Arguments:  $a0 <-- the first element in the array
  #             $a1 <-- the last element in the array
  # Return values:  None
  #####################################################
  changeCaseArray:
    push($a0)
    push($a1)
    add $t0, $a0, $zero

caseStep:
    

    bgt $t0, $a1, caseEnd

    lb $t1, ($t0)
    blt $t1, 91, upperToLower
    
    addi $t1, $t1, -32
    sb $t1, ($t0)
    addi $t0, $t0, 1
    j caseStep

upperToLower:

    addi $t1, $t1, 32
    sb $t1, ($t0)
    addi $t0, $t0, 1
    j caseStep

caseEnd:
    pop($a0)
    pop($a1)
    
    jr $ra

.data
   notCharStr:    .asciiz "\n\nNot a letter.\n"
   notInRangeStr: .asciiz "\nNot in range.\n"
   newLine:       .asciiz "\n"
   promptChar:    .asciiz "\nEnter a single letter:  "
   promptInt:     .asciiz "\nEnter an integer in [1, 50]:  "


