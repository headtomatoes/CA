##	lab1_integer_double.s 
##	This program read in an integer and double it

#########################################################
#					DATA SEGMENT						#
#	This is where all strings, constants are declared	#
#########################################################

		.data		# the data segment
prompt:		.asciiz	"Enter an integer: "
result: 	.asciiz "The result is: "
newline:    .asciiz "\n"

#########################################################
#					TEXT SEGMENT						#
#	This is where all the instructions reside			#
#########################################################

		.text		# the code segment
		.globl main
main:
	# print out the prompt: "Enter an integer" --> line 10
	la $a0, prompt		
	li $v0, 4		
	syscall		
	
	# read in an integer
	li $v0, 5	# input the integer from keyboard, user input it the keyboard, the number is stored into v0
	syscall  # store the value from keyboard to v0 register
	move $t0, $v0 # copy the value of $v0 to $t0
	
	# double the input
	sll $t0, $t0, 1 
	# assumption t0=2 --> t0=10
	# shift left t0 1 bit --> t0=100 --> t0=4
	
	
	# print out the result message
	la $a0, result # line 11 The result is
	li $v0, 4
	syscall	
	
	# print out the doubled integer
	move $a0, $t0 
	li $v0, 1		
	syscall	

	# print out the newline
	la $a0, newline
	li $v0, 4
	syscall	

	jr $ra			# return to caller (__start) 
