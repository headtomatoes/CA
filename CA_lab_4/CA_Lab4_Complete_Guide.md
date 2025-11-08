# Computer Architecture Lab 4: Complete Step-by-Step Guide

## Overview
This lab focuses on MIPS assembly programming with two major exercises:
- **Exercise 1 (50 pts)**: Int2Hex Converter with increasing complexity
- **Exercise 2 (50 pts)**: Fibonacci Series with different implementations

---

## EXERCISE 1: INT2HEX CONVERTER (50 points)

### Task 1.1: Basic Hex Converter (0-15) - `lab4_1_1.s`

**Objective**: Read an unsigned integer (0-15) and print it in hexadecimal format.

**Step 1: Understand the Algorithm**
- Input validation: Check if 0 ≤ input ≤ 15
- For 0-9: Print as-is with "0x" prefix
- For 10-15: Print as hex characters (A-F) with "0x" prefix
- Invalid: Print error message

**Step 2: Code Structure**
```
Data Segment:
  - Input prompt message
  - Output message
  - Error message

Code Segment:
  1. Print input prompt
  2. Read integer input (syscall 5) → stored in $v0
  3. Move input to $t0
  4. Validate range: 0 ≤ $t0 ≤ 15
  5. Print "0x" prefix (syscall 4)
  6. Branch: if $t0 < 10, print number; else print character (A-F)
  7. End program (syscall 10)
```

**Step 3: Key Instructions**
- `blt $t0, $0, printError` - Branch if less than 0
- `slti $t1, $t0, 16` - Set if less than 16
- `beq $t1, $0, printError` - Branch if not less than 16 (i.e., > 15)
- `blt $t0, 10, printNum` - Branch if less than 10
- For characters (10-15): Add 55 to input → ASCII codes (65-70 = A-F)

**Step 4: Testing Cases**
- Input 9 → Output: 0x9
- Input 13 → Output: 0xD
- Input 16 → Output: "Invalid input (0-15)"

**What to Learn**:
- System calls (read input, print string, print character)
- Conditional branching (blt, beq)
- Address calculation and label jumping
- Register management

---

### Task 1.2: Hex Converter with Procedure - `lab4_1_2.s`

**Objective**: Create a reusable `printHex(int num)` procedure.

**Step 1: Understand Procedure Conventions**
- Caller passes argument in $a0
- Procedure can use $t0-$t9 (temporary registers)
- Save/restore $s0-$s7 if used
- Return address in $ra
- Return from procedure: `jr $ra`

**Step 2: Procedure Structure**
```
printHex:
  # Input: $a0 = number to print
  # Output: printed hex value
  # Uses: $t0, $t1 for temporary values
  
  1. Move $a0 to $t0
  2. Validate range (same as 1.1)
  3. Print "0x" prefix
  4. Check if < 10 or >= 10
  5. Print appropriate format
  6. Return: jr $ra
```

**Step 3: Main Program Flow**
```
1. Print input prompt
2. Read input → $v0
3. Move $v0 → $a0 (prepare argument)
4. jal printHex (jump and link)
5. End program
```

**Step 4: Key Differences from 1.1**
- No input validation in main (can be added in procedure)
- Code reusability: Same `printHex` used for multiple numbers
- Parameter passing convention ($a0)
- Function call overhead (`jal`, `jr $ra`)

**Step 5: Testing**
- Call with different values: 3, 7, 10, 14, 15
- Verify procedure returns correctly

**What to Learn**:
- Function call conventions
- Parameter passing ($a0-$a3)
- Return address ($ra) management
- Stack frames (if procedure needs them)

---

### Task 1.3: Full 32-bit Hex Converter - `lab4_1_3.s`

