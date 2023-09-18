# File:	utilArrayListIntegerSTARTER.asm
# Author:  Jonathan Masih and James Miller
# Modified by:  Jonathan Masih and Saif Ullah
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

  sub $t0 , $a1 , $a0
  div $t0 , $t0 , 4
  mflo $t0
  addi $t0 , $t0 ,1
  move $v0 , $t0
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
    subi $a1, $a0, 4
    la $v0, ($a1)
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
addi $t0, $a1, 0
la $t1, ($a0)
mul $t0, $t0, 4
add $t1, $t1, $t0
sw  $a2, ($t1)
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
addi $t0, $a0, 0 #address of the first element
addi $t1, $a1, 0  #address of the last element
#address of the index
addi $t2 , $a2 , 0
mul $t2 , $t2 , 4
mflo $t2
add $t2 , $t2 , $t0

lw $v0 ,($t2)   #return value

beq $t2 , $t1 , specialCase


#value of next index
addi $t3 , $zero , 0
removeLoop:
beq $t2 , $t1 , return1
addi $t2 , $t2 , 4
lw $t3 , ($t2)
addi $t2 , $t2 , -4
sw $t3 , ($t2)      
addi $t2 , $t2 , 4     
j removeLoop                                                                          
specialCase:
subi $t1, $t1, 4  #address of the last element
move $v1, $t1
jr $ra
return1:
subi $t1 , $t1 , 4
move $v1 , $t1
jr $ra

################################################################
#   Subprogram:  utilALIAdd
#      Purpose:  adds an integer to the end of the arraylist
# Precondition:  The index is a valid index in the ArrayList
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- the integer to be added
# Return value:  $v0 <-- address of the last value in the array
################################################################
.text
utilALIAdd:
la $t0, ($a1)
addi $t0, $t0, 4
sw $a2, ($t0)
la $v0, ($t0)
jr $ra

################################################################
#   Subprogram:  utilALIContains
#      Purpose:  return 1 if the arraylist contains the specified 
#                integer and 0 if it does not.
# Precondition:  The index is a valid index in the ArrayList
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- The integer to look for in the arraylist
# Return value:  $v0 <-- indicates the integer is not contained in the arraylist.
################################################################
.text
utilALIContains:

blt $a1 , $a0 , emptyArrayList 
checkLoop: 
bgt $a0 , $a1 , return
lw $t0 , ($a0)    # the value at current index
beq $t0 , $a2 , valueFound
addi $a0 , $a0 , 4
addi $v0 , $zero , 0
j checkLoop
emptyArrayList:
addi $v0 , $zero , 0
j return
valueFound:
addi $v0 , $zero , 1
return:
jr $ra

################################################################
#   Subprogram:  utilALIGet
#      Purpose:  return the integer stored at the specified index if 
#                index out of bounds returns a 0 
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- The index into the arraylist 
# Return value:  $v0 <-- A return value of 1 in $v0 indicates the integer 
#                        is being returned in $v1; a return value of 0 in
#                        $v0 indicates the specified index was out of bounds.
#                $v1 <-- The integer stored at the specified index
################################################################
.text
utilALIGet:
#calculate the address of the specified index
mul $t0 , $a2 , 4
add $t0 , $t0 , $a0
bgt $t0 , $a1 , indexOutOfBounds
blt $t0 , $a0 , indexOutOfBounds
lw $t1 , ($t0)       #if index not out of bounds $t1 becomes the value at the index
addi $v0 , $zero , 1
move $v1 , $t1  
j return2
indexOutOfBounds:
addi $v0 , $zero , 0

return2:
jr $ra

################################################################
#   Subprogram:  utilALIIndexOf
#      Purpose:  returns the index of the first occurrence of the specified integer in the arraylist
#                or -1 if the specified integer is not in the arraylist
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- The integer to look for in the arraylist
# Return value:  $v0 <-- The index of the first occurrence of the specified integer is returned.
#                        A return value of -1 in $v0 indicates the integer is not contained in the arraylist.
################################################################
.text
utilALIIndexOf:
move $t1 , $a0
checkLoop2:
bgt $t1 , $a1 , integerNotContained
lw $t0 , ($t1)    # the value at current index
beq $t0 , $a2 , valueFound2
addi $t1, $t1, 4
j checkLoop2
valueFound2:             # return the index of the first occurence of the specified integer
sub $t2 , $t1 , $a0
div $t2 , $t2 , 4
move $v0 , $t2
j  return3
integerNotContained:
addi $v0 , $zero , -1       # return value of -1 indicates the integer is not in the arraylist
return3:
jr $ra


################################################################
#   Subprogram:  utilALILastIndexOf
#      Purpose:  returns the index of the last occurrence of the specified integer in the
#                arraylist or -1 if the specified integer is not in the arraylist.
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- The integer to look for in the arraylist
#  Return value: $v0 <-- The index of the last occurrence of the specified integer is returned.
#                        A return value of -1 in $v0 indicates the integer is not contained in the arraylist.
################################################################
.text
utilALILastIndexOf:
blt $a1, $a0, integerNotContained2

checkLoop3:
bgt $a0 , $a1 , return4
lw $t0 , ($a0)    # the value at current index
beq $t0 , $a2 , valueFound3
addi $a0, $a0, 4

valueFound3:          # return the index of the last occurence of the specified integer

integerNotContained2:
addi $v0 , $zero , -1          # return value of -1 indicates the integer is not in the arraylist
j return4


return4:
jr $ra

################################################################
#   Subprogram:  utilALIRemoveFirst
#      Purpose:  Removes the first occurrence of the specified integer in the arraylist.
#    Arguments:  $a0 <-- the address of the first element
#                $a1 <-- the address of the last element
#                $a2 <-- The integer to remove from the arraylist
#  Return value: $v0 <-- A return value of 1 in $v0 indicates the integer was removed; a return value of 0 in $v0
#			 indicates the specified integer is not contained in the arraylist.
#		 $v1 <-- The address of the last value in the array is returned
################################################################
.text
utilALIRemoveFirst:
blt $a1, $a0, integerNotContained3

checkLoop4:

addi $v0 , $zero , 1  		# return value of 1 indicates integer was removed

integerNotContained3:
addi $v0 , $zero , 0  		# return value of 0 indicates integer was was not in the arraylist
j return5


return5:
jr $ra
