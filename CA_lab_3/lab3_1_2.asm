.data
.text
    .globl  main
main:
    and     $t1,    $t1,    $zero   # Clear $t1
    ori     $t1,    $t1,    0xA
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0xB
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0xC
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0x2
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0x2
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0x2
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0x4
    sll     $t1,    $t1,    4
    ori     $t1,    $t1,    0x0

    #printing the value of $t1
    li      $v0,    1
    move    $a0,    $t1
    syscall

    # Exit the program
    li      $v0,    10
    syscall
