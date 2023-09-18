# File:     arraySumRecursiveStatic.asm
# Purpose:  To print the array stored in static memory (.data),
#           find its sum recursively, and print the sum.
# Author:   Trevor Collins, Saif Ullah
# Version:  Fall 2021



###################### Macros ##################
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

.macro pop($register)
        lw $register, ($sp)
	addi $sp, $sp, 4
.end_macro

#Print the string at addres $var
    .macro printStringVar($var)
          push($a0)
          push($v0)
          
          la $a0, $var
          li $v0, SVC_PRINT_STR
          syscall
    
          pop($v0)
          pop($a0)
     .end_macro
     
#Print the integer at address $register
    .macro printIntReg($register)
          push($a0)
          push($v0)

          add $a0, $zero, $register
          li $v0, SVC_PRINT_INT
          syscall
    
          pop($v0)
          pop($a0)
     .end_macro

#end the program
     .macro endProgram($register)
     push($v0)
     
     #la $a0, $register
     li $v0, SVC_END_PROGRAM
     syscall
     
     pop($v0)
     .end_macro




###################### End Macros ##################
.text
main:

    #Allocate 20 bytes long in the heap segment
    # $v0 <-- the top of the heap
    addiu $v0, $zero, SVC_ALLOC_HEAP
    
    lb $a0, offset
    syscall
    add $s1, $zero, $v0
    # Save the pointer to the heap in $s2
    add $s2, $zero, $s1
    
    #Storing array values in heap
    addi $s0, $zero, 1
    sw $s0, 0($s2)
    addi $s0, $s0, -3
    sw $s0, 4($s2)
    addi $s0, $s0, 5
    sw $s0, 8($s2)
    addi $s0, $s0, 1
    sw $s0, 12($s2)
    addi $s0, $s0, -9 
    sw $s0, 16($s2)
    addi $s0, $s0, 14
    sw $s0, 20($s2)
    
    
    
  # find the sum of the array recursively
  add $a0, $zero, $s1
  lb $a1, offset
  add $a1, $a1, $a0
  jal sumArrayRecursive
  
  # save the sum
  add $s0, $zero, $v0
  
  # print the array
  #addiu $v0, $zero, 4
  #la $a0, arrayLabel
  #syscall
  
  #call the macros
  printStringVar(arrayLabel)

 # la $a0, array
  add $a0, $zero, $s2
  lb $a1, offset
  add $a1, $a1, $a0
  jal printArray
  
  # print the sum
  #addiu $v0, $zero, 4
  #la $a0, sumLabel
 # syscall
 # addiu $v0, $zero, 1
  #add $a0, $zero, $s0
  #syscall
  
  #call the printInt macro
  printStringVar(sumLabel)
  printIntReg($v0)
  
  # end program
  endProgram($v0)
  
  ########################################################
  # Function:  sumArrayRecursive
  # Purpose:  To return the sum of the array found
  #           recursively
  # Arguments:  $a0 <-- the address of the first element 
  #                     in the array
  #             $a1 <-- the address of the last element 
  #                     in the array
  # Return values:  $v0 <-- the sum of the array elements
  ########################################################
sumArrayRecursive:

    lw $t0, ($a0)
    push($t0)
    push($a0)
    push($a1)
    push($ra)
    
    # base case:
    # if no elements in array, sum = array[$a0]
    lw $v0, ($a0)
    beq $a0, $a1, return
    
    # if elements in array, 
    # recursive step - move closer to the base case
    addi $a0, $a0, 4		
    jal sumArrayRecursive	

    # compute sum
    # $v0 <-- $v0 + element
    lw $a0, 12($sp)
    add $v0, $v0, $a0

return:
    # Restore the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    #pop in reverse order we pushed
    pop($ra)
    pop($a1)
    pop($a0)
    pop($t0)
    jr $ra		
    
  #####################################################
  # Function:  printArray
  # Purpose:  To print an array of values
  # Arguments:  $a0 <-- the address of the first element 
  #                     in the array
  #             $a1 <-- the address of the last element 
  #                     in the array
  # Return values:  None
  #####################################################
printArray:
    add $t0, $zero, $a0
    
beginPrintLoop:
    bgt $t0, $a1, endPrintArray
    #addiu $v0, $zero, 1
    lw  $t2, ($t0)
    #syscall
    printIntReg($t2)
    printStringVar(space)
    
    addiu $t0, $t0, 4
    j beginPrintLoop
    
endPrintArray:
    jr $ra
 
 .data
               #sum = 10
  # array:      .word 1, -2, 3, 4, -5, 9
   arrayLabel: .asciiz "\narray:  "
   offset:     .byte 20
   space:      .asciiz " "
   sumLabel:   .asciiz "\nsum:  "
