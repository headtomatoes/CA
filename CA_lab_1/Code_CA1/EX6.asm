    # -------------------- Data Declarations --------------------- #
.data
array:      .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20

length:     .word   20

space:      .asciiz " "
    # ------------------- Text/Code section ---------------------- #

    # Basic approach: use Stack to reverse the array => First in, Last out
    # - loop to push each element onto the stack
    # - loop to pop each element off the stack
    # Final result is all elements reversed

.text

main:
    # ------------------------------------------------------------ #
    # Loop to read items from array and push to stack.
    la      $t0,    array                               # Load address A[0] of the array into $t0
    li      $t1,    0                                   # Init loop index, i = 0 into $t1
    lw      $t2,    length                              # Load length into $t2

    # $t0 = address of array[i]
    # $t1 = index i
    # $t2 = length of array

    # ------------------------------------------------------------ #

PushLoop:
    lw      $t4,    ($t0)                               # get array[i] into $t4
    addiu   $sp,    $sp,    -4                          # push array[i] onto stack | $sp = $sp - 4 
    sw      $t4,    ($sp)                               # store/push array[i] into stack

    addi    $t1,    $t1,    1                           # i = i + 1 | increment loop index
    addi    $t0,    $t0,    4                           # update array address by 4 bytes = 1 word | ex: 0x1000 -> 0x1004

    blt     $t1,    $t2,    PushLoop                    # blt = branch if less than | if index i < length => continue to loop to line 34

    # ------------------------------------------------------------ #
    # Loop to pop items from stack and write into array.
    la      $t0,    array                               # array starting address
    li      $t1,    0                                   # reset the loop index, i=0

    lw      $t2,    length                              # length 
    # ------------------------------------------------------------ #

PopLoop:
    lw      $t4,    ($sp)                               # get array[i] from stack into $t4
    addiu   $sp,    $sp,    4                           # increment stack pointer by 4 bytes | $sp = $sp + 4 | remove the top element from stack
    sw      $t4,    ($t0)                               # store array[i] from $t4 into array address $t0

    addi    $t1,    $t1,    1                           # i = i+1
    addi    $t0,    $t0,    4                           # update array address

    blt     $t1,    $t2,    PopLoop                     # if i<length, continue
    
    # ------------------------------------------------------------ #
    # re-init all registers
    la      $t0,    array                               
    li      $t1,    0
    lw      $t2,    length
    # ------------------------------------------------------------ #
LoopArray:
    lw      $a0,    ($t0)                               # Load the value at the address pointed to by $t0 into $t1
    
    # Print the value of Array[i]
    li      $v0,    1                                   # Set up syscall for print_int
    syscall                                             

    # Print a space
    li      $v0,    4                                   # Set up syscall for print_string
    la      $a0,    space                               # Load address of space character
    syscall                                             # Print a space
    
    # Increment the array pointer and loop index
    addi    $t0,    $t0,    4                           # Increment the array pointer by 4 bytes
    addi    $t1,    $t1,    1                           # Increment the loop index by 1
    
    # Check if we have reached the end of the array
    blt     $t1,    $t2,    LoopArray                   # If i < length, continue looping
    
    # ------------------------------------------------------------ #
    li      $v0,    10                                  # terminate
    syscall                                             
