.data                                               # the data segment
prompt:     .asciiz "Guess a number (1 - 1000): "
win:        .asciiz "You win!!\n"
lose:       .asciiz "You lose!!\n"
newline:    .asciiz "\n"

.text                                               # the code segment
            .globl  main
main:

    li      $t0,    0x1fa     # 506 in decimal 

while:
    # print out the prompt
    la      $a0,    prompt
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5
    syscall
    move    $t1,    $v0

    beq    $t0,    $t1,   exit

    # print out "lose"
    la      $a0,    lose
    li      $v0,    4
    syscall
    
    j       while
exit:
    # print out "win"
    la      $a0,    win
    li      $v0,    4
    syscall
    
    li $v0 10
    syscall                                  