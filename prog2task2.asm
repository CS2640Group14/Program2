# CS 2640
# Date: 11/6/24
# Name: Roman Sailes, Lucia Maturino Iniguez
# Program 2, Task 2
# Goals:
# 1) Take two ints from user, x and y
# 2) Loop to find x ^ y
# 3) Return result to user

.macro openMsg
	li $v0, 4
	la $a0, openMsg1
	syscall
	
	li $v0, 4
	la $a0, openMsg2
	syscall
	
	li $v0, 4
	la $a0, openMsg3
	syscall
.end_macro

.macro exit
	li $v0, 10
	syscall
.end_macro

.data
openMsg1: .asciiz "This program asks the user to input a value for 'x' and 'y'."
openMsg2: .asciiz "\nThen, it finds x to the power of y."
openMsg3: .asciiz "\nFor example, 2 to the power of 3 is 8."
promptX: .asciiz "\n\n\nEnter a number for 'x': "
promptY: .asciiz "\nEnter a number for 'y': "
loopCount: .word 1
foundPower: .asciiz "\n'x' to the power of 'y' is: "

.text
main:
	# Prints all opening messages
	openMsg
	
	# Prompts user for x integer
	li $v0, 4
	la $a0, promptX
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	# Prompts user for y integer
	li $v0, 4
	la $a0, promptY
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	# Loop count variable
	lw $t0, loopCount
	la $t3, ($t1)
	
	beq $t2, 0, powIsZero
	beq $t2, 1, powIsOne
	bgt $t2, 1, getPower
	
powIsZero:
	li $t3, 1
	j exit
	
powIsOne:
	move $t3, $t1
	j exit
	
getPower:
	mul $t3, $t3, $t1
	
	add $t0, $t0, 1
	
	blt $t0, $t2, getPower
	
exit:
	li $v0, 4
	la $a0, foundPower
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	exit
