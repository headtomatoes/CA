.data
.text
.globl main
main: 
	lui $t1, 0xDEAD #load the upper 16 bits to t1
					# result t1=0xDEAD0000
	ori $t1,$t1,0xBEEF # or bit the lower 16 bits of t1, 0xBEEF
						# result is stored in t1
jr $ra