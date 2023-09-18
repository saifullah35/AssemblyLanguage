# Program File: easter.asm
# Author: Jonathan Masih & Saif Ullah
# Version: Fall 2021
# Purpose:  Algorithm for Easter Dates

#prompt for the year from the user and storing the value in $s0 <-- year.
ori $v0, $zero, 4
la $a0, promptYear
syscall
ori $v0, $zero, 5
syscall
or $s0, $v0, $zero

#Divide x by 19 to get a remainder A and print.
div $t0 ,$s0 , 19
mfhi $t0          # A
ori $v0, $zero, 4
la $a0, A
syscall
ori $v0, $zero, 1
la $a0, ($t0)
syscall

#Divide x by 100 to get a quotient B and a remainder C abd print B and C.
div $t1 , $s0 , 100
mflo $t1    # B
mfhi $t2    # C
#Print B
ori $v0, $zero, 4
la $a0, B
syscall
ori $v0, $zero, 1
la $a0, ($t1)
syscall
#Print C
ori $v0, $zero, 4
la $a0, C
syscall
ori $v0, $zero, 1
la $a0, ($t2)
syscall

#Divide B by 4 to get a quotient D and a remainder E. and Print D and E.
div $t3 , $t1 , 4
mflo $t3         # D
mfhi $t4         # E 

#Print D
ori $v0, $zero, 4
la $a0, D
syscall
ori $v0, $zero, 1
la $a0, ($t3)
syscall
#Print E
ori $v0, $zero, 4
la $a0, E
syscall
ori $v0, $zero, 1
la $a0, ($t4)
syscall

#Divide 8B + 13 by 25 to get a quotient G  and Print G.
mul $t5 , $t1 , 8
addi $t5 ,$t5, 13 
div $t5 , $t5 , 25
mflo $t5
#Print G
ori $v0, $zero, 4
la $a0, G
syscall
ori $v0, $zero, 1
la $a0, ($t5)
syscall

#Divide 19A + B – D – G + 15 by 30 to get a remainder H Bad Print H.
mul $t6 , $t0 , 19
mflo $t6                #H
add $t6, $t6 , $t1
sub $t6 , $t6 , $t3
sub $t6 , $t6 , $t5
addi $t6 , $t6 , 15
div $t6 , $t6 , 30
mfhi $t6
#Print H
ori $v0, $zero, 4
la $a0, H
syscall
ori $v0, $zero, 1
la $a0, ($t6)
syscall

#Divide A + 11H by 319 to get a quotient M and print M.
mul $t7 , $t6 ,11
mflo $t7           #M
add $t7 , $t7 , $t0
div $t7 , $t7 , 319
mflo $t7
#Print M
ori $v0, $zero, 4
la $a0, M
syscall
ori $v0, $zero, 1
la $a0, ($t7)
syscall

#Divide C by 4 to get a quotient J and a remainder K and print J and K.
div $t3, $t2 , 4
mflo $t3   ## J 
mfhi $t5   ## K
#Print J
ori $v0, $zero, 4
la $a0, J
syscall
ori $v0, $zero, 1
la $a0, ($t3)
syscall
#Print K
ori $v0, $zero, 4
la $a0, K
syscall
ori $v0, $zero, 1
la $a0, ($t5)
syscall

#Divide 2E + 2J – K – H + M + 32 by 7 to get a remainder L and printL.
mul $t0 , $t4 , 2    
mflo $t0              ## L
mul $t3 , $t3 , 2
mflo $t3
add $t0 , $t0 , $t3
sub $t0 , $t0 , $t5
sub $t0 , $t0 , $t6
add $t0 , $t0 , $t7
add $t0 , $t0 , 32
div $t0 , $t0 , 7
mfhi $t0
#Print L
ori $v0, $zero, 4
la $a0, L
syscall
ori $v0, $zero, 1
la $a0, ($t0)
syscall

#Divide H – M + L + 90 by 25 to get a quotient N and Print N.
 sub $t1 , $t6 ,$t7
 add $t1 , $t1 , $t0   ## t1 == N
 add $t1 , $t1 , 90
 div $t1 , $t1 , 25
 mflo $t1
#Print N
ori $v0, $zero, 4
la $a0, N
syscall
ori $v0, $zero, 1
la $a0, ($t1)
syscall

#Divide H – M + L + N + 19 by 32 to get a remainder P And print P.
 sub $t2 , $t6 ,$t7  ## t2 == P
 add $t2 , $t2 , $t0  
 add $t2 , $t2 , $t1  
 add $t2 , $t2 , 19 
 div $t2 , $t2 , 32
 mfhi $t2
#Print P
ori $v0, $zero, 4
la $a0, P
syscall
ori $v0, $zero, 1
la $a0, ($t2)
syscall


## Month  == $s1 and Day == $s2
 or $s1, $t1 , $zero    #N
  or $s2 , $t2 , $zero   #P

# Print the day and month for easter
ori $v0, $zero, 4
la $a0, easter
syscall
ori $v0, $zero, 1
la $a0, ($s1)
syscall
ori $v0, $zero, 4
la $a0, day
syscall
ori $v0, $zero, 1
la $a0, ($s2)
syscall
ori $v0, $zero, 4
la $a0, period
syscall


  

#Endprogram
addi $v0, $zero, 10
syscall



.data 
promptYear: .asciiz "Please enter the year: "
easter: .asciiz "\n\nEaster falls on month "
day: .asciiz " day "
period: ".\n"
A: "A: "
B: "\nB: "
C: "\nC: "
D: "\nD: "
E: "\nE: "
G: "\nG: "
H: "\nH: "
M: "\nM: "
J: "\nJ: "
K: "\nK: "
L: "\nL: "
N: "\nN: "
P: "\nP: "