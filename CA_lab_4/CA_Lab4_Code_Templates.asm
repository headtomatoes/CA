# Computer Architecture Lab 4: MIPS Code Templates

This document provides code templates for each exercise. Adapt these to your specific requirements and student ID.

---

## EXERCISE 1.1: BASIC HEX CONVERTER (0-15)

### Template: lab4_1_1.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 1.1: Hex Converter (0-15)
# Author: [Your Name]
# Date: [Date]
# Description: Convert single-digit hex (0-15) to hexadecimal representation
#===========================================================================

.data
    prompt1:      .asciiz "Input an integer ranging from (0 - 15): "
    prompt2:      .asciiz "Output the hexa-decimal form: "
    errMsg:       .asciiz "Invalid input (0-15)\n"
    prefix:       .asciiz "0x"
    newline:      .asciiz "\n"

.text
    .globl main

main:
    # Print input prompt
    li $v0, 4
    la $a0, prompt1
    syscall
    
    # Read integer input
    li $v0, 5
    syscall
    # Result stored in $v0
    
    # Move input to $t0, release $v0
    move $t0, $v0
    
    # Print output label
    li $v0, 4
    la $a0, prompt2
    syscall
    
    # Validate: input < 0?
    blt $t0, $0, printError
    
    # Validate: input > 15?
    slti $t1, $t0, 16
    beq $t1, $0, printError
    
    # Input is valid (0-15), continue
    
    # Print "0x" prefix
    li $v0, 4
    la $a0, prefix
    syscall
    
    # Check if input < 10
    slti $t1, $t0, 10
    bne $t1, $0, printNum
    
    # Input >= 10, convert to character (A-F)
    # Formula: character = input + 55 (A=65, B=66, ..., F=70)
    addi $v0, $t0, 55
    
    # Print character
    li $v0, 11
    move $a0, $v0
    syscall
    
    j end_program
    
printNum:
    # Print single digit (0-9)
    li $v0, 1
    move $a0, $t0
    syscall
    
    j end_program
    
printError:
    # Print error message
    li $v0, 4
    la $a0, errMsg
    syscall
    
end_program:
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10
    syscall
```

---

## EXERCISE 1.2: HEX CONVERTER WITH PROCEDURE

### Template: lab4_1_2.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 1.2: Hex with Procedure
# Author: [Your Name]
# Date: [Date]
# Description: Convert single-digit hex using reusable procedure
#===========================================================================

.data
    prompt1:      .asciiz "Input an integer ranging from (0 - 15): "
    prompt2:      .asciiz "Output the hexa-decimal form: "
    errMsg:       .asciiz "Invalid input (0-15)\n"
    prefix:       .asciiz "0x"
    newline:      .asciiz "\n"

.text
    .globl main

main:
    # Print input prompt
    li $v0, 4
    la $a0, prompt1
    syscall
    
    # Read integer input
    li $v0, 5
    syscall
    # Result in $v0
    
    # Move input to $a0 (procedure parameter)
    move $a0, $v0
    
    # Print output label
    li $v0, 4
    la $a0, prompt2
    syscall
    
    # Call procedure: printHex($a0)
    jal printHex
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10
    syscall

#===========================================================================
# Procedure: printHex
# Input: $a0 = integer to print (0-15)
# Output: Prints hexadecimal representation to console
# Uses: $t0, $t1, $v0, $a0
#===========================================================================
printHex:
    # Move parameter to working register
    move $t0, $a0
    
    # Validate: input < 0?
    blt $t0, $0, hex_error
    
    # Validate: input > 15?
    slti $t1, $t0, 16
    beq $t1, $0, hex_error
    
    # Valid input, continue
    
    # Print "0x" prefix
    li $v0, 4
    la $a0, prefix
    syscall
    
    # Check if input < 10
    slti $t1, $t0, 10
    bne $t1, $0, hex_printNum
    
    # Input >= 10, convert to character
    addi $v0, $t0, 55
    li $v0, 11
    move $a0, $v0
    syscall
    
    jr $ra

hex_printNum:
    # Print single digit
    li $v0, 1
    move $a0, $t0
    syscall
    
    jr $ra

hex_error:
    # Print error message
    li $v0, 4
    la $a0, errMsg
    syscall
    
    jr $ra
```

