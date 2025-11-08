.text
.globl main
main:
    addiu $t0,$zero,5
    addu  $a0,$t0,$zero
    addiu $v0,$zero,1
    syscall

    addiu $v0,$zero,10
    syscall
