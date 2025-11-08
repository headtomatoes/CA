.data		# the data segment
prompt:     .asciiz "Input a 32-bit integer: "
output:     .asciiz "Hexadecimal: "
prefix: 	.asciiz "0x"
newline:	.asciiz "\n"
.text		# the code segment
.globl main

main:
	# Print out the prompt
	la $a0, prompt		
	li $v0, 4		
	syscall	
	
	# Read in a 32-bit integer
	li $v0, 5
	syscall
	move $t0, $v0		# $t0 = input number
	
	# Print out the result message
	la $a0, output
	li $v0, 4
	syscall	
	
	# Print "0x" prefix
	la $a0, prefix
	li $v0, 4
	syscall
	
	# Process 8 hex digits (32 bits = 8 hex digits)
	# We'll extract each nibble (4 bits) from left to right
	li $s0, 7			# Loop counter: 7 down to 0 (8 digits total)
	
hex_loop:
	blt $s0, 0, hex_loop_end
	
	# Calculate shift amount: counter * 4
	mul $t1, $s0, 4		# $t1 = shift amount
	
	# Shift right to get the desired nibble
	srlv $t2, $t0, $t1	# $t2 = number >> shift
	andi $t2, $t2, 0x0F	# Mask to get only 4 bits (0-15)
	
	# Check if digit < 10
	blt $t2, 10, print_digit_num
	
	# Digit >= 10: print as character (A-F)
	addi $t3, $t2, -10
	addi $t3, $t3, 65	# Convert to ASCII: A=65, B=66, ..., F=70
	
	move $a0, $t3
	li $v0, 11
	syscall
	j continue_loop

print_digit_num:
	# Print digit (0-9)
	move $a0, $t2
	li $v0, 1
	syscall

continue_loop:
	# Decrement counter and continue
	addi $s0, $s0, -1
	j hex_loop

hex_loop_end:
	# Print newline
	la $a0, newline
	li $v0, 4
	syscall
	
	# Exit program
	li $v0, 10
	syscall

