# Computer Architecture Lab 4: Implementation & Report Guide

## QUICK START CHECKLIST

### Before You Code:
- [ ] Review the lab requirements and understand both exercises
- [ ] Identify your student ID (for custom test values in 1.3 and 2.2)
- [ ] Set up MARS simulator (download if needed)
- [ ] Create a new project directory with 6 subdirectories for each .s file

### Code Files to Create:
1. `lab4_1_1.s` - Basic Hex (0-15)
2. `lab4_1_2.s` - Hex with procedure
3. `lab4_1_3.s` - Full 32-bit Hex converter
4. `lab4_2_1.s` - Fibonacci loop (no function)
5. `lab4_2_2.s` - Fibonacci with function
6. `lab4_2_3.s` - Fibonacci recursive

---

## REPORT SECTIONS (How to Organize)

### Front Matter (1-2 pages)
1. **Title Page**
   - Course: Computer Architecture (IT089IU)
   - Assignment: Laboratory 4
   - Date Submitted
   - Student Name & ID

2. **Table of Contents**
   - List all exercises and subsections

3. **Executive Summary** (1 page)
   - Brief overview of lab objectives
   - Summary of exercises
   - Key takeaways

---

### Exercise 1: Int2Hex Converter (15-20 pages)

#### Section 1.1: Basic Hexadecimal Converter

**Subsection 1.1.1: Objective and Concept**
- State the goal: Convert single digit (0-15) to hex
- Explain hexadecimal: Base-16 number system (0-9, A-F)
- Discuss conversion: 0-9 stay as is, 10-15 become A-F
- ASCII reminder: 'A' = 65, 'B' = 66, ... 'F' = 70, or A = 55+10, B = 55+11, etc.

**Subsection 1.1.2: Algorithm and Logic Flow**
- Provide pseudocode:
  ```
  Algorithm: printHex_0_15
  Input: user input between 0 and 15
  Output: hex representation (0x followed by digit or letter)
  
  1. Print prompt for user input
  2. Read integer from user → store in register
  3. Validate: if input < 0 OR input > 15
       → print error and exit
  4. Print "0x" prefix
  5. If input < 10
       → print input directly
     Else
       → add 55 to input (for ASCII conversion)
       → print as character
  6. End program
  ```

**Subsection 1.1.3: MIPS Implementation Details**
- Register assignment table:
  | Register | Purpose |
  |----------|---------|
  | $t0 | Input value |
  | $t1 | Comparison result |
  | $v0 | System call / temp |
  | $a0 | Syscall parameter |
  - Explain each key instruction:
    * `blt $t0, $0, printError` - Branch if negative
    * `slti $t1, $t0, 16` - Set if less than 16
    * `beq $t1, $0, printError` - Branch if equal to 0
    * `blt $t0, 10, printNum` - Branch if less than 10
    * `addi $v0, $t0, 55` - Add 55 for ASCII char (A-F)

**Subsection 1.1.4: Source Code**
Include full assembly code with line numbers and comments

**Subsection 1.1.5: Execution Trace**
- Show step-by-step trace for 2-3 test cases:
  * **Test Case 1: Input = 9**
    - Expected output: 0x9
    - Register trace table showing values at each key point
  * **Test Case 2: Input = 13**
    - Expected output: 0xD
    - ASCII calculation: 13 + 55 = 68 (decimal) = 'D'
  * **Test Case 3: Input = 16**
    - Expected output: "Invalid input"

**Subsection 1.1.6: Screenshots from MARS**
- Breakpoint at input validation
- Breakpoint at character printing
- Final output window

**Subsection 1.1.7: Analysis and Learning**
- How branching creates decision logic
- Register usage patterns
- System call conventions
- Address calculation for labels

---

#### Section 1.2: Hexadecimal with Procedure

**Subsection 1.2.1: Procedure Design**
- Explain function calling convention:
  * Arguments in $a0-$a3
  * Return value in $v0
  * Return address in $ra
  * Temporary registers: $t0-$t9
  * Saved registers: $s0-$s7

