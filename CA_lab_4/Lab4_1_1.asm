.data		# the data segment
prompt:     .asciiz "Input an integer ranging from (0 - 15): "
output:     .asciiz "Output the hexa-decimal form: "
error: 		.asciiz "Unvalid input (0-15)\n"
prefix: 	.asciiz "0x"
.text		# the code segment
.globl main

main:
	# Print out the prompt
	la $a0, prompt		
	li $v0, 4		
	syscall	
	
	# Read in an integer & Assign to $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# Print out the result message first
	la $a0, output
	li $v0, 4
	syscall	
	
	# Branch
	
	# Buffer is the address of our string. It stored 100 empty value 
	# See this link to understand ascii code: https://www.asciitable.com/
	# References: Lab 2_4.s
	
	# Check if the value is in the valid range 0 <= $t0 <= 15
	blt	$t0, 0, printError	# if $t0 < $t1 then printError
	bgt	$t0, 15, printError	# if $t0 > $21 then printError
	
	# In hexa-decimal, in the decimal range, hex($t0) = dec($t0)
	# Otherwise, do conversion.
	
	# [1]: Print the prefix '0x'
	la $a0, prefix		 	# Print the prefix '0x'
	li $v0, 4		
	syscall	
	
	# [2]: Compute the value
	blt	$t0, 10, printNum 
	j printCharacter

# Print from 0 to 9
printNum:
	move $a0, $t0  # Print the number in $t0
	li $v0, 1
	syscall
	j end_program
	
# Print from 10 to 15
printCharacter:
	# Convert to ASCII: A=65, B=66, ..., F=70
	addi $t0, $t0, -10
	addi $t0, $t0, 65
	
	move $a0, $t0  # Print the character in $t0
	li $v0, 11
	syscall
	j end_program
	
# Print out the "error" and stop
printError:	
	la $a0, error
	li $v0, 4		
	syscall	
	j end_program

end_program:
	# Exit program
	li $v0, 10
	syscall

