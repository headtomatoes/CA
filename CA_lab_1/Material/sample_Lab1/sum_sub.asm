.data
msgresult: .asciiz "the result of addtion and subtraction:  \n"
msgFullname: .asciiz "Fullname:  \n"
.text
.globl main
main:
#print fullname
la $a0,msgFullname
li $v0,4
syscall
#input the first number
li $v0,5
syscall
move $t0,$v0
#input the second number
li $v0,5
syscall
move $t1,$v0
# add
add $t2,$t1,$t0 # t2=t1+t0
#sub
sub $t3,$t1,$t0 #t3=t1-t0

#print message 
la $a0,msgresult
li $v0,4
syscall
#print the addition
move $a0, $t2
li $v0,1
syscall
#print the sybtraction
move $a0, $t3
li $v0,1
syscall
#exit
li $v0,10
syscall
