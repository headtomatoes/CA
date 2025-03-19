.data                                       # the data segment
result:     .asciiz "The value in $t0 is: "
newline:    .asciiz "\n"

.text                                       # the code segment
            .globl  main
main:
    # write number 5 to register $t0
    # li $t0,5
    # ori $t8, $0, 5
    li      $t0,     -5

    # print out the value of $t0
    la      $a0,    result                  # load the argument string
    li      $v0,    4                       # set the system call to 4 (print)
    syscall                                 # print the string

    move    $a0,    $t0                     # load the argument string
    li      $v0,    1                       # set the system call to 1 (print integer)
    syscall                                 # print the string

    la      $a0,    newline                 # load the argument string
    li      $v0,    4                       # set the system call to 4 (print)
    syscall                                 # print the string

    jr      $ra                             # return to caller (__start)
