    #================================================================
    #Author:       DAM NGUYEN TRONG LE
    #ID:           [Your Student ID - e.g., ITITIU22240]
    #Lab:          Lab 5
    #Date:         17/04/2025
    #Calculates the sum of natural numbers from 1 to n
    #using recursion, translating the C code:
    #int recSum(int n) {
    #    if (n <= 1) return n;
    #    return n + recSum(n - 1);
    #}
    #
    #Test Input:   n = last two digits of ID = ITITIU22240 = 40
    #Test Output expected:  Sum(1..40) = 820
    #================================================================

.data
n:          .word   40
prompt_msg: .asciiz "Calculating recursive sum for n = "
result_msg: .asciiz "\nSum(1.."
colon_msg:  .asciiz ") = "
newline:    .asciiz "\n"

.text
            .globl  main

main:
    #Load n from data section
    lw      $a0,        n       

    #Print the input value =
    li      $v0,        4       
    la      $a1,        prompt_msg            
    move    $t0,        $a0     
    move    $a0,        $a1     
    syscall

    move    $a0,        $t0     
    li      $v0,        1       
    syscall

    jal     recSum#call recSum(n)

    #Print the result 
    move    $t0,        $v0
    lw      $t1,        n

    li      $v0,        4
    la      $a0,        result_msg
    syscall

    move    $a0,        $t1
    li      $v0,        1
    syscall

    li      $v0,        4
    la      $a0,        colon_msg
    syscall

    move    $a0,        $t0
    li      $v0,        1
    syscall

    li      $v0,        4
    la      $a0,        newline
    syscall

    #Exit program ---
    li      $v0,        10
    syscall


recSum:
    addi    $sp,        $sp,        -8        #Decrement stack pointer to allocate space for 2 words
    #1 for $ra, 1 for original n ($a0)

    #Save registers onto the stack
    sw      $ra,        4($sp)  #Save $ra at offset +4 from the new $sp
    sw      $a0,        0($sp)  #Save original n ($a0) at offset +0 

    #Check if (n <= 1) for base case
    li      $t0,        1
    ble     $a0,        $t0,        base_case

    #recursive call until base case is reached
    addi    $a0,        $a0,        -1        #$a0 = n - 1

    jal     recSum#Call recSum(n - 1) => result stored in $v0


    lw      $t1,        0($sp)  #Restore original n from stack into $t1

    add     $v0,        $t1,        $v0       #$v0(final result) = n ($t1) + recSum(n - 1) result ($v0)

    j       stackClean           

base_case:
    move    $v0,        $a0     #If n <= 1, return n ($a0) as the result
        
stackClean: #Clean up the stack and return to the caller

    lw      $a0,        0($sp)  #Restore original value of n into $a0 
    lw      $ra,        4($sp)  #Restore the original return address

    addi    $sp,        $sp,        8         #Increment stack pointer back up

    #Use jr to return after the function call = line 43 
    jr      $ra   