**Subsection 1.2.2: Comparison with 1.1**
- **Advantages of Procedure Approach:**
  - Code reusability (call multiple times)
  - Modularity and maintainability
  - Easier to test isolated components
  
- **Differences in Structure:**
  | Aspect | 1.1 | 1.2 |
  |--------|-----|-----|
  | Code location | All in main | Procedure + main |
  | Reusability | Single use | Multiple calls |
  | Parameters | None | $a0 = number |
  | Return method | N/A | jr $ra |
  | Code size | Smaller | Larger |

**Subsection 1.2.3: Implementation Steps**
1. Write procedure `printHex` that accepts $a0
2. Move logic from 1.1 into procedure
3. In main: prepare $a0, call with `jal printHex`
4. Procedure ends with `jr $ra`

**Subsection 1.2.4: Function Call Mechanism**
- Explain `jal` (Jump And Link):
  * Saves return address in $ra
  * Jumps to procedure label
  * Procedure uses `jr $ra` to return
  
- Illustration of call stack:
  ```
  Main Program:        Procedure:
  jal printHex  ----→  printHex:
  (next instr)  ←----    jr $ra
  ```

**Subsection 1.2.5: Source Code**
- Full code with comments
- Highlight differences from 1.1

**Subsection 1.2.6: Testing with Multiple Calls**
- Test cases showing multiple invocations:
  * Read input 1 → call printHex → output 0x1
  * Read input 5 → call printHex → output 0x5
  * Read input 12 → call printHex → output 0xC

**Subsection 1.2.7: Key Learnings**
- Function parameter passing
- Stack frame concepts (though not explicitly used here)
- Return address management
- Code organization and modularity

---

#### Section 1.3: Full 32-bit Hexadecimal Converter

**Subsection 1.3.1: Objective**
- Convert any 32-bit integer to hex format
- Use student ID's numeric portion for test value
- Example: If ID = IT20200123, use 20200123 as test input

**Subsection 1.3.2: Algorithm for 32-bit Conversion**
- Pseudocode for bit extraction:
  ```
  Algorithm: printHex32
  Input: 32-bit integer (in $a0)
  Output: 8 hexadecimal digits with "0x" prefix
  
  1. Print "0x" prefix
  2. Loop from bit position 28 down to 0, by steps of 4:
     hex_digit = (number >> bit_position) & 0x0F
     if hex_digit < 10:
       print hex_digit
     else:
       print character (A-F)
  ```

**Subsection 1.3.3: Bit Manipulation Concepts**
- **Shift Right Logical (srl)**:
  * `srl $t1, $t0, 4` moves all bits right by 4 positions
  * Effectively divides by 16
  
- **AND with Mask (andi)**:
  * `andi $t1, $t0, 0x0F` isolates lower 4 bits
  * Masks out upper bits to get single hex digit

- **Iteration Strategy**:
  * Loop counter: counts from 7 down to 0
  * Each iteration extracts one hex digit
  * Shift right by 4 bits each time

**Subsection 1.3.4: Step-by-Step Implementation**
1. Initialize loop counter ($s0 = 7)
2. Shift input right by (counter * 4) bits
3. Mask lower 4 bits
4. Check if digit (0-9 or A-F)
5. Print appropriate character
6. Decrement counter
7. Repeat until counter < 0

**Subsection 1.3.5: Source Code**
- Full implementation with detailed comments
- Show loop structure and register usage

**Subsection 1.3.6: Detailed Execution Example**
- **Example: Input = 546263 (decimal)**
  
  Binary representation:
  ```
  00000000 00001000 01010101 11010111
  ```
  
  Hex breakdown:
  ```
  Bits 31-28: 0000 = 0
  Bits 27-24: 0000 = 0
  Bits 23-20: 0000 = 0
  Bits 19-16: 1000 = 8
  Bits 15-12: 0101 = 5
  Bits 11-8:  0101 = 5
  Bits 7-4:   1101 = D (13)
  Bits 3-0:   0111 = 7
  
  Output: 0x0008_55D7 or simply 0x855D7
  ```

