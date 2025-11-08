.data		# the data segment
header:     .asciiz "Fibonacci Series:\n"
term_label: .asciiz "Term "
colon:      .asciiz ": "
newline: 	.asciiz "\n"
footer:     .asciiz "Complete.\n"
.text		# the code segment
.globl main

main:
	# Print header
	la $a0, header
	li $v0, 4		
	syscall	
	
	# Load number of terms (from student ID)
	# Example: if ID = IT20200456, use 56
	# Change this to your student ID's last 2 digits
	li $a0, 56		# Number of terms to generate
	
	# Call fibonacci function
	jal fibonacci
	
	# Print footer
	la $a0, footer
	li $v0, 4
	syscall
	
	# Exit program
	li $v0, 10
	syscall

#===========================================================================
# Function: fibonacci
# Input: $a0 = number of terms to generate
# Output: Prints Fibonacci series
# Uses: $s0 (prev), $s1 (curr), $s2 (counter), $s3 (limit), $t0 (next)
#===========================================================================
fibonacci:
	# Initialize
	li $s0, 1			# previous term
	li $s1, 1			# current term
	li $s2, 0			# counter
	move $s3, $a0		# save parameter for loop limit
	
fib_loop_func:
	# Check: if counter >= number of terms, return
	bge $s2, $s3, fib_return
	
	# Print term number
	la $a0, term_label
	li $v0, 4
	syscall
	
	addi $a0, $s2, 1	# term number is counter + 1
	li $v0, 1
	syscall
	
	# Print colon
	la $a0, colon
	li $v0, 4
	syscall
	
	# Print current value
	move $a0, $s1
	li $v0, 1
	syscall
	
	# Print newline
	la $a0, newline
	li $v0, 4
	syscall
	
	# Calculate next Fibonacci number
	add $t0, $s0, $s1	# $t0 = prev + curr
	move $s0, $s1		# prev = curr
	move $s1, $t0		# curr = next
	
	# Increment counter
	addi $s2, $s2, 1
	
	# Loop
	j fib_loop_func
	
fib_return:
	jr $ra