---

## EXERCISE 1.3: FULL 32-BIT HEX CONVERTER

### Template: lab4_1_3.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 1.3: 32-bit Hex Converter
# Author: [Your Name]
# Date: [Date]
# Description: Convert any 32-bit integer to hexadecimal
# Test Value: [Use your student ID numerical part]
#===========================================================================

.data
    prompt:       .asciiz "Input a 32-bit integer: "
    output:       .asciiz "Hexadecimal: "
    prefix:       .asciiz "0x"
    newline:      .asciiz "\n"

.text
    .globl main

main:
    # Print input prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read 32-bit integer
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 = input number
    
    # Print output label
    li $v0, 4
    la $a0, output
    syscall
    
    # Print "0x" prefix
    li $v0, 4
    la $a0, prefix
    syscall
    
    # Print "0x" and then each hex digit
    # Process 8 hex digits (bits 31-28, 27-24, ..., 3-0)
    
    li $s0, 7            # loop counter: 7 down to 0
    
hex_loop:
    # Extract one hex digit
    # Formula: digit = (number >> (counter * 4)) & 0x0F
    
    # Calculate shift amount: counter * 4
    mul $t1, $s0, 4      # $t1 = counter * 4
    
    # Shift right logical: srl $t1, $t0, $t1
    # But srl requires register for shift amount in some assemblers
    # Alternative: use rotate or conditional shifts
    
    # Using MARS: srl with immediate works
    # Unroll loop or use dynamic shifts
    
    # For clarity, unroll the loop (8 iterations):
    # Iteration 1: bits 31-28
    # Iteration 2: bits 27-24
    # ... etc
    
    # Let's use a simpler approach with explicit shifts:
    
    beq $s0, 7, shift_28
    beq $s0, 6, shift_24
    beq $s0, 5, shift_20
    beq $s0, 4, shift_16
    beq $s0, 3, shift_12
    beq $s0, 2, shift_8
    beq $s0, 1, shift_4
    beq $s0, 0, shift_0
    
    j hex_loop_end

shift_28:
    srl $t1, $t0, 28
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_24:
    srl $t1, $t0, 24
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_20:
    srl $t1, $t0, 20
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_16:
    srl $t1, $t0, 16
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_12:
    srl $t1, $t0, 12
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_8:
    srl $t1, $t0, 8
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_4:
    srl $t1, $t0, 4
    andi $t1, $t1, 0x0F
    j print_hex_digit

shift_0:
    andi $t1, $t0, 0x0F
    j print_hex_digit

print_hex_digit:
    # $t1 now contains digit (0-15)
    
    # Check if digit < 10
    slti $t2, $t1, 10
    bne $t2, $0, print_digit_num
    
    # Digit >= 10: print as character (A-F)
    addi $v0, $t1, 55    # Convert to ASCII: A=65, B=66, etc.
    li $v0, 11           # Syscall for print char
    move $a0, $v0
    syscall
    
    j continue_loop

print_digit_num:
    # Print digit (0-9)
    li $v0, 1
    move $a0, $t1
    syscall
    
continue_loop:
    # Decrement counter and continue
    addi $s0, $s0, -1
    
    # Check if counter >= 0
    bge $s0, $0, hex_loop

hex_loop_end:
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10
    syscall
```

**Alternative Simpler Version Using Loop with Register Shift:**

```assembly
    # For assemblers supporting dynamic shift:
    li $s0, 7
    li $s1, 28          # shift amount, decreases by 4 each iteration
    
hex_loop_alt:
    blt $s0, 0, hex_end
    
    srlv $t1, $t0, $s1  # shift right by variable amount
    andi $t1, $t1, 0x0F # mask to 4 bits
    
    # ... print digit (see above) ...
    
    addi $s0, $s0, -1
    addi $s1, $s1, -4
    j hex_loop_alt
    
