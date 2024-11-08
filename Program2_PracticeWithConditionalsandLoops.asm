#Date: 11/17/2024
#Names: Lucia Maturino Iniguez and Roman Sailes
#Program 2: Practice with Conditionals and Loops
# To do: 
# 1) Print user menu
# 2) Continue or exit program for the user
# 3) Invalid input handling
# 4) Take two ints from user
# 5) Calculate 'x'to the power of 'y'
# GitHub:
# https://github.com/CS2640Group14/Program2.git

.data
menu: .asciiz "\n\n---------------MAIN MENU---------------\n(1) Get Letter Grade\n(2) Exit Program\n"
selection: .asciiz "Enter '1' or '2' for your selection: "
separation: .asciiz "\n---------------------------------------\n"
scorePrompt: .asciiz "\n\nPlease enter a score as an integer value: "
invalid: .asciiz "ERROR \nINCORRECT INPUT \nTry again\n"
grade: .asciiz "The grade is: "
newScore: .asciiz "\nWould you like to enter a new score?\n(Y)Yes (N)No: "
letterGradeA: .asciiz "A"
letterGradeB: .asciiz "B"
letterGradeC: .asciiz "C"
letterGradeD: .asciiz "D"
letterGradeF: .asciiz "F"
.text
main:
	#Task 1: Return a Letter Grade from User Input
	# 1) A user menu
	# 2) A main label, a looping label, exit label
	# 3) A way for the user to continue getting letter grades or choose to exit
	# 4) Invalid input handling (re-prompt user until correct input is entered)

loop:	
	#print menu
	li $v0, 4
	la $a0, menu
	syscall
	
	#prompt user
	li $v0, 4
	la $a0, selection
	syscall
	
	#get response
	li $v0, 5
	syscall
	move $t0, $v0
	
	# 1 or 2?
	# 1 --> continue
	beq $t0, 1, continue
	# 2 --> exit
	beq $t0, 2, exit

continue:
	# print scorePrompt 
	li $v0, 4
	la $a0, scorePrompt
	syscall
	
	# get integer
	li $v0, 5
	syscall
	move $t1, $v0
	
	# print score
	li $v0, 4
	la $a0, grade
	syscall
	
	# print A
	bge $t1, 90, gradeA
	
	# print B
	bge $t1, 80, gradeB
	
	# print C
	bge $t1, 70, gradeC
	
	# print D
	bge $t1, 60, gradeD
	
	# print F
	bge $t1, 0, gradeF
	
	# invalid score
	blt $t1, 0, invalidScore
	
gradeA:
	#print letter grade A
	li $v0, 4
	la $a0, letterGradeA
	syscall
	j newEntry
	
gradeB:
	#print letter grade B
	li $v0, 4
	la $a0, letterGradeB
	syscall
	j newEntry

gradeC:
	#print letter grade C
	li $v0, 4
	la $a0, letterGradeC
	syscall
	j newEntry		
			
gradeD:
	#print letter grade D
	li $v0, 4
	la $a0, letterGradeD
	syscall
	j newEntry						
												
gradeF:
	#print letter grade F
	li $v0, 4
	la $a0, letterGradeF
	syscall
	j newEntry

invalidScore: 
	#print error message
	li $v0, 4
	la $a0, invalid
	syscall
	j newEntry
	
newEntry: 
	# print space
	li $v0, 4
	la $a0, separation
	syscall
	
	# print new score prompt
	li $v0, 4
	la $a0, newScore
	syscall
	
	# gets character
	li $v0, 12
	syscall
	move $t2, $v0
	
	#Y or N?
	beq $t2, 'Y', continue
	beq $t2, 'N', loop
exit:	
	li $v0, 10
	syscall
	
