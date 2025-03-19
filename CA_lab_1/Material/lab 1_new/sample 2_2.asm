.data # Put Global Data here
N: .word 5 # loop count
X: .word 2,4,6,8,10 # array of numbers to be added
SUM: .word 0 # location of the final sum
str: .asciiz "The sum of the array is = \n" # string to print (with newline)

.text # Put program here
.globl main # globally define 'main'

main:
    lw $s0, N # load loop counter into $s0
    la $t0, X # load the address of X into $t0
    and $s1, $s1, $zero # clear $s1 (temp sum)

loop:
    lw $t1, 0($t0) # load the next value of X
    add $s1, $s1, $t1 # add it to the running sum
    addi $t0, $t0, 4 # increment to the next address
    addi $s0, $s0, -1 # decrement the loop counter
    bne $0, $s0, loop # loop back until complete

    sw $s1, SUM # store the final total

    # Print the result
    li $v0, 4 # syscall for "print string"
    la $a0, str # load address of the string
    syscall # print the string

    li $v0, 1 # syscall for "print integer"
    lw $a0, SUM # load the sum into $a0
    syscall # print the sum

    # Exit the program
    li $v0, 10 # syscall to exit
    syscall
