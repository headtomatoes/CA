Mode2:
    # print out the prompt: "Enter the value of i: " --> line 12
    la      $a0,    subprompt
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5                                                                                           # input the integer from keyboard, user input it the keyboard, the number is stored into v0
    syscall                                                                                                     # store the value from keyboard to v0 register
    move    $t1,    $v0                                                                                         # copy the value of $v0 to $t1

    # print out the prompt: "Enter the value of j: " --> line 16
    la      $a0,    subprompt2
    li      $v0,    4
    syscall

    # read in an integer
    li      $v0,    5                                                                                           # input the integer from keyboard, user input it the keyboard, the number is stored into v0
    syscall                                                                                                     # store the value from keyboard to v0 register
    move    $t2,    $v0   