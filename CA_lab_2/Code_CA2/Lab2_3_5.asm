.data                                               # the data segment
prompt:     .asciiz "Guess a number (1 - 1000): "
stop_prompt: .asciiz "If you want to stop the game, type 1111: "
end_prompt: .asciiz "The game is over\n"
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

    beq    $t0,    $t1,   WIN

    # print out "lose"
    la      $a0,    lose
    li      $v0,    4
    syscall
    
    # print out the stop_prompt
    la      $a0,    stop_prompt
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5
    syscall
    move    $t1,    $v0

    beq    $t1,    1111,   exit

    j       while

WIN:
    # print out "win"
    la      $a0,    win
    li      $v0,    4
    syscall
                                     
exit:
    # print out "end_prompt"
    la      $a0,    end_prompt
    li      $v0,    4
    syscall
    
    # terminate the program
    li $v0 10
    syscall                                   