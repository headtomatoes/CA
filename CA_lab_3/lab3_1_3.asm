.data
.text
    .globl  main
main:
    and 	$t1,	$t1,	$zero     #clear the value of t1
    and 	$t2,	$t2,	$zero     #clear the value of t2
    and 	$t3,	$t3,	$zero     #clear the value of t3

	sll 	$t1,	$t1,	16      #shift t1 left by 16 bits

    ori     $t1,    $t1,    0xABC2  #load the upper 16 bits to t1
    								# result t1=0xABC22240
	sll 	$t1,	$t1,	16

    ori     $t1,    $t1,    0x2240  # or bit the lower 16 bits of t1, 0xBEEF
    								# result is stored in t1
    andi    $t3,    $t1,    0xF  # mask the lower 4 bits of t1 => t3(temporary register) for storing the last 4 bits of t1
    
    or      $t2,    $t2,    $t3  # or bit the last 4 bits of t1 to t2
    sll     $t2,    $t2,    4  # shift t2 left by 4 bits
    srl     $t1,    $t1,    4  # shift t1 right by 4 bits

    andi    $t3,    $t1,    0xF 
n
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    andi    $t3,    $t1,    0xF 

    or      $t2,    $t2,    $t3    # or bit the last 4 bits of t1 to t2
    srl     $t1,    $t1,    4       # clear the last 4 bits of t1
    srl     $t3,    $t3,    4       # clear t3

    jr      $ra