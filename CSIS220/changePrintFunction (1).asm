# File Name:  changeSign.asm 
# Author:     Saif Ullah and Juan Acosta
# Version:    October 28, 2021
# Purpose:    Program that switches the negative numbers to positive and positive numbers to negative. 
#             These numbers are all in an array
.text
main:
    # $a1 <--length of the array
    # $a0 <-- address of the array
    #$s5 <-- counter in $s
    lw $a1, arrayLength
    la $a0, array
    #li $s5, 0   
    
  
# put the address of the array in a0 
#length in a1

jal printArray


    lw $s0, arrayLength
    la $s1, array
    
changeVal:    
    beqz $s0,closeToEnd  
    lw $s3, ($s1)
    mul $s3, $s3, -1
    mflo $s3
    sw $s3, ($s1)
    
    subi $s0 ,$s0, 1
    #Goes to the next value in the array
    add $s1, $s1, 4
    
    j changeVal
    
    
closeToEnd:    
#jal printArray
# 
#change the values in the array
  la $a0, array
  lw $a1, arrayLength
  jal printArray
  
# put the address of the array in a0 
#length in a1
#jal printArray
#
endLoop:
    #End program
    li $v0, 10
    syscall
###########################################################
# Function Name: printArray
# Purpose: To print the numbers from the array with a space between each number and a newline at the end
#
# Arguments: $a0 address of  array
#            $a1 length of the array
###########################################################
printArray:
# when you call this function a0 should have addres of array , a1 should have lenght of array
#then print the values in the array from memory
#jr $ra 
   
    move $t0,$a1 #length
    move $t1,$a0 #array
beginPrint: 

    addi $v0, $zero, 1 
    beqz $t0, newSpace
    
    lw $t2, ($t1)
    add $a0, $zero, $t2
    syscall
    
    
    #updates counter adding 1
    subi $t0 ,$t0, 1
    #Goes to the next value in the array
    add $t1, $t1, 4
    #Prints the space
    addi $v0, $zero, 4
    la $a0, space
    syscall
    
    j beginPrint
    
    newSpace:
    addi $v0, $zero, 4
    la $a0, newLine
    syscall
    
    jumpToMain:
    jr $ra





.data
    # 1000 bytes of space for the array
    # can hold 250 integers (4 bytes each)
    # each initialized to zero
    array:        .word -1,2,-3,4,-5,6,-7,8,-9,10,11,12
    arrayLength:  .word 12
    newLine:      .asciiz "\n"
    space:        .asciiz " "
