.data		# the data segment
prompt:     .asciiz "Input an integer ranging from (0 - 15): "
output:     .asciiz "Output the hexa-decimal form: "
error: 		.asciiz "Unvalid input (0-15)\n"
prefix: 	.asciiz "0x"
newline:	.asciiz "\n"
.text		# the code segment
.globl main

main:
	# Print out the prompt
	la $a0, prompt		
	li $v0, 4		
	syscall	
	
	# Read in an integer
	li $v0, 5
	syscall
	move $t9, $v0		# Temporarily store input
	
	# Print out the result message
	la $a0, output
	li $v0, 4
	syscall	
	
	# Move input to $a0 for procedure parameter
	move $a0, $t9
	
	# Call the printHex procedure
	jal printHex
	
	# Print newline
	la $a0, newline
	li $v0, 4
	syscall
	
	# Exit program
	li $v0, 10
	syscall

#===========================================================================
# Procedure: printHex
# Input: $a0 = integer to print (0-15)
# Output: Prints hexadecimal representation to console
# Uses: $t0, $t1
#===========================================================================
printHex:
	# Move parameter to working register
	move $t0, $a0
	
	# Validate: input < 0?
	blt $t0, 0, hex_error
	
	# Validate: input > 15?
	bgt $t0, 15, hex_error
	
	# Valid input, print "0x" prefix
	la $a0, prefix
	li $v0, 4
	syscall
	
	# Check if input < 10
	blt $t0, 10, hex_printNum
	
	# Input >= 10, convert to character (A-F)
	addi $t0, $t0, -10
	addi $t0, $t0, 65	# ASCII: A=65, B=66, ..., F=70
	
	move $a0, $t0
	li $v0, 11
	syscall
	jr $ra

hex_printNum:
	# Print single digit (0-9)
	move $a0, $t0
	li $v0, 1
	syscall
	jr $ra

hex_error:
	# Print error message
	la $a0, error
	li $v0, 4
	syscall
	jr $ra

