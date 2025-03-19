.data  # "data section" (global mutable data)
str: .asciiz "Hello, World!\n"   # Null-terminated string

.text  # "text section" (executable code)
.globl main   # Expose `main` as a global symbol for the simulator/OS

main:
    la $a0, str    # Load address of the string into $a0 (argument for syscall)
    li $v0, 4      # Set $v0 = 4 (syscall code for "print string")
    syscall         # Print the string

    li $v0, 10     # Set $v0 = 10 (syscall code for "exit")
    syscall         # Terminate the program
