# File:	utilArrayListIntegerSTARTER.asm
# Author:   Saif Ullah and Spencer Moon
# Version:  Fall 2021
#
# This implementation assumes the following:
# (1) all subprograms are called with valid arguments
# (2) zero-based indexing
#
# Subprogram Index
#     ALI = ArrayListInteger
#     utilALISize - returns the number of integers in the arrayList
#     utilALIClear - removes all elements in the arrayList; size = 0
#     utilALISet - sets the value of an element in the arrayList to a
#                  specified value
#     utilALIRemove - removes an element from the arrayList; size = 
#                     size - 1

################################################################
#   Subprogram:  utilALISize
#      Purpose:  returns the number of integers in the arrayList
#                >= 0
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
# Return value:  $v0 <-- the number of integers in the arrayList
################################################################
.text

utilALISize:

blt $a1, $a0, makeZero
sub $v0, $a1, $a0
srl $v0, $v0, 2
addi $v0, $v0, 1
j end

makeZero:
	add $v0, $zero, $zero
end:
	jr $ra
    
################################################################
#   Subprogram:  utilALIClear
#      Purpose:  clears the array (size = 0)
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
# Return value:  $v0 <-- the address of the last element
################################################################
.text

utilALIClear:
addi $a1, $a0, -4
add $v0, $zero, $a1
jr $ra
    
################################################################
#   Subprogram:  utilALISet
#      Purpose:  sets the value of an element in the arrayList 
#                to a specified value
# Precondition:  The index is a valid index in the arrayList
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the index of the element whose value
#                        will be set
#                $a2 <-- the value the element at the index will
#                        be set to
# Return value:  none
################################################################
.text

utilALISet:
sll $t0, $a1, 2
add $t0, $t0, $a0
sw $a2, ($t0)
jr $ra

################################################################
#   Subprogram:  utilALIRemove
#      Purpose:  removes the element in the arrayList at the 
#                specified index and returns the value
# Precondition:  The index is a valid index in the ArrayList
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- the index of the element to be removed
# Return value:  $v0 <-- the value removed
#                $v1 <-- the address of the last element
################################################################
.text

utilALIRemove:
sll $t0, $a2, 2
add $t0, $t0, $a0
lw $t2, ($t0)

loop2:
	bge $t0, $a1, endLoop2
	addi $t1, $t0, 4
	lw $t3, ($t1)
	sw $t3, ($t0)
	addi $t0, $t0, 4
	j loop2
	
endLoop2:
	addi $a1, $a1, -4
	add $v0, $t2, $zero
	add $v1, $a1, $zero
	jr $ra