**Subsection 1.3.7: Test Cases with Traces**
- Test 1: Small number (255)
  - Binary: 0000...00FF → Output: 0x000000FF
- Test 2: Student ID number
  - Full trace showing all 8 digits
- Test 3: Large number (0xFFFFFFFF)
  - Output: 0xFFFFFFFF

**Subsection 1.3.8: Comparison: 1.1 vs 1.2 vs 1.3**
- Table comparing features:
  | Feature | 1.1 | 1.2 | 1.3 |
  |---------|-----|-----|-----|
  | Input range | 0-15 | 0-15 | 0-2³² |
  | Digits printed | 1 | 1 | 1-8 |
  | Loop needed | No | No | Yes |
  | Shift operations | No | No | Yes |
  | Complexity | Low | Low | Medium |

**Subsection 1.3.9: Key Learnings and Extensions**
- Bit manipulation in assembly
- Loop implementation for iteration
- Efficiency: Time complexity O(8) = O(1)
- Handling full word registers
- Potential extensions:
  * Binary output mode
  * Octal output mode
  * Custom base conversion

---

### Exercise 2: Fibonacci Series (15-20 pages)

#### Section 2.1: Fibonacci with Loop (No Function)

**Subsection 2.1.1: Fibonacci Concept**
- Definition: F(n) = F(n-1) + F(n-2), F(1)=1, F(2)=1
- First 10 terms: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
- Properties: Each term is sum of previous two

**Subsection 2.1.2: Algorithm**
```
Algorithm: Fibonacci_Loop
Input: (none, hardcoded 100 iterations)
Output: First 100 Fibonacci numbers

1. Initialize:
   prev = 1
   current = 1
   count = 0
   
2. Loop (100 times):
   a. Print current number
   b. next = prev + current
   c. prev = current
   d. current = next
   e. count++
   f. If count < 100, go to step 2a
   
3. Exit
```

**Subsection 2.1.3: Register Assignment**
- $s0 = previous term (initially 1)
- $s1 = current term (initially 1)
- $s2 = loop counter (0 to 99)
- $s3 = next term (temporary)

**Subsection 2.1.4: Implementation**
1. Data section: output messages, newlines
2. Main code: initialize registers
3. Loop label: print current → calculate next → update
4. Exit: print program end message

**Subsection 2.1.5: Source Code**
Complete assembly with line numbers and explanatory comments

**Subsection 2.1.6: Execution Output**
```
Term 1: 1
Term 2: 1
Term 3: 2
Term 4: 3
Term 5: 5
...
Term 100: [value exceeds 32-bit]
```

**Subsection 2.1.7: Overflow Discussion**
- **When Does Overflow Occur?**
  - F(45) ≈ 1.1 × 10⁹ (exceeds 32-bit signed: 2³¹-1 ≈ 2.1 × 10⁹)
  - F(46) ≈ 1.8 × 10⁹ (still fits)
  - F(47) ≈ 2.9 × 10⁹ (exceeds!)
  
- **Solutions:**
  - Use unsigned 32-bit: allows up to F(47)
  - Use 64-bit (two registers): extends to F(90+)
  - Use floating-point: loses precision but extends range
  - Check for overflow with `beq $t0, $t1, overflow` after addition

**Subsection 2.1.8: Key Learning Points**
- Counter-based loop (addi, blt)
- Register state management (shifting values)
- Dependency chains (each term depends on previous)
- System calls for output (print int, print string, print newline)

---

#### Section 2.2: Fibonacci with Function

**Subsection 2.2.1: Function Parameter**
- Extract last 2 digits of student ID
- Example: ID 20200456 → numOfTerms = 56
- This makes output configurable instead of hardcoded

**Subsection 2.2.2: Function Signature in MIPS**
```
fibonacci:
  # Input:  $a0 = number of terms to print
  # Output: prints Fibonacci series (void return)
  # Uses:   $s0, $s1, $s2, $s3 (saved registers)
```