**Objective**: Convert any 32-bit integer to hexadecimal (use student ID's numerical part).

**Step 1: Algorithm (Pseudocode)**
```
printHex32bit(int num):
  print "0x"
  for i = 7 downto 0:
    hex_digit = (num >> (i*4)) & 0xF
    if hex_digit < 10:
      print hex_digit
    else:
      print character (A-F)
```

**Step 2: Key Concept - Bit Shifting**
- Extract each hex digit (4 bits at a time)
- Start from most significant hex digit (bits 31-28)
- Shift right by 4 bits each iteration
- Use AND 0x0F to isolate lower 4 bits

**Step 3: Code Implementation**
```
Data Segment:
  - Input prompt
  - Output prompt
  - Messages

Code Segment:
  1. Read 32-bit integer input (syscall 5)
  2. Move to $t0
  3. Print "0x" prefix
  4. Loop 8 times (for 8 hex digits):
     - Extract digit: srl, andi $t1, $t0, 0xF
     - Branch: digit < 10 ? yes: print number, no: print character
     - Shift $t0 right by 4 bits: srl $t0, $t0, 4
  5. End program
```

**Step 4: MIPS Instructions Needed**
- `srl $t1, $t0, 4` - Shift right logical
- `andi $t1, $t0, 0xF` - AND immediate (mask 4 bits)
- `addiu $t0, $t0, 55` - Add for ASCII conversion
- Loop counter management

**Step 5: Example**
- Input: 546263 (decimal)
- Binary: 00000000 00001000 01010101 11010111
- Hex: 0x0008 55D7 → Output: 0x855D7
- Extract: 0, 0, 0, 8, 5, 5, D, 7

**Step 6: Testing Cases**
- Input 255 → Output: 0x000000FF
- Input 546263 → Output: 0x0855D7
- Input 0xFFFFFFFF → Output: 0xFFFFFFFF

**What to Learn**:
- Bit manipulation (shift, AND operations)
- Loop implementation in assembly
- Full 32-bit number handling
- Comparison between procedures for different ranges

---

## EXERCISE 2: FIBONACCI SERIES (50 points)

### Task 2.1: Basic Loop (No Function) - `lab4_2_1.s`

**Objective**: Generate first 100 Fibonacci terms using a counting loop.

**Step 1: Fibonacci Definition**
- F(1) = 1, F(2) = 1
- F(n) = F(n-1) + F(n-2) for n > 2
- Series: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...

**Step 2: Algorithm (Pseudocode)**
```
prev = 1
curr = 1
count = 0

Loop while count < 100:
  print curr
  next = prev + curr
  prev = curr
  curr = next
  count++
```

**Step 3: Register Assignment**
- `$s0` = previous term
- `$s1` = current term
- `$s2` = loop counter (0 to 99)
- `$s3` = next term

**Step 4: Code Structure**
```
Data Segment:
  - Output messages
  - Newline characters

Code Segment:
  1. Initialize: $s0=1, $s1=1, $s2=0
  2. Print current term and newline
  3. Calculate next: add $s3, $s0, $s1
  4. Update: move $s0 ← $s1, move $s1 ← $s3
  5. Increment counter: addi $s2, $s2, 1
  6. Check condition: blt $s2, 100, loop
  7. Exit program
```

**Step 5: Testing**
- First 5 terms: 1, 1, 2, 3, 5
- 10th term: 55
- Output all 100 terms

**Important Considerations**:
1. **Overflow**: After ~40 terms, values exceed 32-bit signed integer
   - Solutions: Use unsigned, use floating-point, scale results
2. **Register usage**: Save $s0-$s3 on stack if needed

**What to Learn**:
- Loop implementation (addi, blt, beq)
- Counter-based iteration
- Data hazards (dependencies between instructions)
- Overflow detection and handling

---

### Task 2.2: Using Function - `lab4_1_2.s`

**Objective**: Refactor to use `void fibonacci(int numOfTerms)` function.

**Step 1: Use Student ID**
- Extract last 2 digits from student ID → numOfTerms
- Example: ID 123456 → numOfTerms = 56

**Step 2: Function Signature**
```
fibonacci:
  # Input: $a0 = numOfTerms
  # Output: printed Fibonacci series
  # Uses: $s0, $s1, $s2, $s3
```

**Step 3: Modified Code Structure**
```
Main Program:
  1. Load numOfTerms value (from student ID)
  2. Move to $a0
  3. jal fibonacci (call function)
  4. Exit

fibonacci procedure:
  1. Initialize: $s0=1, $s1=1, $s2=0
  2. Loop (same as 2.1, but use $a0 as limit):
     - Check: blt $s2, $a0, loop
  3. Return: jr $ra
```

**Step 4: Key Differences from 2.1**
- Parameterized by numOfTerms
- Can call with different limits
- Reusable procedure
- Parameter passing via $a0

**Step 5: Testing**
- Call with 10 → Print first 10 terms
- Call with 20 → Print first 20 terms
- Call with custom student ID value

**What to Learn**:
- Procedure design and reusability
- Parameter passing to functions
- Loop limit via parameters
- Stack frame management (if needed)

---

### Task 2.3: Recursive Implementation - `lab4_1_3.s`

**Objective**: Implement recursive Fibonacci: `int fib(int N)`.

**Step 1: Recursive Definition**
```
fib(N):
  if N ≤ 2: return 1
  else: return fib(N-1) + fib(N-2)
```

**Step 2: Function Structure**
```
fib:
  # Input: $a0 = N
  # Output: $v0 = F(N)
  # Uses: $ra (return address on stack)
  
  1. Check base case: if $a0 ≤ 2, return 1
  2. Recursive case:
     - Save $ra to stack
     - Call fib(N-1), save result
     - Call fib(N-2), save result
     - Add results
     - Restore $ra from stack
     - Return to caller
```

**Step 3: Stack Management**
```
When entering fib (N > 2):
  1. addi $sp, $sp, -8    (allocate 2 words)
  2. sw $ra, 4($sp)       (save return address)
  3. ... recursive calls ...
  4. lw $ra, 4($sp)       (restore return address)
  5. addi $sp, $sp, 8     (deallocate)
  6. jr $ra
```

**Step 4: Implementation Details**
```
fib procedure:
  # Base case
  slti $t0, $a0, 3        # $t0 = 1 if N < 3
  beq $t0, $0, recursive  # if N >= 3, go recursive
  
  # Base case: return 1
  addi $v0, $0, 1
  jr $ra
  
recursive:
  # Save state
  addi $sp, $sp, -8
  sw $ra, 4($sp)
  sw $a0, 0($sp)
  
  # Call fib(N-1)
  addi $a0, $a0, -1
  jal fib
  
  # Save result
  sw $v0, 0($sp)
  
  # Restore N and call fib(N-2)
  lw $a0, 0($sp)
  addi $a0, $a0, -2
  jal fib
  
  # Add results
  lw $t0, 0($sp)          # $t0 = fib(N-1)
  add $v0, $v0, $t0       # $v0 = fib(N-2) + fib(N-1)
  
  # Restore and return
  lw $ra, 4($sp)
  addi $sp, $sp, 8
  jr $ra
```

**Step 5: Print Results**
- Need wrapper function to call `fib(i)` for i = 1 to N
- Print each result in order
- Use floating-point if scaling needed

**Step 6: Testing**
- fib(5) = 5
- fib(10) = 55
- fib(15) = 610

**Call Stack Example for fib(4)**:
```
Call: fib(4)
  → Call: fib(3)
    → Call: fib(2) → returns 1
    → Call: fib(1) → returns 1
    → returns 2
  → Call: fib(2) → returns 1
  → returns 3
```

**Performance Note**:
- Exponential time complexity O(2^N)
- Very slow for N > 25
- Consider memoization or iterative for larger values

**What to Learn**:
- Recursive function calls
- Stack frame management
- Saving/restoring registers
- Parameter passing in nested calls
- Base cases and recursive cases

---

## REPORT STRUCTURE TEMPLATE

### For Each Exercise, Include:

1. **Objectives** (1-2 paragraphs)
   - What the exercise aims to teach
   - Key concepts

2. **Algorithm** (1-2 paragraphs)
   - Pseudocode or flowchart
   - Step-by-step logic

3. **MIPS Implementation** (2-3 paragraphs)
   - Code structure overview
   - Key instructions used
   - Register assignments

4. **Code with Comments** 
   - Full assembly code
   - Line-by-line explanations

5. **Execution Examples**
   - Test cases with expected outputs
   - Screenshots from debugger (if available)
   - Register states at key points

6. **Key Learnings**
   - What concepts were reinforced
   - Challenges encountered
   - Solutions implemented

7. **Comparison** (for multi-part exercises)
   - Differences between 1.1 vs 1.2 vs 1.3
   - Advantages/disadvantages of each approach
   - Code reusability and efficiency

---

## COMMON SYSTEM CALLS REFERENCE

| Syscall # | Name | Input | Output |
|-----------|------|-------|--------|
| 1 | Print Integer | $a0 = int | Print to console |
| 4 | Print String | $a0 = string address | Print to console |
| 5 | Read Integer | - | $v0 = integer read |
| 10 | Exit | - | Program terminates |
| 11 | Print Character | $a0 = ASCII code | Print character |

---

## DOCUMENTATION CHECKLIST

- [ ] All code files created (lab4_1_1.s, lab4_1_2.s, lab4_1_3.s, lab4_2_1.s, lab4_2_2.s, lab4_2_3.s)
- [ ] Each file has header comments (assignment, date, author)
- [ ] Each section has inline comments explaining logic
- [ ] Algorithm/pseudocode provided before code
- [ ] Test cases with sample outputs documented
- [ ] Screenshots/captures showing execution in Mars simulator
- [ ] Explanations of register usage and memory management
- [ ] Comparisons between different implementations
- [ ] What to learn sections completed
- [ ] Edge cases tested (overflow, invalid input, boundary conditions)
- [ ] Proper formatting and spacing for readability
- [ ] References to helpful resources included

---

## TIPS FOR SUCCESS

1. **Test Incrementally**: Write and test each procedure separately
2. **Use MARS Debugger**: Step through code to verify logic
3. **Watch Register Values**: Monitor how values change through execution
4. **Document as You Go**: Write comments while coding is fresher
5. **Compare Approaches**: Analyze trade-offs between different implementations
6. **Handle Edge Cases**: Test boundaries and error conditions
7. **Reuse Code**: Learn from each exercise to improve subsequent ones
8. **Review Concepts**: Understand WHY each instruction is needed

---

## RESOURCES

- MIPS Assembly Reference: https://en.wikibooks.org/wiki/MIPS_Assembly/
- Syscall Help: https://courses.missouristate.edu/KenVollmar/MARS/
- Pseudoinstructions: https://en.wikibooks.org/wiki/MIPS_Assembly/Pseudoinstructions
