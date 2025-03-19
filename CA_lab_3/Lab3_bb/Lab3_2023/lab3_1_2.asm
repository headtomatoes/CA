.data
.text
.globl main
main: 
	ori $t1,$t1,0xD
	sll $t1,$t1,4
	ori $t1,$t1,0xE
	sll $t1,$t1,4
	ori $t1,$t1,0xA
	sll $t1,$t1,4
	ori $t1,$t1,0xD
	sll $t1,$t1,4
	ori $t1,$t1,0xB
	sll $t1,$t1,4
	ori $t1,$t1,0xE
	sll $t1,$t1,4
	ori $t1,$t1,0xE
	sll $t1,$t1,4
	ori $t1,$t1,0xF
	jr $ra