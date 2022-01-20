squareRoot:
add $t0 , $0 , $a0
nop 
Do:
add $v0 , $0 , $t0
div $t1 , $a0 , $v0
add $t0 , $t1 , $v0
div $t0 , $t0 , 2
slt $t2 , $t0 , $v0
bgtz $t2 , Do
nop 
jr $ra
nop


	# Diese Zeilen müssen die letzten Zeilen sein -- nicht ändern!
	.eqv program_under_test squareRoot
	.include "testbench.asm"			
	.include "testdata_squareRoot.asm"
