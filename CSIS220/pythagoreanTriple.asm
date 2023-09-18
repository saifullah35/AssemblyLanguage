# Program File:  pythagoreanTriple.asm
# Author:  Saif Ullah and Jonathan Masih
# Version:  October 15, 2021
# Purpose:  Prompts the user for the value of b, the length of one side of a right triangle that forms a Pythagorean triabgle
.text 

main:
#Prompting the user for B and store in $s0
ori $v0, $zero, 4
la $a0, prompt
syscall
ori $v0, $zero, 5
syscall
or $s0, $zero, $v0                   #s0 <---- B
    
#Check if B is greater than 2, even, and positive
blt $s0, 0, printErrorNegative
blt $s0, 2, printErrorLessThan
div $t0, $s0, 2           #CHECKING if the integer is odd
mfhi $t0
bne $t0, 0, printOddError     
j noIntegerError                # Integer with no error 
    
printErrorNegative:
ori $v0, $zero, 4
la $a0, errorNegative
syscall
j end    
    
printErrorLessThan:
ori $v0, $zero, 4
la $a0, errorLessThan
syscall
j end   

printOddError:
ori $v0, $zero, 4
la $a0, errorOdd
syscall
j end


noIntegerError:       #jump to here when integer has no error
#Calculate M = B /2
div $t0 , $s0 , 2
mflo $t0             #$t0 <--- M

# Calculate a = M^2 ? 1
mul $t1, $t0 , $t0
mflo $t1                   #$t1 <--- A
subi $t1, $t1, 1

# Calculate c = M^2 + 1
mul $t6 , $t0 , $t0
mflo $t2                   #$t2 <--- C
addi $t2, $t2, 1

#Calculate N = b / 2M
 mul $t3 ,$t0 ,2
 mflo $t3
 div $t7 , $s0 , $t3
 mflo $t3               #$t3 <--- N
 
# Calculate a^2 + b^2
 mul $t6 , $t1 , $t1
 mflo $t6             #$t6 <--- a^2
 mul $t7 , $s0 , $s0
 mflo $t7             #$t6 <--- b^2
 add $t4 , $t6 , $t7   #$t4 <---   a^2 + b^2

#Calculate c^2
mult $t2 , $t2
mflo $t5                #$t5 <--- c^2

#Printing all the Values 
#print a
ori $v0, $zero, 4
la $a0, a
syscall
ori $v0, $zero, 1
la $a0, ($t1)
syscall

#print b
ori $v0, $zero, 4
la $a0, b
syscall
ori $v0, $zero, 1
la $a0, ($s0)
syscall

#print c
ori $v0, $zero, 4
la $a0, c
syscall
ori $v0, $zero, 1
la $a0, ($t2)
syscall

#print M
ori $v0, $zero, 4
la $a0, M
syscall
ori $v0, $zero, 1
la $a0, ($t0)
syscall

#print N
ori $v0, $zero, 4
la $a0, N
syscall
ori $v0, $zero, 1
la $a0, ($t3)
syscall

#print aSquaredPlusBSquared
ori $v0, $zero, 4
la $a0, aSquaredPlusBSquared
syscall
ori $v0, $zero, 1
la $a0, ($t4)
syscall

#print aSquaredPlusBSquared
ori $v0, $zero, 4
la $a0, cSquared
syscall
ori $v0, $zero, 1
la $a0, ($t5)
syscall


#Checking if a^2 + b^2 is equal to c^2 if it Print check if not printCheckError
 ori $v0 , $zero , 4
 bne $t4 , $t5 , checkErorr
 la $a0 , check
 syscall
 j ImperativeOrPrimitive


 checkErorr:
  la $a0 , checkErrorPrint
  syscall

 ImperativeOrPrimitive:
 div $t6 , $t1 , 2
 mfhi $t1 
 div $t7 , $s0  ,2
 mfhi $t2 
 div $t7 , $t2 , 2
 mfhi $t3 
 
 bne $t1 , 0 ,Primitive
 bne $t2 , 0 , Primitive
 bne $s3 , 0 , Primitive
 ori $v0, $zero, 4
 la $a0,  ImperativePrint
 syscall
 j end
  
 Primitive:
  
 ori $v0, $zero, 4
 la $a0,PrimitivePrint
 syscall
 
  


end:
    ori $v0, $zero, 10
    syscall

.data
    prompt: .asciiz "Enter an even integer greater than 2: "
    errorLessThan: .asciiz "\nError: Enter an even integer greater than 2."
    errorNegative: .asciiz "\nError: The integer cannot be negative."
    errorOdd: .asciiz "\nError: The integer cannot be odd."
    a: .asciiz "\na:  "
    b: .asciiz "\nb:  "
    c: .asciiz  "\nc:  "
    M: .asciiz  "\nM:  "
    N: .asciiz  "\nN:  "
    aSquaredPlusBSquared: .asciiz "\n\na^2 + b^2 = "
    cSquared: .asciiz "\nc^2 = "
    check: .asciiz "\nCheck"
    checkErrorPrint: .asciiz "\nCheckError"
    PrimitivePrint: .asciiz "\n\nnPrimitive"
    ImperativePrint: .asciiz "\n\nImperative"
    
    
