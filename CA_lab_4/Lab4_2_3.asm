.data		# the data segment
header:     .asciiz "Fibonacci Recursive:\n"
term_label: .asciiz "F("
equals:     .asciiz ") = "
newline: 	.asciiz "\n"
footer:     .asciiz "Done.\n"
.text		# the code segment
.globl main

main:
	# Print header
	la $a0, header
	li $v0, 4		
	syscall	
	
	# Generate Fibonacci terms 1 through 20
	# (Note: Recursive is slow, so we limit to 20 terms)
	li $s0, 1			# counter
	li $s1, 20			# limit
	
fib_main_loop:
	bgt $s0, $s1, fib_main_end
	
	# Print "F("
	la $a0, term_label
	li $v0, 4
	syscall
	
	# Print term number
	move $a0, $s0
	li $v0, 1
	syscall
	
	# Print ") = "
	la $a0, equals
	li $v0, 4
	syscall
	
	# Call recursive fib function
	move $a0, $s0
	jal fib
	
	# Print result (in $v0)
	move $a0, $v0
	li $v0, 1
	syscall
	
	# Print newline
	la $a0, newline
	li $v0, 4
	syscall
	
	# Increment and loop
	addi $s0, $s0, 1
	j fib_main_loop

fib_main_end:
	# Print footer
	la $a0, footer
	li $v0, 4
	syscall
	
	# Exit
	li $v0, 10
	syscall

#===========================================================================
# Recursive Function: fib
# Input: $a0 = N (term number)
# Output: $v0 = F(N)
# Stack: saves $ra and intermediate values
# Base case: F(1) = 1, F(2) = 1
# Recursive case: F(N) = F(N-1) + F(N-2)
#===========================================================================
fib:
	# Base case: if N <= 2, return 1
	slti $t0, $a0, 3	# $t0 = 1 if N < 3
	beq $t0, $0, fib_recursive
	
	# Base case: return 1
	li $v0, 1
	jr $ra

fib_recursive:
	# Save return address and current argument
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	# Call fib(N-1)
	addi $a0, $a0, -1
	jal fib
	
	# Save result of fib(N-1) on stack
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	
	# Restore N and compute N-2
	lw $a0, 4($sp)
	addi $a0, $a0, -2
	
	# Call fib(N-2)
	jal fib
	
	# Add results: $v0 = fib(N-1) + fib(N-2)
	lw $t0, 0($sp)		# $t0 = fib(N-1)
	add $v0, $v0, $t0	# $v0 = fib(N-2) + fib(N-1)
	
	# Restore stack and return address
	addi $sp, $sp, 4	# Pop fib(N-1) result
	lw $ra, 4($sp)		# Restore return address
	lw $a0, 0($sp)		# Restore original N (not needed but clean)
	addi $sp, $sp, 8	# Pop ra and N
	
	jr $ra


