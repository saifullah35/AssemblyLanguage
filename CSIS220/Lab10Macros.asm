# File:     Lab10Macros.asm
#
# Purpose:  Contains the constant declarations
#           for services and macros
#             push($register)
#             pop($register)
#             printCharReg($register)
#             printStringVar($var)
#             printIntReg($register)
#             endProgram()
#
# Author:   John Hurley Saif Ullah
# Version:  12/08/2021
#################### Macros #################### 
.eqv SVC_PRINT_INT 1
.eqv SVC_PRINT_STR 4
.eqv SVC_READ_INT 5
.eqv SVC_ALLOC_HEAP 9
.eqv SVC_END_PROGRAM 10
.eqv SVC_PRINT_CHAR 11
.eqv SVC_READ_CHAR 12

# Push contents of a register
.macro push($register)
    addi $sp, $sp, -4
    sw $register, ($sp)
.end_macro
	
# Pop to a register
.macro pop($register)
    lw $register, ($sp)
    addi $sp, $sp, 4
.end_macro

# Print the character in $register
# COMPLETE THIS METHOD
.macro  printCharReg($register)
    push($v0)
    push($a0)

    add $a0, $register, $zero   
    li $v0, SVC_PRINT_CHAR
    syscall

    pop($a0)
    pop($v0) 
.end_macro

# Print the string at address $var
.macro  printStringVar($var)
    push($a0)
    push($v0)
	
    la $a0, $var
    li $v0, SVC_PRINT_STR
    syscall
	
    pop($v0)
    pop($a0)
.end_macro
	
# Print the integer in $register
.macro  printIntReg($register)
    push($a0)
    push($v0)
	
    add $a0, $zero, $register
    li $v0, SVC_PRINT_INT
    syscall
	
    pop($v0)
    pop($a0)
.end_macro

# End program	
.macro endProgram()
    li $v0, SVC_END_PROGRAM
    syscall
.end_macro
