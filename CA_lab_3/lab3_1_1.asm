.data
.text
    .globl  main
main:
	andi 	$t1,	$t1,	0x0     #clear the value of t1
	sll 	$t1,	$t1,	16      #shift t1 left by 16 bits

    ori     $t1,    $t1,    0xABC2  #load the upper 16 bits to t1
    								# result t1=0xABC22240
	sll 	$t1,	$t1,	16

    ori     $t1,    $t1,    0x2240  # or bit the lower 16 bits of t1, 0xBEEF
    								# result is stored in t1

    jr      $ra