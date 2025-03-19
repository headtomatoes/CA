.data
lname:  .asciiz "Dam"
fname:  .asciiz " Nguyen Trong Le\n"


.text
        .globl  main

main:
    la      $a0,    lname
    li      $v0,    4
    syscall

    la      $a0,    fname
    li      $v0,    4
    syscall

    li      $v0,    10
    syscall