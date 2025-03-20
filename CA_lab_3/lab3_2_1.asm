.data
    # Data section where variables are declared

.text
    .globl  main
    # Main program starts here
main:
    ori     $t1,    $t1,    0x1 # Load the value 0x1 into register $t1
    sll     $t2,    $t1,    1   # Shift the value in $t1 left by 1 bit and store it in $t2
    sll     $t3,    $t2,    1
    sll     $t4,    $t3,    1
    sll     $t5,    $t4,    1
    sll     $t6,    $t5,    1
    sll     $t7,    $t6,    1
    sll     $t8,    $t7,    1

    # Exit the program
    li      $v0,    10          # Load the exit system call code into $v0
    syscall                     # Make the system call