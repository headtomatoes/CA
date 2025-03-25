.data
.text
    .globl  main
main:
    lui     $t1,    0xABC2
    ori     $t1,    $t1,    0x2240
    ori     $t4,    $zero,  0xF
    
    and 	$t2,	$t2,	$zero       #clear the value of t2
    and 	$t3,	$t3,	$zero       #clear the value of t3

    and     $t3,    $t1,    $t4         
    or      $t2,    $t2,    $t3         
    sll     $t2,    $t2,    4          
    srl     $t1,    $t1,    4           

    and     $t3,    $t1,    $t4          
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3 
    sll     $t2,    $t2,    4  
    srl     $t1,    $t1,    4  

    and     $t3,    $t1,    $t4 
    or      $t2,    $t2,    $t3         # or bit the last 4 bits of t1 to t2
    srl     $t1,    $t1,    4           # clear the last 4 bits of t1
    srl     $t3,    $t3,    4           # clear t3

    jr      $ra