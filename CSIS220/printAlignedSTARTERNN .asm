# File Name:  printAlignedSTARTER.asm
# Author:     
# Version:    
# Purpose:    To fill an array of integers
#             with random values in the range [1, 9].
.text
main:
    # $s0 <--length of the array
    # $s1 <-- address of the array
    lw $s0, intArrayLength
    la $s1, intArray
    
    # $t0 <-- number of integers currently in the array
    # $t1 <-- temporary pointer to start of the array
    addi $t0, $zero, 0
    add $t1, $zero, $s1
    
beginRandInitLoop:
    # if we have added all the integers, end loop
    beq $t0, $s0, endRandInitLoop
    
    #Generate the number in [0, 8]
    addi $a0, $zero, 3  # 3 is the seed; could be any integer
    addi $a1, $zero, 21 
    addi $v0, $zero, 42 
    syscall
    
    subi $t2, $a0 , 10
    #Shift the range to [1, 9]
    

    # store contents of $t2 into effective memory address ($t1)
    sw $t2, ($t1) 
    
    # step to the next array cell
    addi $t1, $t1, 4
    
    # count the array element just initialized
    addi $t0, $t0, 1
    
    j beginRandInitLoop
    
endRandInitLoop:
    
    # print the values in the array 25 per line
    # $t1 <-- temporary pointer to start of the array
    add $t1, $zero, $s1
    
    # $t2 <-- 0 counts how many have been printed
    addi $t2, $zero, 0
    
    begPrintLoop:
    # check if all of the integers have been printed
    beq $t2, $t0, endPrintLoop
    
    # print another integer and a space
    lw $a0, ($t1)
    beq $a0, -10, print1Space
    blt $a0, 0, print2Space
    beq $a0, 10, print2Space
    bge $a0, 0, print3Space
printNumber:
    addi $v0, $zero, 1
    lw $a0, ($t1)
    syscall
    
    
    # if 25 have been printed, go to new line
    # $t4 <-- number printed + 1 to facilitate 25 per line
    addi $t4, $t2, 1
    div $t3, $t4, 25
    mfhi $t3
    bne $t3, $zero, bottomPrintLoop
    addi $v0, $zero, 4
    la $a0, newLine
    syscall
    
bottomPrintLoop:
    # count the integer as printed and
    # go to the next array location
    addi $t2, $t2, 1
    addi $t1, $t1, 4
    j begPrintLoop
    
endPrintLoop:
    
    # end program
    li $v0, 10
    syscall
print1Space:
    addi $v0, $zero, 4 
    la $a0, space
    syscall
    
    
    j printNumber
    
print2Space:
    addi $v0, $zero, 4 
    la $a0, space
    syscall
    syscall
    

    
    j printNumber
    
print3Space:
    addi $v0, $zero, 4 
    la $a0, space
    syscall
    syscall
    syscall

    
    j printNumber
    
.data
    # 1000 bytes of space for the array
    # can hold 250 integers (4 bytes each)
    # each initialized to zero
    intArray:        .byte 0:1000
    intArrayLength:  .word 250
    newLine:         .asciiz "\n"
    space:           .asciiz " "
