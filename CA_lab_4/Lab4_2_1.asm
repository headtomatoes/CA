.data		# the data segment
header:     .asciiz "Fibonacci Series (First 100 terms):\n"
term_label: .asciiz "Term "
colon:      .asciiz ": "
newline: 	.asciiz "\n"
footer:     .asciiz "Computation complete.\n"
.text		# the code segment
.globl main

main:
	# Print header
	la $a0, header
	li $v0, 4		
	syscall	
	
	# Initialize Fibonacci values
	li $s0, 1			# $s0 = previous term (F0 = 1)
	li $s1, 1			# $s1 = current term (F1 = 1)
	li $s2, 0			# $s2 = counter (0 to 99)
	
fib_loop:
	# Check loop condition: if counter >= 100, exit
	bge $s2, 100, fib_end
	
	# Print term number
	la $a0, term_label
	li $v0, 4
	syscall
	
	addi $a0, $s2, 1	# term number is counter + 1
	li $v0, 1
	syscall
	
	# Print colon and space
	la $a0, colon
	li $v0, 4
	syscall
	
	# Print current Fibonacci number
	move $a0, $s1
	li $v0, 1
	syscall
	
	# Print newline
	la $a0, newline
	li $v0, 4
	syscall
	
	# Calculate next Fibonacci number
	add $s3, $s0, $s1	# $s3 = prev + curr
	
	# Update: prev = curr, curr = next
	move $s0, $s1		# prev = current
	move $s1, $s3		# curr = next
	
	# Increment counter
	addi $s2, $s2, 1
	
	# Continue loop
	j fib_loop

fib_end:
	# Print footer
	la $a0, footer
	li $v0, 4
	syscall
	
	# Exit program
	li $v0, 10
	syscall


