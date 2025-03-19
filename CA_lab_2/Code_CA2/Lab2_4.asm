.data                                                           # the data segment
prompt_input:       .asciiz "Input a string (limit 100 char): "
prompt_output:      .asciiz "Output: "
newline:            .asciiz "\n"

is_space:           .word   1

user_input:         .space  100
user_input_length:  .word   100

.text                                                           # the code segment
                    .globl  main
main:
    # Print prompt for input
    li      $v0,            4
    la      $a0,            prompt_input
    syscall

    # Read user input string
    li      $v0,            8
    la      $a0,            user_input
    lw      $a1,            user_input_length
    syscall

    # Initialize registers
    la      $t0,            user_input                          # $t0 = address of the string
    li      $t1,            1                                   # $t1 = is_space flag (start with 1 to capitalize first letter)

process_string:
    lb      $t2,            0($t0)                              # Load current character 1 byte = 255 > 'z' which is 122
    beqz    $t2,            finish                              # If null terminator character, finish

    # Check if character is a space
    li      $t3,            32                                  # ASCII for space
    beq     $t2,            $t3,                found_space
    li      $t3,            9                                   # ASCII for tab
    beq     $t2,            $t3,                found_space
    li      $t3,            10                                  # ASCII for newline
    beq     $t2,            $t3,                found_space

    # If not a space, check if we need to capitalize
    beqz    $t1,            not_first_letter

    # Check if lowercase letter (97-122 in ASCII)
    slti    $t4,            $t2,                123             # $t4 = 1 if character < 123
    slti    $t5,            $t2,                97              # $t5 = 1 if character < 97
    sub     $t4,            $t4,                $t5             # $t4 = 1 if 97 <= character < 123

    beqz    $t4,            not_lowercase                       # If not lowercase, skip

    # Convert lowercase to uppercase (subtract 32)
    sub     $t2,            $t2,                32
    sb      $t2,            0($t0)                              # Store back the capitalized letter

not_lowercase:
    li      $t1,            0                                   # Reset is_space flag
    j       continue

found_space:
    li      $t1,            1                                   # Set is_space flag
    j       continue

not_first_letter:
    # Not a first letter, do nothing

continue:
    addi    $t0,            $t0,                1               # Move to next character
    j       process_string

finish:
    # Print output prompt
    li      $v0,            4
    la      $a0,            prompt_output
    syscall

    # Print modified string
    li      $v0,            4
    la      $a0,            user_input
    syscall

    # Print newline
    li      $v0,            4
    la      $a0,            newline
    syscall

exit:
    # terminate the program
    li      $v0,            10
    syscall