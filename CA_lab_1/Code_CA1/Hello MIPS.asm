.data                               # "data section" (global mutable data)
str:    .asciiz "Hello, MIPS!\n"    # Null-terminated string
flabel: .float  3.14                # Single-precision floating-point number
dlabel: .double 3.1415926           # Double-precision floating-point number
arr:    .word   1, 2, 3, 4, 5       # Array of integers
buffer: .space  80                  # Buffer for reading strings

.text                               # "text section" (executable code)
        .globl  main                # Expose `main` as a global symbol for the simulator/OS

main:
    #2.1 Print Integer
    li      $a0,    89
    li      $v0,    1
    syscall

    # Print a newline
    li      $a0,    10              # ASCII code for newline
    li      $v0,    11              # Print character
    syscall

    #2.2 Print Float
    l.s     $f12,   flabel
    li      $v0,    2
    syscall

    # Print a newline
    li      $a0,    10
    li      $v0,    11
    syscall

    #2.3 Print Double
    l.d     $f12,   dlabel          # Use l.d for loading double
    li      $v0,    3
    syscall

    # Print a newline
    li      $a0,    10
    li      $v0,    11
    syscall

    #2.4 Print String
    la      $a0,    str             # Load address of the string into $a0
    li      $v0,    4               # Set $v0 = 4 (syscall code for "print string")
    syscall                         # Print the string

    #2.5 Read Integer
    li      $v0,    5
    syscall
    move    $t0,    $v0             # Save the read integer to $t0

    #2.6 Read Float
    li      $v0,    6
    syscall
    # The float is now in $f0

    #2.7 Read Double
    li      $v0,    7
    syscall
    # The double is now in $f0-$f1

    #2.8 Read String
    la      $a0,    buffer          # Address to store the string
    li      $a1,    80              # Maximum number of characters
    li      $v0,    8
    syscall

    # Print the string we just read
    la      $a0,    buffer
    li      $v0,    4
    syscall

    #2.9 Sbrk (Dynamic memory allocation)
    li      $a0,    80              # Allocate 80 bytes
    li      $v0,    9
    syscall                         # Get memory
    move    $s0,    $v0             # Save the address to $s0
    
    # Read string into the allocated memory
    move    $a0,    $s0             # Address to store the string
    li      $a1,    80              # Maximum number of characters
    li      $v0,    8
    syscall                         # Read String
    
    # Print the string from allocated memory
    move    $a0,    $s0
    li      $v0,    4
    syscall                         # Print String

    #2.10 Exit
    li      $v0,    10              # Set $v0 = 10 (syscall code for "exit")
    syscall                         # Terminate the program