hex_end:
```

---

## EXERCISE 2.1: FIBONACCI LOOP (NO FUNCTION)

### Template: lab4_2_1.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 2.1: Fibonacci Loop
# Author: [Your Name]
# Date: [Date]
# Description: Generate first 100 Fibonacci numbers using loop
#===========================================================================

.data
    header:       .asciiz "Fibonacci Series (First 100 terms):\n"
    term_label:   .asciiz "Term "
    colon:        .asciiz ": "
    newline:      .asciiz "\n"
    footer:       .asciiz "Computation complete.\n"

.text
    .globl main

main:
    # Print header
    li $v0, 4
    la $a0, header
    syscall
    
    # Initialize Fibonacci values
    li $s0, 1            # $s0 = previous term
    li $s1, 1            # $s1 = current term
    li $s2, 0            # $s2 = counter (0 to 99)
    
fib_loop:
    # Check loop condition: if counter >= 100, exit
    bge $s2, 100, fib_end
    
    # Print term number
    li $v0, 4
    la $a0, term_label
    syscall
    
    li $v0, 1
    addi $a0, $s2, 1    # term number is counter + 1
    syscall
    
    # Print colon and space
    li $v0, 4
    la $a0, colon
    syscall
    
    # Print current Fibonacci number
    li $v0, 1
    move $a0, $s1
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Calculate next Fibonacci number
    add $s3, $s0, $s1    # $s3 = prev + curr
    
    # Update: prev = curr, curr = next
    move $s0, $s1        # prev = current
    move $s1, $s3        # curr = next
    
    # Increment counter
    addi $s2, $s2, 1
    
    # Continue loop
    j fib_loop
    
fib_end:
    # Print footer
    li $v0, 4
    la $a0, footer
    syscall
    
    # Exit program
    li $v0, 10
    syscall
```

---

## EXERCISE 2.2: FIBONACCI WITH FUNCTION

### Template: lab4_2_2.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 2.2: Fibonacci Function
# Author: [Your Name]
# Date: [Date]
# Description: Generate Fibonacci numbers using function
# numOfTerms: [Use last 2 digits of your student ID]
#===========================================================================

.data
    header:       .asciiz "Fibonacci Series:\n"
    term_label:   .asciiz "Term "
    colon:        .asciiz ": "
    newline:      .asciiz "\n"
    footer:       .asciiz "Complete.\n"

.text
    .globl main

main:
    # Print header
    li $v0, 4
    la $a0, header
    syscall
    
    # Load number of terms (from student ID)
    # Example: if ID = IT20200456, use 56
    li $a0, 56          # CHANGE THIS to your value
    
    # Call fibonacci function
    jal fibonacci
    
    # Print footer
    li $v0, 4
    la $a0, footer
    syscall
    
    # Exit program
    li $v0, 10
    syscall

#===========================================================================
# Function: fibonacci
# Input: $a0 = number of terms to generate
# Output: Prints Fibonacci series
# Uses: $s0 (prev), $s1 (curr), $s2 (counter), $s3 (next)
#===========================================================================
fibonacci:
    # Save return address and parameter
    # Note: using $s registers, so we should save/restore if needed
    # For simplicity, we'll use them directly
    
    # Initialize
    li $s0, 1            # previous
    li $s1, 1            # current
    li $s2, 0            # counter
    move $s3, $a0        # save parameter for loop limit
    
fib_loop_func:
    # Check: if counter >= number of terms, return
    bge $s2, $s3, fib_return
    
    # Print term number
    li $v0, 4
    la $a0, term_label
    syscall
    
    li $v0, 1
    addi $a0, $s2, 1
    syscall
    
    # Print colon
    li $v0, 4
    la $a0, colon
    syscall
    
    # Print current value
    li $v0, 1
    move $a0, $s1
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Calculate next
    add $t0, $s0, $s1
    move $s0, $s1
    move $s1, $t0
    
    # Increment counter
    addi $s2, $s2, 1
    
    # Loop
    j fib_loop_func
    
fib_return:
    jr $ra