**Subsection 2.2.3: Procedure Structure**
```
Main Program:
  1. Load numOfTerms (from student ID)
  2. li $a0, numOfTerms (load immediate)
  3. jal fibonacci (call procedure)
  4. Exit (syscall 10)

fibonacci procedure:
  1. Move $a0 to $t0 (parameter)
  2. Initialize: $s0=1, $s1=1, $s2=0
  3. Loop: blt $s2, $a0, continue
     (if $s2 < $a0, loop; else return)
  4. Same loop body as 2.1
  5. Return: jr $ra
```

**Subsection 2.2.4: Advantages Over 2.1**
- **Flexibility:** Can compute any number of terms
- **Reusability:** Call multiple times with different counts
- **Cleaner Main:** Logic isolated in procedure
- **Scalability:** Easier to add features (e.g., multiple calls)

**Subsection 2.2.5: Source Code**
Full implementation with function definition

**Subsection 2.2.6: Testing Multiple Invocations**
Show calling fibonacci with different values:
- fibonacci(10) → output first 10 terms
- fibonacci(20) → output first 20 terms
- fibonacci(X) → output first X terms (where X = last 2 digits of your ID)

**Subsection 2.2.7: Comparison: 2.1 vs 2.2**
| Aspect | 2.1 (Loop) | 2.2 (Function) |
|--------|-----------|---|
| Hardcoded limit | 100 | Parameterized |
| Reusability | No | Yes |
| Main code | Contains all logic | Calls function |
| Parameter passing | N/A | Via $a0 |
| Code organization | Monolithic | Modular |

---

#### Section 2.3: Fibonacci Recursive

**Subsection 2.3.1: Recursion Concept**
- Definition: Function that calls itself
- Base case: fib(1)=1, fib(2)=1
- Recursive case: fib(n) = fib(n-1) + fib(n-2)
- Call tree example for fib(5):
  ```
           fib(5)
          /      \
      fib(4)     fib(3)
      /    \     /    \
   fib(3) fib(2) fib(2) fib(1)
   /   \
  fib(2) fib(1)
  ```

**Subsection 2.3.2: Stack Frame Management**
- What gets saved on stack?
  * $ra (return address) - MUST save!
  * $a0 (if modified) - to recover original parameter
  - $v0 (if reused) - to preserve intermediate results
  
- Stack layout when entering recursive function:
  ```
  [sp+8]: OLD FRAME
  [sp+4]: $ra (return address)
  [sp+0]: $a0 (parameter or result storage)
  ```

**Subsection 2.3.3: Algorithm for fib(N)**
```
Algorithm: fibonacci_recursive
Input: $a0 = N (term number to calculate)
Output: $v0 = F(N)

1. BASE CASE: if N ≤ 2
   return 1 (set $v0 = 1, jr $ra)

2. RECURSIVE CASE: if N > 2
   a. Save $ra and $a0 on stack
   b. Calculate fib(N-1):
      - addi $a0, $a0, -1
      - jal fib
      - Save result
   c. Calculate fib(N-2):
      - Restore $a0, subtract 2
      - jal fib
      - Get result (in $v0)
   d. Add both results
   e. Restore $ra, deallocate stack
   f. Return: jr $ra
```

**Subsection 2.3.4: Detailed MIPS Implementation**
```assembly
fib:
    # Base case check: if N ≤ 2, return 1
    slti $t0, $a0, 3      # $t0 = 1 if $a0 < 3
    beq $t0, $0, recursive # if N >= 3, go recursive
    
    # Base case: return 1
    li $v0, 1
    jr $ra
    
recursive:
    # Save state on stack
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    
    # Call fib(N-1)
    addi $a0, $a0, -1
    jal fib
    
    # Save result
    addi $sp, $sp, -4
    sw $v0, 0($sp)
    
    # Restore N-1, then calculate N-2
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    addi $a0, $a0, -2
    
    # Call fib(N-2)
    jal fib
    
    # Add results: $v0 = fib(N-2) + fib(N-1)
    lw $t0, 0($sp)
    add $v0, $v0, $t0
    
    # Restore and return
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
```

**Subsection 2.3.5: Source Code**
Include full implementation with wrapper function to call fib(1) through fib(N)

