.data
msg_gt:   .asciiz "greater\n"
msg_eq:   .asciiz "equal\n"
msg_lt:   .asciiz "less\n"

.text
.globl main
main:
    li   $v0,5
    syscall
    move $t1,$v0
    li   $t0,5

    slt  $t2,$t0,$t1
    bne  $t2,$zero,PRINT_GT
    beq  $t1,$t0,PRINT_EQ

    la   $a0,msg_lt
    li   $v0,4
    syscall
    j    END

PRINT_GT:
    la   $a0,msg_gt
    li   $v0,4
    syscall
    j    END

PRINT_EQ:
    la   $a0,msg_eq
    li   $v0,4
    syscall

END:
    li   $v0,10
    syscall