```

---

## EXERCISE 2.3: FIBONACCI RECURSIVE

### Template: lab4_2_3.s

```assembly
#===========================================================================
# Computer Architecture Lab 4 - Exercise 2.3: Fibonacci Recursive
# Author: [Your Name]
# Date: [Date]
# Description: Generate Fibonacci using recursion
#===========================================================================

.data
    header:       .asciiz "Fibonacci Recursive:\n"
    term_label:   .asciiz "F("
    equals:       .asciiz ") = "
    newline:      .asciiz "\n"
    footer:       .asciiz "Done.\n"

.text
    .globl main

main:
    # Print header
    li $v0, 4
    la $a0, header
    syscall
    
    # Generate Fibonacci terms 1 through 20 (or adjust as needed)
    li $s0, 1            # counter
    li $s1, 20           # limit
    
fib_main_loop:
    bgt $s0, $s1, fib_main_end
    
    # Print "F("
    li $v0, 4
    la $a0, term_label
    syscall
    
    # Print term number
    li $v0, 1
    move $a0, $s0
    syscall
    
    # Print ") = "
    li $v0, 4
    la $a0, equals
    syscall
    
    # Call recursive fib function
    move $a0, $s0
    jal fib
    
    # Print result (in $v0)
    li $v0, 1
    # Result already in $a0 = $v0, so...
    # Actually, need to print $v0
    move $a0, $v0
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Increment and loop
    addi $s0, $s0, 1
    j fib_main_loop
    
fib_main_end:
    # Print footer
    li $v0, 4
    la $a0, footer
    syscall
    
    # Exit
    li $v0, 10
    syscall

#===========================================================================
# Recursive Function: fib
# Input: $a0 = N (term number)
# Output: $v0 = F(N)
# Stack: saves $ra and intermediate values
#===========================================================================
fib:
    # Base case: if N <= 2, return 1
    slti $t0, $a0, 3     # $t0 = 1 if N < 3
    beq $t0, $0, fib_recursive
    
    # Base case
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
    
    # Save result of fib(N-1)
    addi $sp, $sp, -4
    sw $v0, 0($sp)
    
    # Restore N and compute fib(N-2)
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    addi $a0, $a0, -2
    
    # Call fib(N-2)
    jal fib
    
    # Add results: $v0 = fib(N-1) + fib(N-2)
    lw $t0, 0($sp)       # $t0 = fib(N-1)
    add $v0, $v0, $t0    # $v0 = fib(N-2) + fib(N-1)
    
    # Restore return address and stack
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
```

---

## TESTING & VERIFICATION

### Steps to Test Each Program:

1. **In MARS Simulator:**
   - File → New → Paste code
   - Assembler → Assemble (or click assemble icon)
   - Simulate → Run (or click run)
   - Or use Simulator → Step to trace execution

2. **For Debugging:**
   - Set breakpoints at key labels
   - Watch register values in the Registers window
   - Use Memory window to see data section

3. **Expected Outputs:**
   - **1.1**: Input 13 → Output: 0xD
   - **1.2**: Input 10 → Output: 0xA
   - **1.3**: Input 546263 → Output: 0x855D7
   - **2.1**: First 10 terms: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
   - **2.2**: Same as 2.1 but parameterized
   - **2.3**: Computes Fibonacci recursively

### Common Issues & Solutions:

| Problem | Solution |
|---------|----------|
| Infinite loop | Check loop condition and counter increment |
| Overflow in Fibonacci | Use unsigned or stop after F(47) |
| Procedure doesn't return | Verify jr $ra instruction exists |
| Wrong output character | Check ASCII offset (0=48, A=65, etc.) |
| Stack issues in recursion | Verify sp increments/decrements match |

---

## ADAPTATION TIPS

- Replace `56` in exercise 2.2 with last 2 digits of YOUR student ID
- Replace test values in 1.3 with values from YOUR student ID
- Adjust loop limits (100 terms) if needed for your assignment
- Add comments explaining YOUR specific logic choices
- Test with multiple inputs to verify correctness

