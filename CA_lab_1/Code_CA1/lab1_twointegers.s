.data                                           # the data segment
prompt_1:   .asciiz "Enter first integer: "
prompt_2:   .asciiz "Enter second integer: "
addresult:  .asciiz "The addition is: "
subresult:  .asciiz "\nThe subtract is: "
newline:    .asciiz "\n"
.text                                           # the code segment
            .globl  main
main:
    # print out the prompt
    la      $a0,    prompt_1
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5
    syscall
    move    $t0,    $v0

    # print out the prompt
    la      $a0,    prompt_2
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5
    syscall
    move    $t1,    $v0

    # calculate
    add     $t3,    $t0,        $t1
    sub     $t4,    $t0,        $t1

    # print out the result message
    la      $a0,    addresult
    li      $v0,    4
    syscall

    # print out the add result
    move    $a0,    $t3
    li      $v0,    1
    syscall

    # print out the result message
    la      $a0,    subresult
    li      $v0,    4
    syscall

    # print out the add result
    move    $a0,    $t4
    li      $v0,    1
    syscall

    # print out the newline
    la      $a0,    newline
    li      $v0,    4
    syscall

    jr      $ra                                 # return to caller (__start)