**Subsection 2.3.6: Call Stack Visualization**
- Show stack frames for fib(4):
  ```
  Call 1: fib(4)
    [sp+4]: $ra = address of main
    [sp+0]: $a0 = 4
    ↓ calls fib(3)
    
  Call 2: fib(3) 
    [sp+12]: $ra = address after jal in fib(4)
    [sp+8]: $a0 = 3
    ↓ calls fib(2)
    
  Call 3: fib(2) - Base case!
    Returns 1 to fib(3)
  ```

**Subsection 2.3.7: Performance Analysis**
- **Time Complexity:** O(2^N) - exponential!
  - Each call branches into 2 subcalls
  - Total calls ≈ 2^N
  
- **Why is it slow?**
  - Recomputes same values many times
  - fib(5) calls fib(3) twice, fib(2) three times
  
- **Practical limits:**
  - fib(20): ~10,000 calls - OK
  - fib(30): ~2 million calls - slow
  - fib(40): ~2 billion calls - very slow!

**Subsection 2.3.8: Recursion vs Iteration Comparison**
| Aspect | Iterative (2.2) | Recursive (2.3) |
|--------|---|---|
| Time complexity | O(N) | O(2^N) |
| Space complexity | O(1) | O(N) - stack |
| Code complexity | Low | Medium |
| Understandability | High | Low |
| Performance | Excellent | Poor for N>30 |
| Mathematical elegance | Low | High |

**Subsection 2.3.9: Key Learning Points**
- Function recursion mechanics
- Stack frame discipline
- Base case vs recursive case
- Return address preservation
- Understanding call stacks
- Trade-offs: elegance vs efficiency

**Subsection 2.3.10: Extensions**
- Memoization: cache results to speed up
- Tail recursion: optimization technique
- Convert to iteration: solve efficiency

---

### Conclusion Section (2-3 pages)

**Summary of Key Concepts Learned**
- Assembly language fundamentals
- Procedural programming in low-level languages
- Recursion and iteration patterns
- Register and memory management
- System calls and I/O

**Reflection on Exercises**
- Compare all 6 implementations
- Discuss trade-offs between approaches
- Real-world applicability

**Recommendations for Further Study**
- Advanced topics: exception handling, interrupt service routines
- Optimization techniques
- Debugging with MARS
- 64-bit architecture extensions

---

## REPORT FORMATTING GUIDELINES

**Page Layout:**
- Font: Times New Roman or Arial, 12pt
- Line spacing: 1.5 or double
- Margins: 1 inch all sides
- Code blocks: Monospace font (Courier), 10pt

**Tables:**
- Border all cells
- Shade header row
- Align numeric data right

**Figures/Screenshots:**
- Number sequentially: Figure 1, Figure 2, etc.
- Include captions below each figure
- Reference in text: "As shown in Figure 3..."
- Show register values, memory contents, console output

**Code Listings:**
- Use syntax highlighting or indentation
- Number all lines
- Include comments at key points
- Show complete, working code

**Academic Integrity:**
- Cite references (especially lab manual and tutorials)
- Clearly mark your own work vs. provided examples
- Explain algorithms in your own words
- Document any collaboration (if allowed)

---

## FINAL CHECKLIST BEFORE SUBMISSION

**Code Quality:**
- [ ] All 6 .s files created and tested
- [ ] Code runs without errors in MARS
- [ ] Proper comments throughout
- [ ] Register usage documented
- [ ] Edge cases handled

**Documentation:**
- [ ] Report has all required sections
- [ ] Algorithms explained (pseudocode provided)
- [ ] Implementation details covered
- [ ] Test cases with expected outputs
- [ ] Screenshots included
- [ ] Comparisons between exercises
- [ ] Key learnings documented

**Report Format:**
- [ ] Proper page numbering
- [ ] Table of contents accurate
- [ ] Consistent formatting
- [ ] Figures and tables properly labeled and captioned
- [ ] References included
- [ ] No spelling or grammar errors

**Submission:**
- [ ] All files in one folder/archive
- [ ] README file with instructions
- [ ] PDF report + source code files
- [ ] Double-check file naming conventions
- [ ] Verify file size is reasonable
