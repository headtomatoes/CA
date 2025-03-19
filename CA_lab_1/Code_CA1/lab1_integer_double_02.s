.data                                   # the data segment
prompt: .asciiz "Enter an integer: "
result: .asciiz "The result is: "

.text                                   # the code segment
        .globl  main
main:
    # print out the prompt
    la      $a0,    prompt
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5
    syscall
    move    $t0,    $v0

    # get first byte using AND logical
    andi    $t0,    $t0,    255

    # print out the result message
    la      $a0,    result
    li      $v0,    4
    syscall

    # print out the doubled integer
    move    $a0,    $t0
    li      $v0,    1
    syscall

    jr      $ra                         # return to caller (__start)
