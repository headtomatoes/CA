.data
buf:     .space 128
prompt:  .asciiz "Enter a line: "
nl:      .asciiz "\n"

.text
.globl main
main:
    la   $a0,prompt
    li   $v0,4
    syscall

    la   $a0,buf
    li   $a1,128
    li   $v0,8
    syscall

    li   $t2,1
    li   $t0,0

LOOP:
    addu $t3,$t0,$zero
    lb   $t1,buf($t3)
    beq  $t1,$zero,PRINT

    beq  $t2,$zero,SKIP_CHECK

    li   $t4,'a'
    slt  $t5,$t1,$t4
    bne  $t5,$zero,SKIP_CHECK

    li   $t4,'z'+1
    slt  $t5,$t1,$t4
    beq  $t5,$zero,SKIP_CHECK

    addi $t1,$t1,-32
    sb   $t1,buf($t3)

SKIP_CHECK:
    li   $t4,' '
    bne  $t1,$t4,NOT_SPACE
    li   $t2,1
    j    NEXT
NOT_SPACE:
    li   $t2,0

NEXT:
    addiu $t0,$t0,1
    j     LOOP

PRINT:
    la   $a0,buf
    li   $v0,4
    syscall

    la   $a0,nl
    li   $v0,4
    syscall

    li   $v0,10
    syscall
