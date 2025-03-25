.data
.text
    .globl  main
main:
    ori     $t1,    $t1,    0x1     # Load the value 0x1 into register $t1
    sll     $t2,    $t1,    1       # Shift the value in $t1 left by 1 bit and store it in $t2
    or      $t3,    $t2,    $t1     # t3 = 0x0011 = 0x3
    sll     $t4,    $t3,    2       # t4 = 0x1100 = 0xC
    or      $t5,    $t4,    $t3     # t5 = 0x1111 = 0xF
    sll     $t6,    $t5,    4       # t6 = 0x11110000 = 0xF0
    or      $t7,    $t6,    $t5     # t7 = 0x11111111 = 0xFF
    sll     $t8,    $t7,    8       # t8 = 0x1111111100000000 = 0xFF00
    or      $t9,    $t8,    $t7     # t9 = 0x1111111111111111 = 0xFFFF

    #clear the value of t1, t2, t3, t4, t5, t6, t7, t8,
    and     $t1,    $t1,    $zero
    and     $t2,    $t2,    $zero
    and     $t3,    $t3,    $zero
    and     $t4,    $t4,    $zero
    and     $t5,    $t5,    $zero
    and     $t6,    $t6,    $zero
    and     $t7,    $t7,    $zero
    and     $t8,    $t8,    $zero

    # put 0xFFFFFFFF in t1
    or      $t1,    $t1,    $t9
    sll     $t1,    $t1,    16
    or      $t1,    $t1,    $t9

    # Exit the program
    li      $v0,    10              
    syscall                         