.data
.text
    .globl  main
main:
	andi 	$t1,	$t1,	0x0     #clear the value of t1

    ori     $t1,    $t1,    0xABC2  #load the upper 16 bits to t1
    								#t1=0x0000ABC2
	
	sll 	$t1,	$t1,	16		#shift the value of t1 to the left by 16 bits
									#t1=0xABC20000

    ori     $t1,    $t1,    0x2240  # or bit the lower 16 bits of t1, 0x2240
    								#t1=0xABC22240

    jr      $ra