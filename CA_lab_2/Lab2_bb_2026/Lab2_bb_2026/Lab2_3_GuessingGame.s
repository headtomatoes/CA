.data
msg_in:  .asciiz "Guess (neg to quit): "
msg_win: .asciiz "WIN\n"
msg_low: .asciiz "LOW\n"
msg_high:.asciiz "HIGH\n"

.text
.globl main
main:
    li   $t0,37

LOOP:
    la   $a0,msg_in
    li   $v0,4
    syscall

    li   $v0,5
    syscall
    move $t1,$v0

    slt  $t2,$t1,$zero
    bne  $t2,$zero,END

    beq  $t1,$t0,WIN

    slt  $t3,$t1,$t0
    bne  $t3,$zero,LOW

    la   $a0,msg_high
    li   $v0,4
    syscall
    j    LOOP

LOW:
    la   $a0,msg_low
    li   $v0,4
    syscall
    j    LOOP

WIN:
    la   $a0,msg_win
    li   $v0,4
    syscall

END:
    li   $v0,10
    syscall
