simpleIf:
nop
slt $t1, $a0, $a1
beq  $t1,$0, Else
nop
add $v0 ,$a0 , $a1
j  Endif
nop
Else:
	sub $v0, $a0, $a1
Endif:
jr $ra
nop
	# Diese Zeilen m�ssen die letzten Zeilen sein -- nicht �ndern!
	.eqv program_under_test simpleIf
	.include "testbench.asm"			
	.include "testdata_simpleIf.asm"
	
	
